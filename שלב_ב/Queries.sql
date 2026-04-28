-- ==============================================================================
-- Stage B: Queries
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- SELECT Queries (8 total, 4 in two forms)
-- ------------------------------------------------------------------------------

-- 1a. Top winning users in 2026 (using JOIN)
-- This form is generally efficient for smaller datasets or when indexes exist on transaction_date and transaction_type.
SELECT u.user_id, u.full_name, SUM(t.amount) as total_winnings
FROM USERS u
JOIN TRANSACTIONS t ON u.user_id = t.user_id
WHERE t.transaction_type = 'Winnings' 
  AND EXTRACT(YEAR FROM t.transaction_date) = 2026
GROUP BY u.user_id, u.full_name
ORDER BY total_winnings DESC
LIMIT 5;

-- 1b. Same query using subquery in FROM
-- This form can be more efficient if the subquery significantly reduces the number of rows to be joined.
SELECT u.user_id, u.full_name, win_totals.total_winnings
FROM USERS u
JOIN (
    SELECT user_id, SUM(amount) as total_winnings
    FROM TRANSACTIONS
    WHERE transaction_type = 'Winnings' 
      AND EXTRACT(YEAR FROM transaction_date) = 2026
    GROUP BY user_id
) win_totals ON u.user_id = win_totals.user_id
ORDER BY win_totals.total_winnings DESC
LIMIT 5;


-- 2a. Matches where the Away team won, including odds (using simple JOIN)
-- Standard way to retrieve related data across multiple tables.
SELECT m.match_id, t_home.team_name as home_team, t_away.team_name as away_team, 
       m.final_result, o.away_win_odd
FROM MATCHES m
JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
JOIN ODDS o ON m.match_id = o.match_id
WHERE m.final_result = 'Away';

-- 2b. Same query using Scalar Subqueries
-- This form might be slower due to correlated subqueries but shows an alternative logic structure.
SELECT m.match_id, 
       (SELECT team_name FROM TEAMS WHERE team_id = m.home_team_id) as home_team,
       (SELECT team_name FROM TEAMS WHERE team_id = m.away_team_id) as away_team,
       m.final_result,
       o.away_win_odd
FROM MATCHES m
JOIN ODDS o ON m.match_id = o.match_id
WHERE m.final_result = 'Away';


-- 3a. Users who bet on matches involving teams from 'Country 1' (using multi-level JOIN)
-- Direct join path through the relationship graph.
SELECT DISTINCT u.user_id, u.full_name, u.email
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
JOIN MATCHES m ON b.match_id = m.match_id
JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
WHERE t_home.country = 'Country 1' OR t_away.country = 'Country 1';

-- 3b. Same query using IN and nested subqueries
-- Often easier to read but can be less efficient in older SQL engines (modern optimizers handle it well).
SELECT user_id, full_name, email
FROM USERS
WHERE user_id IN (
    SELECT user_id FROM BETS WHERE match_id IN (
        SELECT match_id FROM MATCHES WHERE home_team_id IN (
            SELECT team_id FROM TEAMS WHERE country = 'Country 1'
        ) OR away_team_id IN (
            SELECT team_id FROM TEAMS WHERE country = 'Country 1'
        )
    )
);


-- 4a. Monthly summary of Deposits vs Withdrawals for 2026 (using CASE WHEN)
-- Single pass over the TRANSACTIONS table.
SELECT EXTRACT(MONTH FROM transaction_date) as month,
       SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END) as total_deposits,
       SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END) as total_withdrawals
FROM TRANSACTIONS
WHERE EXTRACT(YEAR FROM transaction_date) = 2026
GROUP BY EXTRACT(MONTH FROM transaction_date)
ORDER BY month;

-- 4b. Same query using CTE (Common Table Expressions)
-- More modular and readable, especially for complex reports.
WITH Deposits AS (
    SELECT EXTRACT(MONTH FROM transaction_date) as month, SUM(amount) as total_dep
    FROM TRANSACTIONS
    WHERE transaction_type = 'Deposit' AND EXTRACT(YEAR FROM transaction_date) = 2026
    GROUP BY EXTRACT(MONTH FROM transaction_date)
),
Withdrawals AS (
    SELECT EXTRACT(MONTH FROM transaction_date) as month, SUM(amount) as total_with
    FROM TRANSACTIONS
    WHERE transaction_type = 'Withdrawal' AND EXTRACT(YEAR FROM transaction_date) = 2026
    GROUP BY EXTRACT(MONTH FROM transaction_date)
)
SELECT d.month, d.total_dep as total_deposits, COALESCE(w.total_with, 0) as total_withdrawals
FROM Deposits d
LEFT JOIN Withdrawals w ON d.month = w.month
ORDER BY d.month;


-- 5. Average bet amount per user account status
SELECT u.account_status, COUNT(b.bet_id) as num_bets, ROUND(AVG(b.bet_amount), 2) as avg_bet
FROM USERS u
LEFT JOIN BETS b ON u.user_id = b.user_id
GROUP BY u.account_status;

-- 6. Matches where odds were updated in April 2026
SELECT m.match_id, m.match_date, o.update_date, o.home_win_odd, o.away_win_odd
FROM MATCHES m
JOIN ODDS o ON m.match_id = o.match_id
WHERE EXTRACT(MONTH FROM o.update_date) = 4 
  AND EXTRACT(YEAR FROM o.update_date) = 2026;

-- 7. Users with more than 5 bets in a specific month
SELECT u.full_name, EXTRACT(MONTH FROM b.bet_date) as bet_month, COUNT(b.bet_id) as bet_count
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
GROUP BY u.full_name, EXTRACT(MONTH FROM b.bet_date)
HAVING COUNT(b.bet_id) > 5
ORDER BY bet_count DESC;

-- 8. Bet details for users who registered in 2025
SELECT u.full_name, u.registration_date, b.bet_amount, b.predicted_result, b.bet_status
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
WHERE EXTRACT(YEAR FROM u.registration_date) = 2025;


-- ------------------------------------------------------------------------------
-- UPDATE Queries (3 total)
-- ------------------------------------------------------------------------------

-- 1. Update balances for users who won a bet (small bonus)
UPDATE USERS
SET balance = balance + 10
WHERE user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);

-- 2. Update status of past matches to 'Finished'
UPDATE MATCHES
SET status = 'Finished'
WHERE match_date < CURRENT_DATE AND status = 'Scheduled';

-- 3. Suspend users who haven't placed any bets since the start of 2026
UPDATE USERS
SET account_status = 'Suspended'
WHERE user_id NOT IN (
    SELECT user_id 
    FROM BETS 
    WHERE EXTRACT(YEAR FROM bet_date) >= 2026
);


-- ------------------------------------------------------------------------------
-- DELETE Queries (3 total)
-- ------------------------------------------------------------------------------

-- 1. Delete small withdrawals (data cleanup)
DELETE FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal' AND amount < 50;

-- 2. Delete 'Pending' bets for matches that have already finished
DELETE FROM BETS
WHERE bet_status = 'Pending' 
  AND match_id IN (SELECT match_id FROM MATCHES WHERE status = 'Finished');

-- 3. Delete inactive users with no history registered more than a year ago
DELETE FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '1 year'
  AND user_id NOT IN (SELECT DISTINCT user_id FROM BETS)
  AND user_id NOT IN (SELECT DISTINCT user_id FROM TRANSACTIONS);
