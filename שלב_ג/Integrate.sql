-- =============================================================================
-- Stage C - Integration script
-- =============================================================================
-- Original project: BetMaster - Football Betting Management System
-- Received project: Football Management System
--
-- Execution order:
-- 1. Restore the original BetMaster backup into the target database.
-- 2. Restore received/backup_other_group_pg16_compatible.sql into the same database. The received
--    tables are singular/lowercase: team, match, player, coach, stadium, etc.
-- 3. Run this file. It keeps the existing BetMaster tables and changes/extends
--    them with ALTER TABLE and CREATE TABLE commands.
--
-- Integration policy:
-- - teams is the shared team entity. Received team rows are inserted into teams.
-- - matches is the shared match entity. Received match rows are inserted into matches.
-- - BetMaster-only entities remain: users, bets, odds, transactions.
-- - Football-management-only entities are added as new integrated tables linked
--   to the shared teams/matches entities.
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 1. Source metadata
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS integration_sources (
    source_id INT PRIMARY KEY,
    source_name VARCHAR(100) NOT NULL UNIQUE,
    source_description VARCHAR(500),
    received_backup_file VARCHAR(255),
    integrated_at DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO integration_sources (source_id, source_name, source_description, received_backup_file)
VALUES
    (1, 'BetMaster', 'Original project: football betting and transaction management', NULL),
    (2, 'FootballManagement', 'Received project: football teams, players, staff, stadiums and match statistics', 'received/backup_other_group.sql')
ON CONFLICT (source_id) DO UPDATE
SET source_name = EXCLUDED.source_name,
    source_description = EXCLUDED.source_description,
    received_backup_file = EXCLUDED.received_backup_file;

-- -----------------------------------------------------------------------------
-- 2. Extend existing shared BetMaster tables instead of recreating them
-- -----------------------------------------------------------------------------
ALTER TABLE teams
    ADD COLUMN IF NOT EXISTS source_system VARCHAR(40) NOT NULL DEFAULT 'BetMaster',
    ADD COLUMN IF NOT EXISTS received_team_id INT,
    ADD COLUMN IF NOT EXISTS year_founded INT;

ALTER TABLE matches
    ADD COLUMN IF NOT EXISTS source_system VARCHAR(40) NOT NULL DEFAULT 'BetMaster',
    ADD COLUMN IF NOT EXISTS received_match_id INT,
    ADD COLUMN IF NOT EXISTS competition_stage VARCHAR(50);

CREATE UNIQUE INDEX IF NOT EXISTS uq_teams_received_source
    ON teams (source_system, received_team_id)
    WHERE received_team_id IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_matches_received_source
    ON matches (source_system, received_match_id)
    WHERE received_match_id IS NOT NULL;

-- -----------------------------------------------------------------------------
-- 3. Mapping tables from received IDs to integrated IDs
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS integration_team_map (
    source_system VARCHAR(40) NOT NULL,
    source_team_id INT NOT NULL,
    integrated_team_id INT NOT NULL REFERENCES teams(team_id),
    PRIMARY KEY (source_system, source_team_id),
    UNIQUE (integrated_team_id)
);

CREATE TABLE IF NOT EXISTS integration_match_map (
    source_system VARCHAR(40) NOT NULL,
    source_match_id INT NOT NULL,
    integrated_match_id INT NOT NULL REFERENCES matches(match_id),
    PRIMARY KEY (source_system, source_match_id),
    UNIQUE (integrated_match_id)
);

-- -----------------------------------------------------------------------------
-- 4. Migrate received teams into the shared teams table
-- -----------------------------------------------------------------------------
WITH max_team AS (
    SELECT COALESCE(MAX(team_id), 0) AS max_id FROM teams
), received_teams AS (
    SELECT
        t.teamid,
        t.teamname,
        t.country,
        t.yearfounded,
        ROW_NUMBER() OVER (ORDER BY t.teamid) AS rn
    FROM public.team t
    WHERE NOT EXISTS (
        SELECT 1
        FROM teams existing
        WHERE existing.source_system = 'FootballManagement'
          AND existing.received_team_id = t.teamid
    )
)
INSERT INTO teams (team_id, team_name, country, source_system, received_team_id, year_founded)
SELECT
    max_team.max_id + received_teams.rn,
    received_teams.teamname,
    COALESCE(received_teams.country, 'Unknown'),
    'FootballManagement',
    received_teams.teamid,
    received_teams.yearfounded
FROM received_teams
CROSS JOIN max_team;

INSERT INTO integration_team_map (source_system, source_team_id, integrated_team_id)
SELECT 'FootballManagement', t.teamid, it.team_id
FROM public.team t
JOIN teams it
    ON it.source_system = 'FootballManagement'
   AND it.received_team_id = t.teamid
ON CONFLICT (source_system, source_team_id) DO UPDATE
SET integrated_team_id = EXCLUDED.integrated_team_id;

-- -----------------------------------------------------------------------------
-- 5. Migrate received matches into the shared matches table
-- -----------------------------------------------------------------------------
WITH max_match AS (
    SELECT COALESCE(MAX(match_id), 0) AS max_id FROM matches
), received_matches AS (
    SELECT
        m.matchid,
        m.matchdate,
        m.stage,
        home_map.integrated_team_id AS home_team_id,
        away_map.integrated_team_id AS away_team_id,
        home_mt.score AS home_score,
        away_mt.score AS away_score,
        ROW_NUMBER() OVER (ORDER BY m.matchid) AS rn
    FROM public.match m
    LEFT JOIN public.matchteam home_mt
        ON home_mt.matchid = m.matchid
       AND home_mt.role = 'Home'
    LEFT JOIN integration_team_map home_map
        ON home_map.source_system = 'FootballManagement'
       AND home_map.source_team_id = home_mt.teamid
    LEFT JOIN public.matchteam away_mt
        ON away_mt.matchid = m.matchid
       AND away_mt.role = 'Away'
    LEFT JOIN integration_team_map away_map
        ON away_map.source_system = 'FootballManagement'
       AND away_map.source_team_id = away_mt.teamid
    WHERE NOT EXISTS (
        SELECT 1
        FROM matches existing
        WHERE existing.source_system = 'FootballManagement'
          AND existing.received_match_id = m.matchid
    )
)
INSERT INTO matches (
    match_id,
    match_date,
    status,
    final_result,
    home_team_id,
    away_team_id,
    source_system,
    received_match_id,
    competition_stage
)
SELECT
    max_match.max_id + received_matches.rn,
    COALESCE(received_matches.matchdate, CURRENT_DATE),
    'Finished',
    CASE
        WHEN received_matches.home_score IS NOT NULL AND received_matches.away_score IS NOT NULL
            THEN received_matches.home_score::TEXT || '-' || received_matches.away_score::TEXT
        ELSE NULL
    END,
    received_matches.home_team_id,
    received_matches.away_team_id,
    'FootballManagement',
    received_matches.matchid,
    received_matches.stage
FROM received_matches
CROSS JOIN max_match;

INSERT INTO integration_match_map (source_system, source_match_id, integrated_match_id)
SELECT 'FootballManagement', m.matchid, im.match_id
FROM public.match m
JOIN matches im
    ON im.source_system = 'FootballManagement'
   AND im.received_match_id = m.matchid
ON CONFLICT (source_system, source_match_id) DO UPDATE
SET integrated_match_id = EXCLUDED.integrated_match_id;

-- -----------------------------------------------------------------------------
-- 6. Create football-management entities that do not exist in BetMaster
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS football_players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50),
    birth_date DATE,
    position VARCHAR(30),
    height INT,
    strong_leg VARCHAR(10),
    native_country VARCHAR(50),
    source_id INT NOT NULL DEFAULT 2 REFERENCES integration_sources(source_id)
);

