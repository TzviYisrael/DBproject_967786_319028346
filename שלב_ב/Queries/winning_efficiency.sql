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
