-- =============================================================================
-- Function 2: match financial summary
-- =============================================================================
-- Uses implicit cursor FOR loop, records, branching, calculations and exception
-- handling. The function can summarize one match or the top pending matches.

CREATE OR REPLACE FUNCTION fn_match_financial_summary(
    p_match_id INT DEFAULT NULL
)
RETURNS TABLE (
    summary_match_id INT,
    home_team VARCHAR,
    away_team VARCHAR,
    match_status VARCHAR,
    final_result VARCHAR,
    total_bets INT,
    pending_bets INT,
    won_bets INT,
    lost_bets INT,
    total_stake NUMERIC,
    potential_liability NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_match_rec RECORD;
    v_multiplier NUMERIC(10,2);
BEGIN
    FOR v_match_rec IN
        SELECT
            m.match_id,
            ht.team_name AS home_team_name,
            at.team_name AS away_team_name,
            m.status,
            m.final_result,
            b.predicted_result,
            b.bet_status,
            b.bet_amount,
            o.home_win_odd,
            o.draw_odd,
            o.away_win_odd
        FROM matches m
        LEFT JOIN teams ht
            ON ht.team_id = m.home_team_id
        LEFT JOIN teams at
            ON at.team_id = m.away_team_id
        LEFT JOIN bets b
            ON b.match_id = m.match_id
        LEFT JOIN odds o
            ON o.match_id = m.match_id
        WHERE p_match_id IS NULL OR m.match_id = p_match_id
        ORDER BY m.match_id
    LOOP
        IF summary_match_id IS DISTINCT FROM v_match_rec.match_id THEN
            IF summary_match_id IS NOT NULL THEN
                RETURN NEXT;
            END IF;

            summary_match_id := v_match_rec.match_id;
            home_team := v_match_rec.home_team_name;
            away_team := v_match_rec.away_team_name;
            match_status := v_match_rec.status;
            final_result := v_match_rec.final_result;
            total_bets := 0;
            pending_bets := 0;
            won_bets := 0;
            lost_bets := 0;
            total_stake := 0;
            potential_liability := 0;
        END IF;

        IF v_match_rec.bet_amount IS NOT NULL THEN
            total_bets := total_bets + 1;
            total_stake := total_stake + v_match_rec.bet_amount;

            IF v_match_rec.bet_status = 'Pending' THEN
                pending_bets := pending_bets + 1;

                v_multiplier := CASE v_match_rec.predicted_result
                    WHEN 'Home' THEN v_match_rec.home_win_odd
                    WHEN 'Draw' THEN v_match_rec.draw_odd
                    WHEN 'Away' THEN v_match_rec.away_win_odd
                    ELSE 1
                END;

                potential_liability := potential_liability + (v_match_rec.bet_amount * COALESCE(v_multiplier, 1));
            ELSIF v_match_rec.bet_status = 'Won' THEN
                won_bets := won_bets + 1;
            ELSIF v_match_rec.bet_status = 'Lost' THEN
                lost_bets := lost_bets + 1;
            END IF;
        END IF;
    END LOOP;

    IF summary_match_id IS NOT NULL THEN
        RETURN NEXT;
    ELSIF p_match_id IS NOT NULL THEN
        RAISE EXCEPTION 'Match % was not found', p_match_id;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'fn_match_financial_summary failed for match %. Error: %', p_match_id, SQLERRM;
        RAISE;
END;
$$;