CREATE TABLE IF NOT EXISTS football_goalkeepers (
    player_id INT PRIMARY KEY REFERENCES football_players(player_id),
    gloves_number INT
);

CREATE TABLE IF NOT EXISTS football_player_contracts (
    player_id INT NOT NULL REFERENCES football_players(player_id),
    team_id INT NOT NULL REFERENCES teams(team_id),
    player_type VARCHAR(20) NOT NULL CHECK (player_type IN ('FieldPlayer', 'Goalkeeper')),
    start_date DATE,
    salary NUMERIC(10,2),
    PRIMARY KEY (player_id, team_id, player_type)
);

CREATE TABLE IF NOT EXISTS football_player_match_stats (
    player_id INT NOT NULL REFERENCES football_players(player_id),
    match_id INT NOT NULL REFERENCES matches(match_id),
    goals INT,
    assists INT,
    pass_completed INT,
    pass_attempts INT,
    tackles INT,
    yellow_card INT,
    red_card INT,
    PRIMARY KEY (player_id, match_id)
);

CREATE TABLE IF NOT EXISTS football_gk_match_stats (
    player_id INT NOT NULL REFERENCES football_goalkeepers(player_id),
    match_id INT NOT NULL REFERENCES matches(match_id),
    saves INT,
    goals_conceded INT,
    yellow_card INT,
    red_card INT,
    PRIMARY KEY (player_id, match_id)
);

