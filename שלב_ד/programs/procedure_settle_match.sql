-- =============================================================================
-- Procedure 1: settle a match and pay winning bets
-- =============================================================================
-- Uses records, explicit cursor, loops, branching, several DML commands and
-- exception handling.

CREATE OR REPLACE PROCEDURE proc_settle_match(
    p_match_id INT,
    p_final_result VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_match_rec RECORD;
    v_winning_bet RECORD;
    v_payout NUMERIC(12,2);
    v_total_paid NUMERIC(12,2) := 0;
    v_winners_count INT := 0;
    v_losers_count INT := 0;
    v_next_transaction_id INT;

    winning_bets_cur CURSOR FOR
        SELECT
            b.bet_id,
            b.user_id,
            b.bet_amount,
            b.predicted_result,
            CASE b.predicted_result
                WHEN 'Home' THEN o.home_win_odd
                WHEN 'Draw' THEN o.draw_odd
                WHEN 'Away' THEN o.away_win_odd
            END AS selected_odd
        FROM bets b
        JOIN odds o
            ON o.match_id = b.match_id
        WHERE b.match_id = p_match_id
          AND b.bet_status = 'Pending'
          AND b.predicted_result = p_final_result
        ORDER BY b.bet_id;
BEGIN
    IF p_final_result NOT IN ('Home', 'Draw', 'Away') THEN
        RAISE EXCEPTION 'Invalid final result %. Expected Home, Draw or Away', p_final_result;
    END IF;

    SELECT *
    INTO v_match_rec
    FROM matches
    WHERE match_id = p_match_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Match % was not found', p_match_id;
    END IF;

    IF v_match_rec.status = 'Finished' AND v_match_rec.final_result IS NOT NULL THEN
        RAISE NOTICE 'Match % is already finished with final_result=%', p_match_id, v_match_rec.final_result;
    END IF;

    SELECT COALESCE(MAX(transaction_id), 0) + 1
    INTO v_next_transaction_id
    FROM transactions;

    UPDATE matches
    SET status = 'Finished',
        final_result = p_final_result
    WHERE match_id = p_match_id;

    OPEN winning_bets_cur;

    LOOP
        FETCH winning_bets_cur INTO v_winning_bet;
        EXIT WHEN NOT FOUND;

        v_payout := ROUND(v_winning_bet.bet_amount * COALESCE(v_winning_bet.selected_odd, 1), 2);

        UPDATE bets
        SET bet_status = 'Won'
        WHERE bet_id = v_winning_bet.bet_id;

        UPDATE users
        SET balance = balance + v_payout
        WHERE user_id = v_winning_bet.user_id;

        INSERT INTO transactions (
            transaction_id,
            amount,
            transaction_type,
            transaction_date,
            user_id
        )
        VALUES (
            v_next_transaction_id,
            v_payout,
            'Winnings',
            CURRENT_DATE,
            v_winning_bet.user_id
        );

        v_next_transaction_id := v_next_transaction_id + 1;
        v_total_paid := v_total_paid + v_payout;
        v_winners_count := v_winners_count + 1;
    END LOOP;

    CLOSE winning_bets_cur;

    UPDATE bets
    SET bet_status = 'Lost'
    WHERE match_id = p_match_id
      AND bet_status = 'Pending'
      AND predicted_result <> p_final_result;

    GET DIAGNOSTICS v_losers_count = ROW_COUNT;

    INSERT INTO match_settlement_log (
        match_id,
        final_result,
        affected_bets,
        paid_winnings,
        details
    )
    VALUES (
        p_match_id,
        p_final_result,
        v_winners_count + v_losers_count,
        v_total_paid,
        'Winners: ' || v_winners_count || ', losers: ' || v_losers_count
    );
EXCEPTION
    WHEN OTHERS THEN
        IF winning_bets_cur IS NOT NULL THEN
            CLOSE winning_bets_cur;
        END IF;
        RAISE NOTICE 'proc_settle_match failed for match %. Error: %', p_match_id, SQLERRM;
        RAISE;
END;
$$;
