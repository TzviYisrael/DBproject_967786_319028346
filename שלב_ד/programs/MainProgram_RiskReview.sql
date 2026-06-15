-- =============================================================================
-- Main Program 1
-- Calls one function and one procedure:
--   1. fn_open_user_risk_report
--   2. proc_recalculate_user_statuses
-- =============================================================================

BEGIN;

SELECT fn_open_user_risk_report(35) AS opened_cursor;
FETCH ALL IN "risk_report_cursor";

CALL proc_recalculate_user_statuses(1200, 500, 40);

SELECT
    rrq.review_id,
    rrq.user_id,
    u.full_name,
    rrq.risk_score,
    rrq.status,
    rrq.reason
FROM risk_review_queue rrq
JOIN users u
    ON u.user_id = rrq.user_id
WHERE rrq.status = 'Open'
ORDER BY rrq.risk_score DESC, rrq.opened_at DESC
LIMIT 10;

SELECT
    audit_id,
    user_id,
    old_status,
    new_status,
    old_balance,
    new_balance,
    audit_reason,
    changed_at
FROM account_audit_log
ORDER BY audit_id DESC
LIMIT 10;

COMMIT;