CREATE TABLE IF NOT EXISTS football_coaches (
    coach_id INT PRIMARY KEY,
    coach_name VARCHAR(50),
    gender VARCHAR(10),
    birthday DATE,
    pro_date DATE,
    source_id INT NOT NULL DEFAULT 2 REFERENCES integration_sources(source_id)
);

CREATE TABLE IF NOT EXISTS football_coach_contracts (
    coach_id INT NOT NULL REFERENCES football_coaches(coach_id),
    team_id INT NOT NULL REFERENCES teams(team_id),
    start_date DATE,
    salary NUMERIC(10,2),
    PRIMARY KEY (coach_id, team_id)
);

CREATE TABLE IF NOT EXISTS football_referees (
    referee_id INT PRIMARY KEY,
    referee_name VARCHAR(50),
    gender VARCHAR(10),
    birthday DATE,
    pro_date DATE,
    source_id INT NOT NULL DEFAULT 2 REFERENCES integration_sources(source_id)
);

CREATE TABLE IF NOT EXISTS football_match_referees (
    match_id INT NOT NULL REFERENCES matches(match_id),
    referee_id INT NOT NULL REFERENCES football_referees(referee_id),
    PRIMARY KEY (match_id, referee_id)
);

CREATE TABLE IF NOT EXISTS football_stadiums (
    stadium_id INT PRIMARY KEY,
    stadium_name VARCHAR(50),
    city VARCHAR(50),
    capacity INT,
    year_founded INT,
    source_id INT NOT NULL DEFAULT 2 REFERENCES integration_sources(source_id)
);

CREATE TABLE IF NOT EXISTS football_match_stadiums (
    match_id INT PRIMARY KEY REFERENCES matches(match_id),
    stadium_id INT REFERENCES football_stadiums(stadium_id),
    attendees INT
);

ALTER TABLE teams
    ADD COLUMN IF NOT EXISTS home_stadium_id INT;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'fk_teams_home_stadium'
    ) THEN
        ALTER TABLE teams
            ADD CONSTRAINT fk_teams_home_stadium
            FOREIGN KEY (home_stadium_id)
            REFERENCES football_stadiums(stadium_id);
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS football_team_home_stadiums (
    team_id INT PRIMARY KEY REFERENCES teams(team_id),
    stadium_id INT NOT NULL REFERENCES football_stadiums(stadium_id),
    home_match_count INT NOT NULL,
    distinct_home_stadiums INT NOT NULL,
    source_rule VARCHAR(160) NOT NULL DEFAULT 'Team home stadium derived from matches where the team is marked Home'
);

-- -----------------------------------------------------------------------------
-- 7. Migrate received football-management data
-- -----------------------------------------------------------------------------
INSERT INTO football_players (player_id, player_name, birth_date, position, height, strong_leg, native_country)
SELECT playerid, playername, birthdate, "position", height, strongleg, nativecountry
FROM public.player
ON CONFLICT (player_id) DO UPDATE
SET player_name = EXCLUDED.player_name,
    birth_date = EXCLUDED.birth_date,
    position = EXCLUDED.position,
    height = EXCLUDED.height,
    strong_leg = EXCLUDED.strong_leg,
    native_country = EXCLUDED.native_country;

INSERT INTO football_goalkeepers (player_id, gloves_number)
SELECT playerid, glovesnumber
FROM public.goalkeeper
ON CONFLICT (player_id) DO UPDATE
SET gloves_number = EXCLUDED.gloves_number;

INSERT INTO football_player_contracts (player_id, team_id, player_type, start_date, salary)
SELECT pfp.playerid, tm.integrated_team_id, 'FieldPlayer', pfp.startdate, pfp.salary
FROM public.playsfor_player pfp
JOIN integration_team_map tm
    ON tm.source_system = 'FootballManagement'
   AND tm.source_team_id = pfp.teamid
ON CONFLICT (player_id, team_id, player_type) DO UPDATE
SET start_date = EXCLUDED.start_date,
    salary = EXCLUDED.salary;

