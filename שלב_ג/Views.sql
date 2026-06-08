-- =============================================================================
-- Stage C - Views and queries on views
-- =============================================================================
-- Original project: BetMaster
-- Received project: Football Management System
-- Integrated database: shared teams/matches with betting and football statistics
-- =============================================================================

-- -----------------------------------------------------------------------------
-- View 1: BetMaster original department point of view
-- -----------------------------------------------------------------------------
-- Meaning: user-level financial and betting activity for the betting department.
CREATE OR REPLACE VIEW vw_betmaster_user_activity AS
SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.account_status,
    u.registration_date,
    u.balance,
    COUNT(DISTINCT b.bet_id) AS total_bets,
    COALESCE(SUM(b.bet_amount), 0) AS total_bet_amount,
    COUNT(DISTINCT CASE WHEN b.bet_status = 'Won' THEN b.bet_id END) AS won_bets,
    COUNT(DISTINCT CASE WHEN b.bet_status = 'Lost' THEN b.bet_id END) AS lost_bets,
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    COALESCE(SUM(CASE WHEN t.transaction_type = 'Deposit' THEN t.amount ELSE 0 END), 0) AS total_deposits,
    COALESCE(SUM(CASE WHEN t.transaction_type = 'Withdrawal' THEN t.amount ELSE 0 END), 0) AS total_withdrawals,
    COALESCE(SUM(CASE WHEN t.transaction_type = 'Winnings' THEN t.amount ELSE 0 END), 0) AS total_winnings
FROM users u
LEFT JOIN bets b
    ON b.user_id = u.user_id
LEFT JOIN transactions t
    ON t.user_id = u.user_id
GROUP BY
    u.user_id,
    u.full_name,
    u.email,
    u.account_status,
    u.registration_date,
    u.balance;

SELECT *
FROM vw_betmaster_user_activity
LIMIT 10;

-- Query 1 on View 1: active users with high betting volume.
SELECT
    user_id,
    full_name,
    email,
    total_bets,
    total_bet_amount,
    balance
FROM vw_betmaster_user_activity
WHERE account_status = 'Active'
  AND total_bets >= 10
ORDER BY total_bet_amount DESC
LIMIT 10;

-- Query 2 on View 1: users whose winnings exceed withdrawals.
SELECT
    user_id,
    full_name,
    total_winnings,
    total_withdrawals,
    total_winnings - total_withdrawals AS winnings_after_withdrawals
FROM vw_betmaster_user_activity
WHERE total_winnings > total_withdrawals
ORDER BY winnings_after_withdrawals DESC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- View 2: Football Management received department point of view
-- -----------------------------------------------------------------------------
-- Meaning: player performance and contract context from the football department.
CREATE OR REPLACE VIEW vw_football_player_performance AS
SELECT
    fp.player_id,
    fp.player_name,
    fp.position,
    fp.native_country,
    t.team_name,
    t.country AS team_country,
    fpc.player_type,
    fpc.salary,
    COUNT(DISTINCT fpms.match_id) AS matches_played,
    COALESCE(SUM(fpms.goals), 0) AS total_goals,
    COALESCE(SUM(fpms.assists), 0) AS total_assists,
    COALESCE(SUM(fpms.yellow_card), 0) AS yellow_cards,
    COALESCE(SUM(fpms.red_card), 0) AS red_cards
FROM football_players fp
LEFT JOIN football_player_contracts fpc
    ON fpc.player_id = fp.player_id
LEFT JOIN teams t
    ON t.team_id = fpc.team_id
LEFT JOIN football_player_match_stats fpms
    ON fpms.player_id = fp.player_id
GROUP BY
    fp.player_id,
    fp.player_name,
    fp.position,
    fp.native_country,
    t.team_name,
    t.country,
    fpc.player_type,
    fpc.salary;

SELECT *
FROM vw_football_player_performance
LIMIT 10;

-- Query 1 on View 2: most productive players by goals and assists.
SELECT
    player_id,
    player_name,
    team_name,
    total_goals,
    total_assists,
    total_goals + total_assists AS total_contributions
FROM vw_football_player_performance
WHERE matches_played > 0
ORDER BY total_contributions DESC, total_goals DESC
LIMIT 10;

-- Query 2 on View 2: high-salary players with low goal contribution.
SELECT
    player_id,
    player_name,
    team_name,
    salary,
    matches_played,
    total_goals
FROM vw_football_player_performance
WHERE salary > 1000000
  AND total_goals < 5
ORDER BY salary DESC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- View 3: Integrated point of view
-- -----------------------------------------------------------------------------
-- Meaning: connects BetMaster bets to integrated match/team data and football
-- match context. It supports analysis of betting activity by source system,
-- teams, competition stage and the registered home stadium of the home team.
CREATE OR REPLACE VIEW vw_integrated_match_betting_context AS
SELECT
    m.match_id,
    m.source_system,
    m.match_date,
    m.status,
    m.competition_stage,
    home.team_name AS home_team,
    away.team_name AS away_team,
    m.final_result,
    COUNT(DISTINCT b.bet_id) AS bet_count,
    COALESCE(SUM(b.bet_amount), 0) AS total_bet_amount,
    COUNT(DISTINCT CASE WHEN b.bet_status = 'Won' THEN b.bet_id END) AS won_bets,
    COUNT(DISTINCT CASE WHEN b.bet_status = 'Lost' THEN b.bet_id END) AS lost_bets,
    fs.stadium_name AS match_stadium_name,
    hfs.stadium_name AS home_team_stadium_name,
    fms.attendees
FROM matches m
LEFT JOIN teams home
    ON home.team_id = m.home_team_id
LEFT JOIN teams away
    ON away.team_id = m.away_team_id
LEFT JOIN bets b
    ON b.match_id = m.match_id
LEFT JOIN football_match_stadiums fms
    ON fms.match_id = m.match_id
LEFT JOIN football_stadiums fs
    ON fs.stadium_id = fms.stadium_id
LEFT JOIN football_stadiums hfs
    ON hfs.stadium_id = home.home_stadium_id
GROUP BY
    m.match_id,
    m.source_system,
    m.match_date,
    m.status,
    m.competition_stage,
    home.team_name,
    away.team_name,
    m.final_result,
    fs.stadium_name,
    hfs.stadium_name,
    fms.attendees;

SELECT *
FROM vw_integrated_match_betting_context
LIMIT 10;

-- Query 1 on View 3: BetMaster matches with the largest betting volume.
SELECT
    match_id,
    match_date,
    home_team,
    away_team,
    bet_count,
    total_bet_amount
FROM vw_integrated_match_betting_context
WHERE source_system = 'BetMaster'
ORDER BY total_bet_amount DESC, bet_count DESC
LIMIT 10;

-- Query 2 on View 3: received football matches by stage and attendance.
SELECT
    competition_stage,
    COUNT(*) AS match_count,
    ROUND(AVG(attendees), 2) AS avg_attendance
FROM vw_integrated_match_betting_context
WHERE source_system = 'FootballManagement'
GROUP BY competition_stage
ORDER BY avg_attendance DESC NULLS LAST, match_count DESC
LIMIT 10;
