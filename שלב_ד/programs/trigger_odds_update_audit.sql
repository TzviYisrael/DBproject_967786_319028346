-- =============================================================================
-- Trigger 2: validate and audit odds updates
-- =============================================================================
-- Required UPDATE trigger.

CREATE OR REPLACE FUNCTION trg_audit_odds_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_max_change NUMERIC(10,2);
BEGIN
    IF NEW.home_win_odd <= 1 OR NEW.draw_odd <= 1 OR NEW.away_win_odd <= 1 THEN
        RAISE EXCEPTION 'Odds must remain greater than 1. odd_id=%', NEW.odd_id;
    END IF;

    v_max_change := GREATEST(
        ABS(COALESCE(NEW.home_win_odd, 0) - COALESCE(OLD.home_win_odd, 0)),
        ABS(COALESCE(NEW.draw_odd, 0) - COALESCE(OLD.draw_odd, 0)),
        ABS(COALESCE(NEW.away_win_odd, 0) - COALESCE(OLD.away_win_odd, 0))
    );

    NEW.update_date := CURRENT_DATE;

    INSERT INTO odds_audit_log (
        odd_id,
        match_id,
        old_home_win_odd,
        new_home_win_odd,
        old_draw_odd,
        new_draw_odd,
        old_away_win_odd,
        new_away_win_odd,
        change_reason
    )
    VALUES (
        OLD.odd_id,
        OLD.match_id,
        OLD.home_win_odd,
        NEW.home_win_odd,
        OLD.draw_odd,
        NEW.draw_odd,
        OLD.away_win_odd,
        NEW.away_win_odd,
        CASE
            WHEN v_max_change >= 1 THEN 'Large odds movement'
            ELSE 'Regular odds update'
        END
    );

    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'trg_audit_odds_update failed for odd %. Error: %', NEW.odd_id, SQLERRM;
        RAISE;
END;
$$;

DROP TRIGGER IF EXISTS odds_audit_update ON odds;

CREATE TRIGGER odds_audit_update
BEFORE UPDATE OF home_win_odd, draw_odd, away_win_odd ON odds
FOR EACH ROW
WHEN (
    OLD.home_win_odd IS DISTINCT FROM NEW.home_win_odd
    OR OLD.draw_odd IS DISTINCT FROM NEW.draw_odd
    OR OLD.away_win_odd IS DISTINCT FROM NEW.away_win_odd
)
EXECUTE FUNCTION trg_audit_odds_update();