INSERT INTO football_player_contracts (player_id, team_id, player_type, start_date, salary)
SELECT pfg.playerid, tm.integrated_team_id, 'Goalkeeper', pfg.startdate, pfg.salary
FROM public.playsfor_gk pfg
JOIN integration_team_map tm
    ON tm.source_system = 'FootballManagement'
   AND tm.source_team_id = pfg.teamid
ON CONFLICT (player_id, team_id, player_type) DO UPDATE
SET start_date = EXCLUDED.start_date,
    salary = EXCLUDED.salary;

INSERT INTO football_player_match_stats (
    player_id, match_id, goals, assists, pass_completed, pass_attempts,
    tackles, yellow_card, red_card
)
SELECT
    pms.playerid,
    mm.integrated_match_id,
    pms.goals,
    pms.assists,
    pms.passcompleted,
    pms.passattempts,
    pms.tackles,
    pms.yellowcard,
    pms.redcard
FROM public.playermatchstats pms
JOIN integration_match_map mm
    ON mm.source_system = 'FootballManagement'
   AND mm.source_match_id = pms.matchid
ON CONFLICT (player_id, match_id) DO UPDATE
SET goals = EXCLUDED.goals,
    assists = EXCLUDED.assists,
    pass_completed = EXCLUDED.pass_completed,
    pass_attempts = EXCLUDED.pass_attempts,
    tackles = EXCLUDED.tackles,
    yellow_card = EXCLUDED.yellow_card,
    red_card = EXCLUDED.red_card;

INSERT INTO football_gk_match_stats (player_id, match_id, saves, goals_conceded, yellow_card, red_card)
SELECT gk.playerid, mm.integrated_match_id, gk.saves, gk.goalsconceded, gk.yellowcard, gk.redcard
FROM public.gkmatchstats gk
JOIN integration_match_map mm
    ON mm.source_system = 'FootballManagement'
   AND mm.source_match_id = gk.matchid
ON CONFLICT (player_id, match_id) DO UPDATE
SET saves = EXCLUDED.saves,
    goals_conceded = EXCLUDED.goals_conceded,
    yellow_card = EXCLUDED.yellow_card,
    red_card = EXCLUDED.red_card;

INSERT INTO football_coaches (coach_id, coach_name, gender, birthday, pro_date)
SELECT coachid, coachname, gender, birthday, prodate
FROM public.coach
ON CONFLICT (coach_id) DO UPDATE
SET coach_name = EXCLUDED.coach_name,
    gender = EXCLUDED.gender,
    birthday = EXCLUDED.birthday,
    pro_date = EXCLUDED.pro_date;

INSERT INTO football_coach_contracts (coach_id, team_id, start_date, salary)
SELECT cb.coachid, tm.integrated_team_id, cb.startdate, cb.salary
FROM public.coachedby cb
JOIN integration_team_map tm
    ON tm.source_system = 'FootballManagement'
   AND tm.source_team_id = cb.teamid
ON CONFLICT (coach_id, team_id) DO UPDATE
SET start_date = EXCLUDED.start_date,
    salary = EXCLUDED.salary;

INSERT INTO football_referees (referee_id, referee_name, gender, birthday, pro_date)
SELECT refereeid, refereename, gender, birthday, prodate
FROM public.referee
ON CONFLICT (referee_id) DO UPDATE
SET referee_name = EXCLUDED.referee_name,
    gender = EXCLUDED.gender,
    birthday = EXCLUDED.birthday,
    pro_date = EXCLUDED.pro_date;

INSERT INTO football_match_referees (match_id, referee_id)
SELECT mm.integrated_match_id, ra.refereeid
FROM public.refereeat ra
JOIN integration_match_map mm
    ON mm.source_system = 'FootballManagement'
   AND mm.source_match_id = ra.matchid
ON CONFLICT (match_id, referee_id) DO NOTHING;

INSERT INTO football_stadiums (stadium_id, stadium_name, city, capacity, year_founded)
SELECT stadiumid, stadiumname, city, capacity, yearfounded
FROM public.stadium
ON CONFLICT (stadium_id) DO UPDATE
SET stadium_name = EXCLUDED.stadium_name,
    city = EXCLUDED.city,
    capacity = EXCLUDED.capacity,
    year_founded = EXCLUDED.year_founded;

