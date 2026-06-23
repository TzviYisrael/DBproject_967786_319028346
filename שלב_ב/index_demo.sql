-- ============================================================
-- Index Performance Demo – run in psql with \timing on
-- Run: \timing on
-- Then paste each block separately, or run the whole file:
-- docker exec -i betmaster_db psql -U betmaster_user -d betmaster < index_demo.sql
-- ============================================================

-- ============================================================
-- 1. idx_transaction_date – Range scan on transaction_date
-- ============================================================
DROP INDEX IF EXISTS idx_transaction_date;

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE transaction_date >= CURRENT_DATE - INTERVAL '3 months'
  AND transaction_date <= CURRENT_DATE;

CREATE INDEX idx_transaction_date ON transactions(transaction_date);

EXPLAIN ANALYZE
SELECT *
FROM transactions
WHERE transaction_date >= CURRENT_DATE - INTERVAL '3 months'
  AND transaction_date <= CURRENT_DATE;

-- ============================================================
-- 2. idx_match_status_date – Composite filter on status + date
-- ============================================================
DROP INDEX IF EXISTS idx_match_status_date;

EXPLAIN ANALYZE
SELECT match_id, match_date, status, final_result
FROM matches
WHERE status = 'Finished'
  AND match_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY match_date DESC;

CREATE INDEX idx_match_status_date ON matches(status, match_date);

EXPLAIN ANALYZE
SELECT match_id, match_date, status, final_result
FROM matches
WHERE status = 'Finished'
  AND match_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY match_date DESC;

-- ============================================================
-- 3. idx_bets_user_id – JOIN between bets and users
-- ============================================================
DROP INDEX IF EXISTS idx_bets_user_id;

EXPLAIN ANALYZE
SELECT u.user_id, u.full_name, COUNT(b.bet_id) AS total_bets,
       SUM(b.bet_amount) AS total_stake
FROM users u
JOIN bets b ON b.user_id = u.user_id
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY u.user_id, u.full_name
ORDER BY total_stake DESC;

CREATE INDEX idx_bets_user_id ON bets(user_id);

EXPLAIN ANALYZE
SELECT u.user_id, u.full_name, COUNT(b.bet_id) AS total_bets,
       SUM(b.bet_amount) AS total_stake
FROM users u
JOIN bets b ON b.user_id = u.user_id
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY u.user_id, u.full_name
ORDER BY total_stake DESC;
