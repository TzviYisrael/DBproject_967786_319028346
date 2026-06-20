-- =============================================================================
-- Function 1: open user risk report as a ref cursor
-- =============================================================================
-- Uses explicit cursor, records, loop, branching, DML, exception handling and
-- returns a ref cursor over the generated review rows.

CREATE OR REPLACE FUNCTION fn_open_user_risk_report(
    p_min_risk_score NUMERIC DEFAULT 50
)
RETURNS REFCURSOR
LANGUAGE plpgsql
AS $$
DECLARE
    v_user_rec RECORD;
    v_risk_score NUMERIC(10,2);
    v_reason VARCHAR(300);
    v_report_cursor REFCURSOR := 'risk_report_cursor';

    user_activity_cur CURSOR FOR
        SELECT
            u.user_id,
            u.full_name,
            u.balance,
            u.account_status,
            COUNT(b.bet_id) AS total_bets,
            COALESCE(SUM(b.bet_amount), 0) AS total_bet_amount,
            COALESCE(SUM(CASE WHEN b.bet_status = 'Pending' THEN b.bet_amount ELSE 0 END), 0) AS pending_amount,
            COUNT(CASE WHEN b.bet_status = 'Won' THEN 1 END) AS won_bets,
            COUNT(CASE WHEN b.bet_status = 'Lost' THEN 1 END) AS lost_bets,
            COALESCE(SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END), 0) AS withdrawals
        FROM users u
        LEFT JOIN bets b
            ON b.user_id = u.user_id
        LEFT JOIN transactions t
            ON t.user_id = u.user_id
        GROUP BY u.user_id, u.full_name, u.balance, u.account_status;
BEGIN
    IF p_min_risk_score < 0 THEN
        RAISE EXCEPTION 'Minimum risk score must be non-negative. Received: %', p_min_risk_score;
    END IF;

    OPEN user_activity_cur;

    LOOP
        FETCH user_activity_cur INTO v_user_rec;
        EXIT WHEN NOT FOUND;

        v_risk_score := 0;
        v_reason := '';

        IF v_user_rec.pending_amount > v_user_rec.balance THEN
            v_risk_score := v_risk_score + 45;
            v_reason := v_reason || 'Pending exposure is greater than balance. ';
        END IF;

        IF v_user_rec.lost_bets > v_user_rec.won_bets * 3 AND v_user_rec.total_bets >= 10 THEN
            v_risk_score := v_risk_score + 25;
            v_reason := v_reason || 'Loss ratio is high. ';
        END IF;

        IF v_user_rec.withdrawals > v_user_rec.balance * 2 AND v_user_rec.withdrawals > 0 THEN
            v_risk_score := v_risk_score + 20;
            v_reason := v_reason || 'Withdrawals are high compared with balance. ';
        END IF;

        IF v_user_rec.account_status <> 'Active' THEN
            v_risk_score := v_risk_score + 15;
            v_reason := v_reason || 'Account is not active. ';
        END IF;

        IF v_risk_score >= p_min_risk_score THEN
            INSERT INTO risk_review_queue (user_id, risk_score, reason, status)
            SELECT v_user_rec.user_id, v_risk_score, COALESCE(NULLIF(v_reason, ''), 'Risk threshold reached'), 'Open'
            WHERE NOT EXISTS (
                SELECT 1
                FROM risk_review_queue rrq
                WHERE rrq.user_id = v_user_rec.user_id
                  AND rrq.status = 'Open'
                  AND rrq.reason = COALESCE(NULLIF(v_reason, ''), 'Risk threshold reached')
            );
        END IF;
    END LOOP;

    CLOSE user_activity_cur;

    OPEN v_report_cursor FOR
        SELECT
            rrq.review_id,
            rrq.user_id,
            u.full_name,
            rrq.risk_score,
            rrq.reason,
            rrq.status,
            rrq.opened_at
        FROM risk_review_queue rrq
        JOIN users u
            ON u.user_id = rrq.user_id
        WHERE rrq.status = 'Open'
          AND rrq.risk_score >= p_min_risk_score
        ORDER BY rrq.risk_score DESC, rrq.opened_at DESC
        LIMIT 25;

    RETURN v_report_cursor;
EXCEPTION
    WHEN OTHERS THEN
        IF user_activity_cur IS NOT NULL THEN
            CLOSE user_activity_cur;
        END IF;
        RAISE NOTICE 'fn_open_user_risk_report failed: %', SQLERRM;
        RAISE;
END;
$$;