INSERT INTO football_match_stadiums (match_id, stadium_id, attendees)
SELECT mm.integrated_match_id, ms.stadiumid, ms.attendees
FROM public.matchstadium ms
JOIN integration_match_map mm
    ON mm.source_system = 'FootballManagement'
   AND mm.source_match_id = ms.matchid
ON CONFLICT (match_id) DO UPDATE
SET stadium_id = EXCLUDED.stadium_id,
    attendees = EXCLUDED.attendees;

-- Link each team to its home stadium. In football terms, when a team is marked
-- Home, the stadium of that match is treated as that team's home stadium. If the
-- received data contains several home stadiums for the same team, the stadium
-- used most often is selected and distinct_home_stadiums documents the conflict.
WITH home_match_stadiums AS (
    SELECT
        tm.integrated_team_id AS team_id,
        ms.stadiumid AS stadium_id
    FROM public.matchteam mt
    JOIN public.matchstadium ms
        ON ms.matchid = mt.matchid
    JOIN integration_team_map tm
        ON tm.source_system = 'FootballManagement'
       AND tm.source_team_id = mt.teamid
    WHERE mt.role = 'Home'
      AND ms.stadiumid IS NOT NULL
), stadium_counts AS (
    SELECT
        team_id,
        stadium_id,
        COUNT(*) AS home_match_count
    FROM home_match_stadiums
    GROUP BY team_id, stadium_id
), stadium_diversity AS (
    SELECT
        team_id,
        COUNT(DISTINCT stadium_id) AS distinct_home_stadiums
    FROM home_match_stadiums
    GROUP BY team_id
), ranked_home_stadiums AS (
    SELECT
        sc.team_id,
        sc.stadium_id,
        sc.home_match_count,
        sd.distinct_home_stadiums,
        ROW_NUMBER() OVER (
            PARTITION BY sc.team_id
            ORDER BY sc.home_match_count DESC, sc.stadium_id
        ) AS rn
    FROM stadium_counts sc
    JOIN stadium_diversity sd
        ON sd.team_id = sc.team_id
)
INSERT INTO football_team_home_stadiums (
    team_id,
    stadium_id,
    home_match_count,
    distinct_home_stadiums
)
SELECT
    team_id,
    stadium_id,
    home_match_count,
    distinct_home_stadiums
FROM ranked_home_stadiums
WHERE rn = 1
ON CONFLICT (team_id) DO UPDATE
SET stadium_id = EXCLUDED.stadium_id,
    home_match_count = EXCLUDED.home_match_count,
    distinct_home_stadiums = EXCLUDED.distinct_home_stadiums;

UPDATE teams t
SET home_stadium_id = fths.stadium_id
FROM football_team_home_stadiums fths
WHERE fths.team_id = t.team_id;

-- Validation: rows returned here indicate teams whose received home matches
-- used more than one stadium, so the selected home stadium should be reviewed.
SELECT
    t.team_id,
    t.team_name,
    fths.distinct_home_stadiums,
    fs.stadium_name AS selected_home_stadium
FROM football_team_home_stadiums fths
JOIN teams t
    ON t.team_id = fths.team_id
JOIN football_stadiums fs
    ON fs.stadium_id = fths.stadium_id
WHERE fths.distinct_home_stadiums > 1
ORDER BY fths.distinct_home_stadiums DESC, t.team_name;

-- -----------------------------------------------------------------------------
-- 8. Validation queries for report screenshots
-- -----------------------------------------------------------------------------
SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL SELECT 'teams', COUNT(*) FROM teams
UNION ALL SELECT 'matches', COUNT(*) FROM matches
UNION ALL SELECT 'odds', COUNT(*) FROM odds
UNION ALL SELECT 'bets', COUNT(*) FROM bets
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'football_players', COUNT(*) FROM football_players
UNION ALL SELECT 'football_player_contracts', COUNT(*) FROM football_player_contracts
UNION ALL SELECT 'football_player_match_stats', COUNT(*) FROM football_player_match_stats
UNION ALL SELECT 'football_coaches', COUNT(*) FROM football_coaches
UNION ALL SELECT 'football_referees', COUNT(*) FROM football_referees
UNION ALL SELECT 'football_stadiums', COUNT(*) FROM football_stadiums
UNION ALL SELECT 'football_team_home_stadiums', COUNT(*) FROM football_team_home_stadiums
UNION ALL SELECT 'football_match_referees', COUNT(*) FROM football_match_referees
ORDER BY table_name;

COMMIT;

