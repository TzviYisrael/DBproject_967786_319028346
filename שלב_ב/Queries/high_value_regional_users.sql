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
