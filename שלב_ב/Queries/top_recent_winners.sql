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
