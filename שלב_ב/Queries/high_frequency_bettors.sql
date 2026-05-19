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
   AND CAST(COUNT(b.bet_id) AS NUMERIC) / NULLIF(CURRENT_DATE - u.registration_date, 0) > 0.5 -- More than 1 bet per two days avg
ORDER BY daily_bet_avg DESC;
