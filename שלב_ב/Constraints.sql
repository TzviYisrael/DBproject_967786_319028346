-- ==============================================================================
-- Stage B: Constraints
-- ==============================================================================

-- 1. Ensure user registration date is not in the future
ALTER TABLE USERS ADD CONSTRAINT chk_registration_date CHECK (registration_date <= CURRENT_DATE);

-- 2. Ensure bet amount is at most 10% of the user's current balance (Complex logic - usually Trigger, but check constraint for fixed limit if needed)
-- Since check constraints can't reference other tables easily, we'll use a simpler constraint:
-- 2. Ensure home and away teams in a match are different.
ALTER TABLE MATCHES ADD CONSTRAINT chk_different_teams CHECK (home_team_id <> away_team_id);

-- 3. Ensure transaction amount is positive for Deposits and Winnings
ALTER TABLE TRANSACTIONS ADD CONSTRAINT chk_positive_transaction CHECK (
    (transaction_type IN ('Deposit', 'Winnings') AND amount > 0) OR 
    (transaction_type IN ('Withdrawal', 'Bet Placement'))
);
