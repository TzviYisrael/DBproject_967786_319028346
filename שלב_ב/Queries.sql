-- ==============================================================================
-- Stage B: Queries.sql
-- Combined file required for submission.
-- The original per-query files are preserved in שלב_ב/Queries/.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- Source: Queries/top_recent_winners.sql
-- ------------------------------------------------------------------------------
-- Query 1: Top Recent Winners (Two Versions)
-- Purpose: Identify top earners from recent registrations for the "Featured Winners" screen.

-- Version A: Using standard JOIN and GROUP BY
-- Generally efficient for direct aggregation.
SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    EXTRACT(YEAR FROM u.registration_date) as reg_year,
    SUM(t.amount) as total_winnings,
    COUNT(t.transaction_id) as winning_count
FROM USERS u
JOIN TRANSACTIONS t ON u.user_id = t.user_id
WHERE t.transaction_type = 'Winnings' 
  AND u.registration_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING SUM(t.amount) > 500
ORDER BY total_winnings DESC;

-- Version B: Using a CTE (Common Table Expression)
-- Often more readable; efficiency depends on optimizer (PostgreSQL 12+ treats CTEs as part of the query plan).
WITH RecentWinners AS (
    SELECT 
        user_id, 
        SUM(amount) as total_winnings, 
        COUNT(transaction_id) as winning_count
    FROM TRANSACTIONS
    WHERE transaction_type = 'Winnings'
    GROUP BY user_id
)
SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    EXTRACT(YEAR FROM u.registration_date) as reg_year,
    rw.total_winnings,
    rw.winning_count
FROM USERS u
JOIN RecentWinners rw ON u.user_id = rw.user_id
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '6 months'
  AND rw.total_winnings > 500
ORDER BY rw.total_winnings DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/high_value_regional_users.sql
-- ------------------------------------------------------------------------------
-- Query 2: High-Value Regional Users (Two Versions)
-- Purpose: Find high-spending users betting on matches involving teams from a specific country.

-- Version A: Multi-table JOIN
-- Direct and explicit.
SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    EXTRACT(MONTH FROM u.registration_date) as reg_month,
    COUNT(b.bet_id) as bet_count,
    SUM(b.bet_amount) as total_invested
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
JOIN MATCHES m ON b.match_id = m.match_id
JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
WHERE (t_home.country = 'Israel' OR t_away.country = 'Israel')
  AND u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING SUM(b.bet_amount) > 300
ORDER BY total_invested DESC;

-- Version B: Using Correlated Subqueries with Filtering
-- Aligned with Version A to ensure identical results.
SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    EXTRACT(MONTH FROM u.registration_date) as reg_month,
    (
        SELECT COUNT(b2.bet_id) 
        FROM BETS b2 
        JOIN MATCHES m2 ON b2.match_id = m2.match_id
        JOIN TEAMS th2 ON m2.home_team_id = th2.team_id
        JOIN TEAMS ta2 ON m2.away_team_id = ta2.team_id
        WHERE b2.user_id = u.user_id 
          AND (th2.country = 'Israel' OR ta2.country = 'Israel')
    ) as bet_count,
    (
        SELECT SUM(b3.bet_amount) 
        FROM BETS b3 
        JOIN MATCHES m3 ON b3.match_id = m3.match_id
        JOIN TEAMS th3 ON m3.home_team_id = th3.team_id
        JOIN TEAMS ta3 ON m3.away_team_id = ta3.team_id
        WHERE b3.user_id = u.user_id 
          AND (th3.country = 'Israel' OR ta3.country = 'Israel')
    ) as total_invested
FROM USERS u
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
  AND (
    SELECT SUM(b4.bet_amount) 
    FROM BETS b4 
    JOIN MATCHES m4 ON b4.match_id = m4.match_id
    JOIN TEAMS th4 ON m4.home_team_id = th4.team_id
    JOIN TEAMS ta4 ON m4.away_team_id = ta4.team_id
    WHERE b4.user_id = u.user_id 
      AND (th4.country = 'Israel' OR ta4.country = 'Israel')
  ) > 300
ORDER BY total_invested DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/suspicious_winning_patterns.sql
-- ------------------------------------------------------------------------------
-- Query 3: Suspicious Winning Patterns (Two Versions)
-- Purpose: Detect potential cheaters with high win rates (> 75%) and significant betting volume.

