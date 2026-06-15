-- =============================================================================
-- Procedure 2: recalculate account statuses from betting exposure
-- =============================================================================
-- Uses explicit cursor, records, loop, branching, DML and exception handling.

CREATE OR REPLACE PROCEDURE proc_recalculate_user_statuses(
    p_high_pending_amount NUMERIC DEFAULT 2000,
    p_low_balance NUMERIC DEFAULT 500,
    p_max_users INT DEFAULT 100
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_rec RECORD;
    v_new_status VARCHAR(20);
    v_reason VARCHAR(300);
    v_changed_count INT := 0;

    status_cur CURSOR FOR
        SELECT
            u.user_id,
            u.balance,
            u.account_status,
            COUNT(b.bet_id) AS bet_count,
            COALESCE(SUM(CASE WHEN b.bet_status = 'Pending' THEN b.bet_amount ELSE 0 END), 0) AS pending_amount,
            COUNT(CASE WHEN b.bet_status = 'Lost' THEN 1 END) AS lost_bets,
            COUNT(CASE WHEN b.bet_status = 'Won' THEN 1 END) AS won_bets
        FROM users u
        LEFT JOIN bets b
            ON b.user_id = u.user_id
        GROUP BY u.user_id, u.balance, u.account_status
        ORDER BY COALESCE(SUM(CASE WHEN b.bet_status = 'Pending' THEN b.bet_amount ELSE 0 END), 0) DESC,
                 u.user_id
        LIMIT p_max_users;
BEGIN
    IF p_max_users IS NULL OR p_max_users <= 0 THEN
        RAISE EXCEPTION 'p_max_users must be positive. Received: %', p_max_users;
    END IF;

    OPEN status_cur;

    LOOP
        FETCH status_cur INTO v_user_rec;
        EXIT WHEN NOT FOUND;

        v_new_status := v_user_rec.account_status;
        v_reason := NULL;

        IF v_user_rec.pending_amount >= p_high_pending_amount
           OR (v_user_rec.balance <= p_low_balance AND v_user_rec.lost_bets > v_user_rec.won_bets) THEN
            v_new_status := 'Blocked';
            v_reason := 'High pending exposure or low balance with weak betting result';
        ELSIF v_user_rec.bet_count = 0 THEN
            v_new_status := 'Inactive';
            v_reason := 'No betting activity';
        ELSE
            v_new_status := 'Active';
            v_reason := 'Account passed automatic status review';
        END IF;

        IF v_new_status IS DISTINCT FROM v_user_rec.account_status THEN
            UPDATE users
            SET account_status = v_new_status
            WHERE user_id = v_user_rec.user_id;

            v_changed_count := v_changed_count + 1;

            IF v_new_status = 'Blocked' THEN
                INSERT INTO risk_review_queue (user_id, risk_score, reason, status)
                VALUES (v_user_rec.user_id, 90, v_reason, 'Open');
            END IF;
        END IF;
    END LOOP;

    CLOSE status_cur;
    RAISE NOTICE 'proc_recalculate_user_statuses changed % users', v_changed_count;
EXCEPTION
    WHEN OTHERS THEN
        IF status_cur IS NOT NULL THEN
            CLOSE status_cur;
        END IF;
        RAISE NOTICE 'proc_recalculate_user_statuses failed: %', SQLERRM;
        RAISE;
END;
$$;
