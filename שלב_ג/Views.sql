-- =============================================================================
-- Stage C - Views and queries on views
-- =============================================================================
-- Required:
-- 1. Three views total.
-- 2. One view from the original BetMaster point of view.
-- 3. One view from the received project's point of view.
-- 4. One integrated view.
-- 5. For each view: SELECT * LIMIT 10 and two meaningful queries.
--
-- Current status:
-- The BetMaster view is complete and runnable on the current schema.
-- The received and integrated views must be completed after receiving and
-- reverse engineering the other group's backup.

-- -----------------------------------------------------------------------------
-- View 1: BetMaster original project point of view
-- -----------------------------------------------------------------------------
-- Shows each user's betting and financial activity summary.
CREATE OR REPLACE VIEW vw_betmaster_user_activity AS
SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.account_status,
    u.registration_date,
    u.balance,
    COUNT(DISTINCT b.bet_id) AS total_bets,
    COALESCE(SUM(b.bet_amount), 0) AS total_bet_amount,
    COUNT(DISTINCT CASE WHEN b.bet_status = 'Won' THEN b.bet_id END) AS won_bets,
    COUNT(DISTINCT CASE WHEN b.bet_status = 'Lost' THEN b.bet_id END) AS lost_bets,
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    COALESCE(SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE 0 END), 0) AS total_deposits,
    COALESCE(SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END), 0) AS total_withdrawals,
    COALESCE(SUM(CASE WHEN t.transaction_type = 'Winnings' THEN t.amount ELSE 0 END), 0) AS total_winnings
FROM users u
LEFT JOIN bets b
    ON b.user_id = u.user_id
LEFT JOIN transactions t
    ON t.user_id = u.user_id
GROUP BY
    u.user_id,
    u.full_name,
    u.email,
    u.account_status,
    u.registration_date,
    u.balance;

-- Sample output for the report.
SELECT *
FROM vw_betmaster_user_activity
LIMIT 10;

-- Query 1 on View 1:
-- Active users with high betting volume.
SELECT
    user_id,
    full_name,
    email,
    total_bets,
    total_bet_amount,
    balance
FROM vw_betmaster_user_activity
WHERE account_status = 'Active'
  AND total_bets >= 10
ORDER BY total_bet_amount DESC
LIMIT 10;

-- Query 2 on View 1:
-- Users whose winnings are larger than their withdrawals.
SELECT
    user_id,
    full_name,
    total_winnings,
    total_withdrawals,
    total_winnings - total_withdrawals AS winnings_after_withdrawals
FROM vw_betmaster_user_activity
WHERE total_winnings > total_withdrawals
ORDER BY winnings_after_withdrawals DESC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- View 2: Received project point of view
-- -----------------------------------------------------------------------------
-- TODO after receiving the other group's backup:
-- Replace table and column names according to the received DSD/ERD.
--
-- CREATE OR REPLACE VIEW vw_received_project_summary AS
-- SELECT
--     ...
-- FROM <received_or_integrated_table_1> r
-- JOIN <received_or_integrated_table_2> x
--     ON x.<fk> = r.<pk>;
--
-- SELECT * FROM vw_received_project_summary LIMIT 10;
--
-- Query 1 on View 2:
-- SELECT ... FROM vw_received_project_summary WHERE ...;
--
-- Query 2 on View 2:
-- SELECT ... FROM vw_received_project_summary GROUP BY ...;

-- -----------------------------------------------------------------------------
-- View 3: Integrated point of view
-- -----------------------------------------------------------------------------
-- TODO after deciding the integrated ERD:
-- This view must combine BetMaster data with the received project data.
--
-- CREATE OR REPLACE VIEW vw_integrated_activity AS
-- SELECT
--     ...
-- FROM users u
-- JOIN <bridge_or_received_table> r
--     ON r.<user_reference> = u.user_id
-- JOIN integration_sources s
--     ON s.source_id = r.source_id;
--
-- SELECT * FROM vw_integrated_activity LIMIT 10;
--
-- Query 1 on View 3:
-- SELECT ... FROM vw_integrated_activity WHERE ...;
--
-- Query 2 on View 3:
-- SELECT ... FROM vw_integrated_activity GROUP BY ...;
