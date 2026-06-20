-- ==============================================================================
-- Stage B: Indexes
-- ==============================================================================

-- 1. Index on transaction date for faster historical reporting
-- Before: Seq Scan on TRANSACTIONS
CREATE INDEX idx_transaction_date ON transactions(transaction_date);
-- After: Index Scan using idx_transaction_date

-- 2. Index on match status and date for dashboard queries
CREATE INDEX idx_match_status_date ON matches(status, match_date);

-- 3. Index on user_id in bets for join performance and referential integrity
-- Before: Seq Scan on BETS when joining/deleting users
CREATE INDEX idx_bets_user_id ON bets(user_id);
-- After: Index Scan using idx_bets_user_id
