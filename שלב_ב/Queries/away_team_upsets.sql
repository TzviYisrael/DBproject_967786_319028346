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
ORDER BY odds DESC;
