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

-- Version B: Using Subquery with EXISTS
-- Often faster if the subquery filters a large number of rows early.
SELECT 
    u.user_id, 
    u.full_name, 
    u.email, 
    EXTRACT(MONTH FROM u.registration_date) as reg_month,
    (SELECT COUNT(*) FROM BETS b2 WHERE b2.user_id = u.user_id) as total_bets,
    (SELECT SUM(bet_amount) FROM BETS b3 WHERE b3.user_id = u.user_id) as total_invested
FROM USERS u
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
  AND EXISTS (
    SELECT 1 
    FROM BETS b
    JOIN MATCHES m ON b.match_id = m.match_id
    JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
    JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
    WHERE b.user_id = u.user_id 
      AND (t_home.country = 'Israel' OR t_away.country = 'Israel')
  )
  AND (SELECT SUM(bet_amount) FROM BETS b4 WHERE b4.user_id = u.user_id) > 300
ORDER BY total_invested DESC;
