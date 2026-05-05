-- ==============================================================================
-- Stage B: Indexes
-- ==============================================================================

-- 1. Index on transaction date for faster historical reporting
-- Before: Seq Scan on TRANSACTIONS
CREATE INDEX idx_transaction_date ON TRANSACTIONS(transaction_date);
-- After: Index Scan using idx_transaction_date

-- 2. Index on match status and date for dashboard queries
CREATE INDEX idx_match_status_date ON MATCHES(status, match_date);

-- 3. Index on user email for login/lookup performance
CREATE INDEX idx_user_email ON USERS(email);