-- Version A: GROUP BY with CASE statements
-- Calculates everything in a single pass over the joined data.
SELECT 
    u.user_id, 
    u.full_name, 
    u.email,
    EXTRACT(YEAR FROM u.registration_date) as joined_year,
    COUNT(b.bet_id) as total_settled_bets,
    SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) as wins,
    ROUND(CAST(SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(b.bet_id) * 100, 2) as win_rate_percentage
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
WHERE b.bet_status IN ('Won', 'Lost')
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING COUNT(b.bet_id) >= 5 
   AND (CAST(SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(b.bet_id)) > 0.75
ORDER BY win_rate_percentage DESC;

-- Version B: Using Nested Subqueries
-- Isolates the aggregation logic from the user details.
SELECT 
    u.user_id, 
    u.full_name, 
    u.email,
    EXTRACT(YEAR FROM u.registration_date) as joined_year,
    stats.total_settled_bets,
    stats.wins,
    stats.win_rate
FROM USERS u
JOIN (
    SELECT 
        user_id,
        COUNT(bet_id) as total_settled_bets,
        SUM(CASE WHEN bet_status = 'Won' THEN 1 ELSE 0 END) as wins,
        ROUND(CAST(SUM(CASE WHEN bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(bet_id) * 100, 2) as win_rate
    FROM BETS
    WHERE bet_status IN ('Won', 'Lost')
    GROUP BY user_id
) stats ON u.user_id = stats.user_id
WHERE stats.total_settled_bets >= 5 
  AND stats.win_rate > 75
ORDER BY stats.win_rate DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/away_team_upsets.sql
-- ------------------------------------------------------------------------------
-- Query 4: Away Team Upsets (Two Versions)
-- Purpose: Find matches where the away team won with high odds (> 3.5), indicating a major "upset".

-- Version A: JOIN with explicit filtering
-- Simple and effective for smaller datasets.
SELECT 
    m.match_id, 
    m.match_date,
    EXTRACT(DAY FROM m.match_date) as day,
    EXTRACT(MONTH FROM m.match_date) as month,
    t_home.team_name as home_team, 
    t_away.team_name as away_team, 
    o.away_win_odd
FROM MATCHES m
JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
JOIN ODDS o ON m.match_id = o.match_id
WHERE m.final_result = 'Away' 
  AND o.away_win_odd > 3.5
ORDER BY o.away_win_odd DESC;

-- Version B: Using a Correlated Subquery
-- Evaluates the condition for each match. Demonstrates a different logical approach.
SELECT 
    m.match_id, 
    m.match_date,
    EXTRACT(DAY FROM m.match_date) as day,
    EXTRACT(MONTH FROM m.match_date) as month,
    (SELECT team_name FROM TEAMS WHERE team_id = m.home_team_id) as home_team,
    (SELECT team_name FROM TEAMS WHERE team_id = m.away_team_id) as away_team,
    (SELECT away_win_odd FROM ODDS WHERE match_id = m.match_id) as odds
FROM MATCHES m
WHERE m.final_result = 'Away'
  AND (SELECT away_win_odd FROM ODDS WHERE match_id = m.match_id) > 3.5
ORDER BY (SELECT away_win_odd FROM ODDS WHERE match_id = m.match_id) DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/high_frequency_bettors.sql
-- ------------------------------------------------------------------------------
-- Query 5: High-Frequency Bettors
-- Purpose: Identifies users with a high "bets per day" ratio to find the most active participants.
-- Joins USERS and BETS, uses date arithmetic and GROUP BY.

-- EXPLAIN ANALYZE
SELECT 
    u.user_id,
    u.full_name, 
    u.email,
    EXTRACT(YEAR FROM u.registration_date) as joined_year,
    (CURRENT_DATE - u.registration_date) as membership_duration_days,
    COUNT(b.bet_id) as total_bets,
    ROUND(CAST(COUNT(b.bet_id) AS NUMERIC) / NULLIF(CURRENT_DATE - u.registration_date, 0), 2) as daily_bet_avg
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING (CURRENT_DATE - u.registration_date) > 30 -- Minimum 1 month membership
   AND CAST(COUNT(b.bet_id) AS NUMERIC) / NULLIF(CURRENT_DATE - u.registration_date, 0) > 0.10 -- More than 1 bet every 10 days on average
ORDER BY daily_bet_avg DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/new_whale_users.sql
-- ------------------------------------------------------------------------------
-- Query 6: New Whale Users
-- Purpose: Identify big-money players (Whales) who registered recently.
-- Joins USERS and BETS, uses AVG and multiple filters.

SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    u.balance,
    EXTRACT(MONTH FROM u.registration_date) as joined_month,
    COUNT(b.bet_id) as bet_count,
    ROUND(AVG(b.bet_amount), 2) as avg_bet_size
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY u.user_id, u.full_name, u.email, u.balance, u.registration_date
HAVING AVG(b.bet_amount) > 100
ORDER BY avg_bet_size DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/monthly_transaction_summary.sql
-- ------------------------------------------------------------------------------
-- Query 7: Monthly Cash Flow Analysis
-- Purpose: Summary of high-volume financial months for the platform.
-- Uses EXTRACT for temporal breakdown and CASE for side-by-side comparison.

SELECT 
    EXTRACT(YEAR FROM transaction_date) as year,
    EXTRACT(MONTH FROM transaction_date) as month,
    COUNT(transaction_id) as txn_count,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END) as total_deposits,
    SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END) as total_withdrawals,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE -amount END) as net_platform_flow
FROM TRANSACTIONS
GROUP BY EXTRACT(YEAR FROM transaction_date), EXTRACT(MONTH FROM transaction_date)
HAVING SUM(amount) > 5000
ORDER BY year DESC, month DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/winning_efficiency.sql
-- ------------------------------------------------------------------------------
-- Query 8: Winning Efficiency Metric
-- Purpose: Calculate how much a user wins per day of membership.
-- Joins USERS and TRANSACTIONS with complex mathematical filters.

SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    EXTRACT(YEAR FROM u.registration_date) as start_year,
    (CURRENT_DATE - u.registration_date) as membership_days,
    SUM(t.amount) as total_wins_value,
    ROUND(SUM(t.amount) / NULLIF(CURRENT_DATE - u.registration_date, 0), 2) as performance_ratio
FROM USERS u
JOIN TRANSACTIONS t ON u.user_id = t.user_id
WHERE t.transaction_type = 'Winnings'
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING (CURRENT_DATE - u.registration_date) > 0 
   AND SUM(t.amount) > 100
ORDER BY performance_ratio DESC;


-- ------------------------------------------------------------------------------
-- Source: Queries/delete_abandoned_users.sql
-- ------------------------------------------------------------------------------
-- Delete Query 1: Cleanup Abandoned Accounts
-- Description: Deletes users who registered long ago but never interacted (no bets, no transactions).

-- SETUP FOR DEMO (Run this first to ensure there is data to delete)
INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) VALUES 
(9991, 'Ghost User 1', 'ghost1@example.com', 0.00, '2022-01-01', 'Active'),
(9992, 'Ghost User 2', 'ghost2@example.com', 0.00, '2021-05-15', 'Active'),
(9993, 'Ghost User 3', 'ghost3@example.com', 0.00, '2020-11-20', 'Active')
ON CONFLICT DO NOTHING;

-- INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) 
-- VALUES (8888, 'very User', 'ghost2@example.com', 0.00, '2020-01-01', 'Active')
-- ON CONFLICT DO NOTHING;
-- INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) 
-- VALUES (7777, 'Abandoned User', 'ghost3@example.com', 20.00, '2019-01-01', 'Active')
-- ON CONFLICT DO NOTHING;

-- 1. Show users to be deleted
SELECT * FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);

-- 2. Perform deletion
DELETE FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);

-- 3. Verify deletion (should return empty)
SELECT * FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);




-- ------------------------------------------------------------------------------
-- Source: Queries/delete_stale_pending_bets.sql
-- ------------------------------------------------------------------------------
-- Delete Query 2: Purge Stale Pending Bets
-- Description: Removes 'Pending' bets associated with matches that have already finished.

-- SETUP FOR DEMO (Run this first to ensure there is data to delete)
-- Using match_id 1 (assume finished) and user_id 1
INSERT INTO BETS (bet_id, user_id, match_id, bet_amount, bet_date, bet_status, predicted_result) VALUES
(7771, 1, 1, 10.00, CURRENT_DATE - INTERVAL '10 days', 'Pending', 'Home'),
(7772, 2, 1, 20.00, CURRENT_DATE - INTERVAL '10 days', 'Pending', 'Away'),
(7773, 3, 1, 5.00, CURRENT_DATE - INTERVAL '10 days', 'Pending', 'Draw')
ON CONFLICT DO NOTHING;

-- 1. Show records to be deleted
SELECT * FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );

-- 2. Perform deletion
DELETE FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );

-- 3. Verify deletion
SELECT * FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );



-- ------------------------------------------------------------------------------
-- Source: Queries/delete_small_withdrawals.sql
-- ------------------------------------------------------------------------------
-- Delete Query 3: Remove Micro-Withdrawal Noise
-- Description: Deletes withdrawal transactions of negligible amounts to clean up financial logs.

-- SETUP FOR DEMO (Run this first to ensure there is data to delete)
-- Using existing user_id 1
-- INSERT INTO TRANSACTIONS (transaction_id, user_id, transaction_type, amount, transaction_date) VALUES
-- (20001, 1, 'Withdrawal', 0.50, CURRENT_DATE),
-- (20002, 1, 'Withdrawal', 0.25, CURRENT_DATE),
-- (20003, 1, 'Withdrawal', 0.99, CURRENT_DATE)
-- ON CONFLICT DO NOTHING;

