-- =============================================================================
-- Stage D execution script
-- =============================================================================
-- Run from psql with:
-- \i שלב_ד/RunAllStage4.sql

\echo '1. Creating supporting tables'
\i שלב_ד/AlterTable.sql

\echo '2. Creating functions'
\i שלב_ד/function_open_user_risk_report.sql
\i שלב_ד/function_match_financial_summary.sql

\echo '3. Creating procedures'
\i שלב_ד/procedure_settle_match.sql
\i שלב_ד/procedure_recalculate_user_statuses.sql

\echo '4. Creating triggers'
\i שלב_ד/trigger_user_account_audit.sql
\i שלב_ד/trigger_odds_update_audit.sql

\echo '5. Running main program 1'
\i שלב_ד/MainProgram_RiskReview.sql

\echo '6. Running main program 2'
\i שלב_ד/MainProgram_SettleMatch.sql

\echo '7. Demonstrating odds UPDATE trigger'
UPDATE odds
SET home_win_odd = home_win_odd + 0.10
WHERE odd_id = (
    SELECT odd_id
    FROM odds
    ORDER BY odd_id
    LIMIT 1
);

SELECT
    odds_audit_id,
    odd_id,
    old_home_win_odd,
    new_home_win_odd,
    change_reason,
    changed_at
FROM odds_audit_log
ORDER BY odds_audit_id DESC
LIMIT 5;

\echo '8. Demonstrating exception handling'
DO $$
DECLARE
    v_match_id INT;
BEGIN
    SELECT MIN(match_id)
    INTO v_match_id
    FROM matches;

    BEGIN
        CALL proc_settle_match(v_match_id, 'InvalidResult');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Expected exception captured in main validation: %', SQLERRM;
    END;
END $$;
