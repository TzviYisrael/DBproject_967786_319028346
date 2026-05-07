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