-- 1. Show records to be deleted
SELECT * FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 100.00;

-- 2. Perform deletion
DELETE FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 100.00;

-- 3. Verify deletion
SELECT * FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 100.00;



-- ------------------------------------------------------------------------------
-- Source: Queries/update_winning_user_balances.sql
-- ------------------------------------------------------------------------------
-- Update Query 1: Loyalty Bonus for Winners
-- Description: Adds a balance bonus to active users who have won at least one bet.

-- SETUP FOR DEMO (Run this first to ensure there is data to update)
INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) VALUES 
(4441, 'Winner User 1', 'winner1@example.com', 100.00, CURRENT_DATE - INTERVAL '1 month', 'Active'),
(4442, 'Winner User 2', 'winner2@example.com', 200.00, CURRENT_DATE - INTERVAL '1 month', 'Active'),
(4443, 'Winner User 3', 'winner3@example.com', 50.00, CURRENT_DATE - INTERVAL '1 month', 'Active')
ON CONFLICT DO NOTHING;
INSERT INTO BETS (bet_id, user_id, match_id, bet_amount, bet_date, bet_status, predicted_result) VALUES
(4441, 4441, 1, 10.00, CURRENT_DATE - INTERVAL '5 days', 'Won', 'Home'),
(4442, 4442, 1, 10.00, CURRENT_DATE - INTERVAL '5 days', 'Won', 'Away'),
(4443, 4443, 1, 10.00, CURRENT_DATE - INTERVAL '5 days', 'Won', 'Draw')
ON CONFLICT DO NOTHING;

-- 1. Show balances before update
SELECT user_id, full_name, balance FROM USERS
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);

-- 2. Perform update
UPDATE USERS
SET balance = balance + 25.00
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);

-- 3. Show balances after update
SELECT user_id, full_name, balance FROM USERS
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);



-- ------------------------------------------------------------------------------
-- Source: Queries/suspend_inactive_users.sql
-- ------------------------------------------------------------------------------
-- Update Query 2: Suspend Inactive Bettors
-- Description: Suspends users who haven't placed a bet in the last year.

-- SETUP FOR DEMO (Run this first to ensure there is data to update)
INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) VALUES 
(6661, 'Inactive User 1', 'inactive1@example.com', 50.00, '2020-01-01', 'Active'),
(6662, 'Inactive User 2', 'inactive2@example.com', 10.00, '2020-01-01', 'Active'),
(6663, 'Inactive User 3', 'inactive3@example.com', 100.00, '2020-01-01', 'Active')
ON CONFLICT DO NOTHING;

-- 1. Show users before update
SELECT user_id, full_name, account_status FROM USERS
WHERE account_status = 'Active'
  AND user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_date >= CURRENT_DATE - INTERVAL '1 year'
);

-- 2. Perform update
UPDATE USERS
SET account_status = 'Suspended'
WHERE account_status = 'Active'
  AND user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_date >= CURRENT_DATE - INTERVAL '1 year'
);

-- 3. Show users after update
SELECT user_id, full_name, account_status FROM USERS
WHERE user_id IN (
    -- Re-select same IDs for verification
    SELECT user_id FROM USERS WHERE account_status = 'Suspended'
);



-- ------------------------------------------------------------------------------
-- Source: Queries/update_match_status.sql
-- ------------------------------------------------------------------------------
-- Update Query 3: Mass Settle Past Matches
-- Description: Updates matches that are in the past but still marked as 'Scheduled' to 'Finished'.

-- SETUP FOR DEMO (Run this first to ensure there is data to update)
INSERT INTO MATCHES (match_id, home_team_id, away_team_id, match_date, status) VALUES
(5551, 1, 2, CURRENT_DATE - INTERVAL '1 day', 'Scheduled'),
(5552, 3, 4, CURRENT_DATE - INTERVAL '2 days', 'Scheduled'),
(5553, 5, 6, CURRENT_DATE - INTERVAL '3 days', 'Scheduled')
ON CONFLICT DO NOTHING;

-- 1. Show records before update
SELECT match_id, match_date, status FROM MATCHES
WHERE match_date < CURRENT_DATE 
  AND status = 'Scheduled';

-- 2. Perform update
UPDATE MATCHES
SET status = 'Finished'
WHERE match_date < CURRENT_DATE 
  AND status = 'Scheduled';

-- 3. Show records after update
SELECT match_id, match_date, status FROM MATCHES
WHERE match_id IN (
    -- Check specific matches that were updated
    SELECT match_id FROM MATCHES WHERE status = 'Finished' AND match_date < CURRENT_DATE
)
LIMIT 10;



