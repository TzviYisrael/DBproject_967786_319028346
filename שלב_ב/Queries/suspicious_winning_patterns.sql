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
