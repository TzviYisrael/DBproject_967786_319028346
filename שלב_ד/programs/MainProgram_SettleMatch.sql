-- =============================================================================
-- Main Program 2
-- Calls one function and one procedure:
--   1. fn_match_financial_summary
--   2. proc_settle_match
-- =============================================================================

BEGIN;

DROP TABLE IF EXISTS stage4_selected_match;

CREATE TEMP TABLE stage4_selected_match AS
SELECT
    b.match_id,
    'Home'::VARCHAR AS settlement_result
FROM bets b
JOIN matches m
    ON m.match_id = b.match_id
WHERE b.bet_status = 'Pending'
GROUP BY b.match_id
ORDER BY COUNT(*) DESC, b.match_id
LIMIT 1;

SELECT 'BEFORE_SETTLEMENT' AS phase, s.*
FROM stage4_selected_match s;

SELECT
    match_id AS selected_match_id,
    settlement_result AS selected_settlement_result
FROM stage4_selected_match
\gset

SELECT *
FROM fn_match_financial_summary(:selected_match_id);

CALL proc_settle_match(
    :selected_match_id,
    :'selected_settlement_result'
);

SELECT *
FROM fn_match_financial_summary(:selected_match_id);

SELECT
    settlement_log_id,
    match_id,
    final_result,
    affected_bets,
    paid_winnings,
    details,
    settled_at
FROM match_settlement_log
WHERE match_id = :selected_match_id
ORDER BY settlement_log_id DESC
LIMIT 5;

COMMIT;
