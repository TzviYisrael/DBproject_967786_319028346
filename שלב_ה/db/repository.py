class Repository:
    TABLE_META = {
        "users": {
            "display_name": "Users",
            "pk": ["user_id"],
            "columns": [
                {"name": "user_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "full_name", "type": "VARCHAR", "display": "Full Name"},
                {"name": "email", "type": "VARCHAR", "display": "Email"},
                {"name": "balance", "type": "NUMERIC", "display": "Balance"},
                {"name": "registration_date", "type": "DATE", "display": "Reg. Date"},
                {"name": "account_status", "type": "VARCHAR", "display": "Status"},
            ],
            "order_by": "user_id",
        },
        "teams": {
            "display_name": "Teams",
            "pk": ["team_id"],
            "columns": [
                {"name": "team_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "team_name", "type": "VARCHAR", "display": "Team Name"},
                {"name": "country", "type": "VARCHAR", "display": "Country"},
                {"name": "source_system", "type": "VARCHAR", "display": "Source"},
                {"name": "year_founded", "type": "INTEGER", "display": "Founded"},
                {"name": "home_stadium_id", "type": "INTEGER", "display": "Home Stadium", "is_fk": True, "ref_table": "football_stadiums", "ref_pk": "stadium_id", "ref_display": "stadium_name"},
            ],
            "order_by": "team_id",
        },
        "matches": {
            "display_name": "Matches",
            "pk": ["match_id"],
            "columns": [
                {"name": "match_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "match_date", "type": "DATE", "display": "Date"},
                {"name": "status", "type": "VARCHAR", "display": "Status"},
                {"name": "final_result", "type": "VARCHAR", "display": "Result"},
                {"name": "home_team_id", "type": "INTEGER", "display": "Home Team", "is_fk": True, "ref_table": "teams", "ref_pk": "team_id", "ref_display": "team_name"},
                {"name": "away_team_id", "type": "INTEGER", "display": "Away Team", "is_fk": True, "ref_table": "teams", "ref_pk": "team_id", "ref_display": "team_name"},
                {"name": "source_system", "type": "VARCHAR", "display": "Source"},
                {"name": "competition_stage", "type": "VARCHAR", "display": "Stage"},
            ],
            "order_by": "match_date DESC",
        },
        "odds": {
            "display_name": "Odds",
            "pk": ["odd_id"],
            "columns": [
                {"name": "odd_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "home_win_odd", "type": "NUMERIC", "display": "Home Win"},
                {"name": "draw_odd", "type": "NUMERIC", "display": "Draw"},
                {"name": "away_win_odd", "type": "NUMERIC", "display": "Away Win"},
                {"name": "update_date", "type": "DATE", "display": "Updated"},
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
            ],
            "order_by": "odd_id",
        },
        "bets": {
            "display_name": "Bets",
            "pk": ["bet_id"],
            "columns": [
                {"name": "bet_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "predicted_result", "type": "VARCHAR", "display": "Prediction"},
                {"name": "bet_amount", "type": "NUMERIC", "display": "Amount"},
                {"name": "bet_date", "type": "DATE", "display": "Bet Date"},
                {"name": "bet_status", "type": "VARCHAR", "display": "Status"},
                {"name": "user_id", "type": "INTEGER", "display": "User", "is_fk": True, "ref_table": "users", "ref_pk": "user_id", "ref_display": "full_name"},
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
            ],
            "order_by": "bet_id",
        },
        "transactions": {
            "display_name": "Transactions",
            "pk": ["transaction_id"],
            "columns": [
                {"name": "transaction_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "amount", "type": "NUMERIC", "display": "Amount"},
                {"name": "transaction_type", "type": "VARCHAR", "display": "Type"},
                {"name": "transaction_date", "type": "DATE", "display": "Date"},
                {"name": "user_id", "type": "INTEGER", "display": "User", "is_fk": True, "ref_table": "users", "ref_pk": "user_id", "ref_display": "full_name"},
            ],
            "order_by": "transaction_id",
        },
        "integration_sources": {
            "display_name": "Integration Sources",
            "pk": ["source_id"],
            "columns": [
                {"name": "source_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "source_name", "type": "VARCHAR", "display": "Name"},
                {"name": "source_description", "type": "VARCHAR", "display": "Description"},
                {"name": "received_backup_file", "type": "VARCHAR", "display": "Backup File"},
                {"name": "integrated_at", "type": "DATE", "display": "Integrated At"},
            ],
            "order_by": "source_id",
        },
        "football_players": {
            "display_name": "Football Players",
            "pk": ["player_id"],
            "columns": [
                {"name": "player_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "player_name", "type": "VARCHAR", "display": "Name"},
                {"name": "birth_date", "type": "DATE", "display": "Birth Date"},
                {"name": "position", "type": "VARCHAR", "display": "Position"},
                {"name": "height", "type": "INTEGER", "display": "Height"},
                {"name": "strong_leg", "type": "VARCHAR", "display": "Strong Leg"},
                {"name": "native_country", "type": "VARCHAR", "display": "Country"},
                {"name": "source_id", "type": "INTEGER", "display": "Source", "is_fk": True, "ref_table": "integration_sources", "ref_pk": "source_id", "ref_display": "source_name"},
            ],
            "order_by": "player_id",
        },
        "football_goalkeepers": {
            "display_name": "Goalkeepers",
            "pk": ["player_id"],
            "columns": [
                {"name": "player_id", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "football_players", "ref_pk": "player_id", "ref_display": "player_name"},
                {"name": "gloves_number", "type": "INTEGER", "display": "Gloves #"},
            ],
            "order_by": "player_id",
        },
        "football_player_contracts": {
            "display_name": "Player Contracts",
            "pk": ["player_id", "team_id", "player_type"],
            "columns": [
                {"name": "player_id", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "football_players", "ref_pk": "player_id", "ref_display": "player_name"},
                {"name": "team_id", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "teams", "ref_pk": "team_id", "ref_display": "team_name"},
                {"name": "player_type", "type": "VARCHAR", "display": "Type", "is_pk": True},
                {"name": "start_date", "type": "DATE", "display": "Start Date"},
                {"name": "salary", "type": "NUMERIC", "display": "Salary"},
            ],
            "order_by": "player_id, team_id",
        },
        "football_player_match_stats": {
            "display_name": "Player Match Stats",
            "pk": ["player_id", "match_id"],
            "columns": [
                {"name": "player_id", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "football_players", "ref_pk": "player_id", "ref_display": "player_name"},
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
                {"name": "goals", "type": "INTEGER", "display": "Goals"},
                {"name": "assists", "type": "INTEGER", "display": "Assists"},
                {"name": "pass_completed", "type": "INTEGER", "display": "Pass C."},
                {"name": "pass_attempts", "type": "INTEGER", "display": "Pass A."},
                {"name": "tackles", "type": "INTEGER", "display": "Tackles"},
                {"name": "yellow_card", "type": "INTEGER", "display": "Yellow"},
                {"name": "red_card", "type": "INTEGER", "display": "Red"},
            ],
            "order_by": "player_id, match_id",
        },
        "football_gk_match_stats": {
            "display_name": "GK Match Stats",
            "pk": ["player_id", "match_id"],
            "columns": [
                {"name": "player_id", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "football_players", "ref_pk": "player_id", "ref_display": "player_name"},
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
                {"name": "saves", "type": "INTEGER", "display": "Saves"},
                {"name": "goals_conceded", "type": "INTEGER", "display": "Conceded"},
                {"name": "yellow_card", "type": "INTEGER", "display": "Yellow"},
                {"name": "red_card", "type": "INTEGER", "display": "Red"},
            ],
            "order_by": "player_id, match_id",
        },
        "football_coaches": {
            "display_name": "Coaches",
            "pk": ["coach_id"],
            "columns": [
                {"name": "coach_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "coach_name", "type": "VARCHAR", "display": "Name"},
                {"name": "gender", "type": "VARCHAR", "display": "Gender"},
                {"name": "birthday", "type": "DATE", "display": "Birthday"},
                {"name": "pro_date", "type": "DATE", "display": "Pro Date"},
                {"name": "source_id", "type": "INTEGER", "display": "Source", "is_fk": True, "ref_table": "integration_sources", "ref_pk": "source_id", "ref_display": "source_name"},
            ],
            "order_by": "coach_id",
        },
        "football_coach_contracts": {
            "display_name": "Coach Contracts",
            "pk": ["coach_id", "team_id"],
            "columns": [
                {"name": "coach_id", "type": "INTEGER", "display": "Coach", "is_pk": True, "is_fk": True, "ref_table": "football_coaches", "ref_pk": "coach_id", "ref_display": "coach_name"},
                {"name": "team_id", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "teams", "ref_pk": "team_id", "ref_display": "team_name"},
                {"name": "start_date", "type": "DATE", "display": "Start Date"},
                {"name": "salary", "type": "NUMERIC", "display": "Salary"},
            ],
            "order_by": "coach_id, team_id",
        },
        "football_referees": {
            "display_name": "Referees",
            "pk": ["referee_id"],
            "columns": [
                {"name": "referee_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "referee_name", "type": "VARCHAR", "display": "Name"},
                {"name": "gender", "type": "VARCHAR", "display": "Gender"},
                {"name": "birthday", "type": "DATE", "display": "Birthday"},
                {"name": "pro_date", "type": "DATE", "display": "Pro Date"},
                {"name": "source_id", "type": "INTEGER", "display": "Source", "is_fk": True, "ref_table": "integration_sources", "ref_pk": "source_id", "ref_display": "source_name"},
            ],
            "order_by": "referee_id",
        },
        "football_match_referees": {
            "display_name": "Match Referees",
            "pk": ["match_id", "referee_id"],
            "columns": [
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
                {"name": "referee_id", "type": "INTEGER", "display": "Referee", "is_pk": True, "is_fk": True, "ref_table": "football_referees", "ref_pk": "referee_id", "ref_display": "referee_name"},
            ],
            "order_by": "match_id, referee_id",
        },
        "football_stadiums": {
            "display_name": "Stadiums",
            "pk": ["stadium_id"],
            "columns": [
                {"name": "stadium_id", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "stadium_name", "type": "VARCHAR", "display": "Name"},
                {"name": "city", "type": "VARCHAR", "display": "City"},
                {"name": "capacity", "type": "INTEGER", "display": "Capacity"},
                {"name": "year_founded", "type": "INTEGER", "display": "Founded"},
                {"name": "source_id", "type": "INTEGER", "display": "Source", "is_fk": True, "ref_table": "integration_sources", "ref_pk": "source_id", "ref_display": "source_name"},
            ],
            "order_by": "stadium_id",
        },
        "football_match_stadiums": {
            "display_name": "Match Stadiums",
            "pk": ["match_id"],
            "columns": [
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
                {"name": "stadium_id", "type": "INTEGER", "display": "Stadium", "is_fk": True, "ref_table": "football_stadiums", "ref_pk": "stadium_id", "ref_display": "stadium_name"},
                {"name": "attendees", "type": "INTEGER", "display": "Attendees"},
            ],
            "order_by": "match_id",
        },
        "football_team_home_stadiums": {
            "display_name": "Team Home Stadiums",
            "pk": ["team_id"],
            "columns": [
                {"name": "team_id", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "teams", "ref_pk": "team_id", "ref_display": "team_name"},
                {"name": "stadium_id", "type": "INTEGER", "display": "Stadium", "is_fk": True, "ref_table": "football_stadiums", "ref_pk": "stadium_id", "ref_display": "stadium_name"},
                {"name": "home_match_count", "type": "INTEGER", "display": "Home Matches"},
                {"name": "distinct_home_stadiums", "type": "INTEGER", "display": "Distinct Stadiums"},
                {"name": "source_rule", "type": "VARCHAR", "display": "Source Rule"},
            ],
            "order_by": "team_id",
        },
        "team": {
            "display_name": "Received Teams",
            "pk": ["teamid"],
            "columns": [
                {"name": "teamid", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "teamname", "type": "VARCHAR", "display": "Team Name"},
                {"name": "country", "type": "VARCHAR", "display": "Country"},
                {"name": "yearfounded", "type": "INTEGER", "display": "Founded"},
            ],
            "order_by": "teamid",
        },
        "player": {
            "display_name": "Received Players",
            "pk": ["playerid"],
            "columns": [
                {"name": "playerid", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "playername", "type": "VARCHAR", "display": "Name"},
                {"name": "birthdate", "type": "DATE", "display": "Birth Date"},
                {"name": "position", "type": "VARCHAR", "display": "Position"},
                {"name": "height", "type": "INTEGER", "display": "Height"},
                {"name": "strongleg", "type": "VARCHAR", "display": "Strong Leg"},
                {"name": "nativecountry", "type": "VARCHAR", "display": "Country"},
            ],
            "order_by": "playerid",
        },
        "goalkeeper": {
            "display_name": "Received Goalkeepers",
            "pk": ["playerid"],
            "columns": [
                {"name": "playerid", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "player", "ref_pk": "playerid", "ref_display": "playername"},
                {"name": "glovesnumber", "type": "INTEGER", "display": "Gloves #"},
            ],
            "order_by": "playerid",
        },
        "playsfor_player": {
            "display_name": "Received Player Contracts",
            "pk": ["playerid", "teamid"],
            "columns": [
                {"name": "playerid", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "player", "ref_pk": "playerid", "ref_display": "playername"},
                {"name": "teamid", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "team", "ref_pk": "teamid", "ref_display": "teamname"},
                {"name": "startdate", "type": "DATE", "display": "Start Date"},
                {"name": "salary", "type": "NUMERIC", "display": "Salary"},
            ],
            "order_by": "playerid, teamid",
        },
        "playsfor_gk": {
            "display_name": "Received GK Contracts",
            "pk": ["playerid", "teamid"],
            "columns": [
                {"name": "playerid", "type": "INTEGER", "display": "Goalkeeper", "is_pk": True, "is_fk": True, "ref_table": "goalkeeper", "ref_pk": "playerid", "ref_display_expr": "CONCAT('Goalkeeper #', {alias}.playerid)"},
                {"name": "teamid", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "team", "ref_pk": "teamid", "ref_display": "teamname"},
                {"name": "startdate", "type": "DATE", "display": "Start Date"},
                {"name": "salary", "type": "NUMERIC", "display": "Salary"},
            ],
            "order_by": "playerid, teamid",
        },
        "playermatchstats": {
            "display_name": "Received Player Match Stats",
            "pk": ["playerid", "matchid"],
            "columns": [
                {"name": "playerid", "type": "INTEGER", "display": "Player", "is_pk": True, "is_fk": True, "ref_table": "player", "ref_pk": "playerid", "ref_display": "playername"},
                {"name": "matchid", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "match", "ref_pk": "matchid", "ref_display_expr": "CONCAT('Match #', {alias}.matchid, ' (', {alias}.matchdate, ')')"},
                {"name": "goals", "type": "INTEGER", "display": "Goals"},
                {"name": "assists", "type": "INTEGER", "display": "Assists"},
                {"name": "passcompleted", "type": "INTEGER", "display": "Pass C."},
                {"name": "passattempts", "type": "INTEGER", "display": "Pass A."},
                {"name": "tackles", "type": "INTEGER", "display": "Tackles"},
                {"name": "yellowcard", "type": "INTEGER", "display": "Yellow"},
                {"name": "redcard", "type": "INTEGER", "display": "Red"},
            ],
            "order_by": "playerid, matchid",
        },
        "gkmatchstats": {
            "display_name": "Received GK Match Stats",
            "pk": ["playerid", "matchid"],
            "columns": [
                {"name": "playerid", "type": "INTEGER", "display": "Goalkeeper", "is_pk": True, "is_fk": True, "ref_table": "goalkeeper", "ref_pk": "playerid", "ref_display_expr": "CONCAT('Goalkeeper #', {alias}.playerid)"},
                {"name": "matchid", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "match", "ref_pk": "matchid", "ref_display_expr": "CONCAT('Match #', {alias}.matchid, ' (', {alias}.matchdate, ')')"},
                {"name": "saves", "type": "INTEGER", "display": "Saves"},
                {"name": "goalsconceded", "type": "INTEGER", "display": "Conceded"},
                {"name": "yellowcard", "type": "INTEGER", "display": "Yellow"},
                {"name": "redcard", "type": "INTEGER", "display": "Red"},
            ],
            "order_by": "playerid, matchid",
        },
        "coach": {
            "display_name": "Received Coaches",
            "pk": ["coachid"],
            "columns": [
                {"name": "coachid", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "coachname", "type": "VARCHAR", "display": "Name"},
                {"name": "gender", "type": "VARCHAR", "display": "Gender"},
                {"name": "birthday", "type": "DATE", "display": "Birthday"},
                {"name": "prodate", "type": "DATE", "display": "Pro Date"},
            ],
            "order_by": "coachid",
        },
        "coachedby": {
            "display_name": "Received Coach Contracts",
            "pk": ["coachid", "teamid"],
            "columns": [
                {"name": "coachid", "type": "INTEGER", "display": "Coach", "is_pk": True, "is_fk": True, "ref_table": "coach", "ref_pk": "coachid", "ref_display": "coachname"},
                {"name": "teamid", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "team", "ref_pk": "teamid", "ref_display": "teamname"},
                {"name": "startdate", "type": "DATE", "display": "Start Date"},
                {"name": "salary", "type": "NUMERIC", "display": "Salary"},
            ],
            "order_by": "coachid, teamid",
        },
        "referee": {
            "display_name": "Received Referees",
            "pk": ["refereeid"],
            "columns": [
                {"name": "refereeid", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "refereename", "type": "VARCHAR", "display": "Name"},
                {"name": "gender", "type": "VARCHAR", "display": "Gender"},
                {"name": "birthday", "type": "DATE", "display": "Birthday"},
                {"name": "prodate", "type": "DATE", "display": "Pro Date"},
            ],
            "order_by": "refereeid",
        },
        "refereeat": {
            "display_name": "Received Match Referees",
            "pk": ["matchid", "refereeid"],
            "columns": [
                {"name": "matchid", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "match", "ref_pk": "matchid", "ref_display_expr": "CONCAT('Match #', {alias}.matchid, ' (', {alias}.matchdate, ')')"},
                {"name": "refereeid", "type": "INTEGER", "display": "Referee", "is_pk": True, "is_fk": True, "ref_table": "referee", "ref_pk": "refereeid", "ref_display": "refereename"},
            ],
            "order_by": "matchid, refereeid",
        },
        "stadium": {
            "display_name": "Received Stadiums",
            "pk": ["stadiumid"],
            "columns": [
                {"name": "stadiumid", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "stadiumname", "type": "VARCHAR", "display": "Name"},
                {"name": "city", "type": "VARCHAR", "display": "City"},
                {"name": "capacity", "type": "INTEGER", "display": "Capacity"},
                {"name": "yearfounded", "type": "INTEGER", "display": "Founded"},
            ],
            "order_by": "stadiumid",
        },
        "match": {
            "display_name": "Received Matches",
            "pk": ["matchid"],
            "columns": [
                {"name": "matchid", "type": "INTEGER", "display": "ID", "is_pk": True},
                {"name": "matchdate", "type": "DATE", "display": "Date"},
                {"name": "stage", "type": "VARCHAR", "display": "Stage"},
            ],
            "order_by": "matchdate DESC",
        },
        "matchteam": {
            "display_name": "Received Match Teams",
            "pk": ["matchid", "teamid"],
            "columns": [
                {"name": "matchid", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "match", "ref_pk": "matchid", "ref_display_expr": "CONCAT('Match #', {alias}.matchid, ' (', {alias}.matchdate, ')')"},
                {"name": "teamid", "type": "INTEGER", "display": "Team", "is_pk": True, "is_fk": True, "ref_table": "team", "ref_pk": "teamid", "ref_display": "teamname"},
                {"name": "role", "type": "VARCHAR", "display": "Role"},
                {"name": "score", "type": "INTEGER", "display": "Score"},
                {"name": "winloss", "type": "VARCHAR", "display": "Win/Loss"},
            ],
            "order_by": "matchid, teamid",
        },
        "matchstadium": {
            "display_name": "Received Match Stadiums",
            "pk": ["matchid"],
            "columns": [
                {"name": "matchid", "type": "INTEGER", "display": "Match", "is_pk": True, "is_fk": True, "ref_table": "match", "ref_pk": "matchid", "ref_display_expr": "CONCAT('Match #', {alias}.matchid, ' (', {alias}.matchdate, ')')"},
                {"name": "stadiumid", "type": "INTEGER", "display": "Stadium", "is_fk": True, "ref_table": "stadium", "ref_pk": "stadiumid", "ref_display": "stadiumname"},
                {"name": "attendees", "type": "INTEGER", "display": "Attendees"},
            ],
            "order_by": "matchid",
        },
        "account_audit_log": {
            "display_name": "Account Audit Log",
            "pk": ["audit_id"],
            "columns": [
                {"name": "audit_id", "type": "BIGINT", "display": "ID", "is_pk": True},
                {"name": "user_id", "type": "INTEGER", "display": "User", "is_fk": True, "ref_table": "users", "ref_pk": "user_id", "ref_display": "full_name"},
                {"name": "old_balance", "type": "NUMERIC", "display": "Old Balance"},
                {"name": "new_balance", "type": "NUMERIC", "display": "New Balance"},
                {"name": "balance_delta", "type": "NUMERIC", "display": "Delta"},
                {"name": "old_status", "type": "VARCHAR", "display": "Old Status"},
                {"name": "new_status", "type": "VARCHAR", "display": "New Status"},
                {"name": "audit_reason", "type": "VARCHAR", "display": "Reason"},
                {"name": "changed_at", "type": "TIMESTAMP", "display": "Changed At"},
            ],
            "order_by": "audit_id DESC",
        },
        "risk_review_queue": {
            "display_name": "Risk Review Queue",
            "pk": ["review_id"],
            "columns": [
                {"name": "review_id", "type": "BIGINT", "display": "ID", "is_pk": True},
                {"name": "user_id", "type": "INTEGER", "display": "User", "is_fk": True, "ref_table": "users", "ref_pk": "user_id", "ref_display": "full_name"},
                {"name": "risk_score", "type": "NUMERIC", "display": "Risk Score"},
                {"name": "reason", "type": "VARCHAR", "display": "Reason"},
                {"name": "status", "type": "VARCHAR", "display": "Status"},
                {"name": "opened_at", "type": "TIMESTAMP", "display": "Opened At"},
                {"name": "closed_at", "type": "TIMESTAMP", "display": "Closed At"},
            ],
            "order_by": "risk_score DESC",
        },
        "match_settlement_log": {
            "display_name": "Match Settlement Log",
            "pk": ["settlement_log_id"],
            "columns": [
                {"name": "settlement_log_id", "type": "BIGINT", "display": "ID", "is_pk": True},
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
                {"name": "final_result", "type": "VARCHAR", "display": "Result"},
                {"name": "affected_bets", "type": "INTEGER", "display": "Affected Bets"},
                {"name": "paid_winnings", "type": "NUMERIC", "display": "Paid Winnings"},
                {"name": "settled_at", "type": "TIMESTAMP", "display": "Settled At"},
                {"name": "details", "type": "VARCHAR", "display": "Details"},
            ],
            "order_by": "settlement_log_id DESC",
        },
        "odds_audit_log": {
            "display_name": "Odds Audit Log",
            "pk": ["odds_audit_id"],
            "columns": [
                {"name": "odds_audit_id", "type": "BIGINT", "display": "ID", "is_pk": True},
                {"name": "odd_id", "type": "INTEGER", "display": "Odd", "is_fk": True, "ref_table": "odds", "ref_pk": "odd_id", "ref_display_expr": "CONCAT('Odd #', {alias}.odd_id)"},
                {"name": "match_id", "type": "INTEGER", "display": "Match", "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
                {"name": "old_home_win_odd", "type": "NUMERIC", "display": "Old Home"},
                {"name": "new_home_win_odd", "type": "NUMERIC", "display": "New Home"},
                {"name": "old_draw_odd", "type": "NUMERIC", "display": "Old Draw"},
                {"name": "new_draw_odd", "type": "NUMERIC", "display": "New Draw"},
                {"name": "old_away_win_odd", "type": "NUMERIC", "display": "Old Away"},
                {"name": "new_away_win_odd", "type": "NUMERIC", "display": "New Away"},
                {"name": "changed_at", "type": "TIMESTAMP", "display": "Changed At"},
                {"name": "change_reason", "type": "VARCHAR", "display": "Reason"},
            ],
            "order_by": "odds_audit_id DESC",
        },
        "integration_team_map": {
            "display_name": "Integration Team Map",
            "pk": ["source_system", "source_team_id"],
            "columns": [
                {"name": "source_system", "type": "VARCHAR", "display": "Source", "is_pk": True},
                {"name": "source_team_id", "type": "INTEGER", "display": "Source Team ID", "is_pk": True},
                {"name": "integrated_team_id", "type": "INTEGER", "display": "Team", "is_fk": True, "ref_table": "teams", "ref_pk": "team_id", "ref_display": "team_name"},
            ],
            "order_by": "source_system, source_team_id",
        },
        "integration_match_map": {
            "display_name": "Integration Match Map",
            "pk": ["source_system", "source_match_id"],
            "columns": [
                {"name": "source_system", "type": "VARCHAR", "display": "Source", "is_pk": True},
                {"name": "source_match_id", "type": "INTEGER", "display": "Source Match ID", "is_pk": True},
                {"name": "integrated_match_id", "type": "INTEGER", "display": "Match", "is_fk": True, "ref_table": "matches", "ref_pk": "match_id", "ref_display_expr": "CONCAT('Match #', {alias}.match_id, ' (', {alias}.match_date, ')')"},
            ],
            "order_by": "source_system, source_match_id",
        },
    }

    QUERIES = {
        "Top Recent Winners": """
            SELECT
                u.user_id, u.full_name, u.email,
                EXTRACT(YEAR FROM u.registration_date) as reg_year,
                SUM(t.amount) as total_winnings,
                COUNT(t.transaction_id) as winning_count
            FROM users u
            JOIN transactions t ON u.user_id = t.user_id
            WHERE t.transaction_type = 'Winnings'
              AND u.registration_date >= CURRENT_DATE - INTERVAL '6 months'
            GROUP BY u.user_id, u.full_name, u.email, u.registration_date
            HAVING SUM(t.amount) > 500
            ORDER BY total_winnings DESC
        """,
        "Suspicious Winning Patterns": """
            SELECT
                u.user_id, u.full_name, u.email,
                EXTRACT(YEAR FROM u.registration_date) as joined_year,
                COUNT(b.bet_id) as total_settled_bets,
                SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) as wins,
                ROUND(CAST(SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC)
                    / COUNT(b.bet_id) * 100, 2) as win_rate_percentage
            FROM users u
            JOIN bets b ON u.user_id = b.user_id
            WHERE b.bet_status IN ('Won', 'Lost')
            GROUP BY u.user_id, u.full_name, u.email, u.registration_date
            HAVING COUNT(b.bet_id) >= 5
               AND (CAST(SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC)
                    / COUNT(b.bet_id)) > 0.75
            ORDER BY win_rate_percentage DESC
        """,
        "High-Value Regional Users": """
            SELECT
                u.user_id, u.full_name, u.email,
                EXTRACT(MONTH FROM u.registration_date) as reg_month,
                COUNT(b.bet_id) as bet_count,
                SUM(b.bet_amount) as total_invested
            FROM users u
            JOIN bets b ON u.user_id = b.user_id
            JOIN matches m ON b.match_id = m.match_id
            JOIN teams t_home ON m.home_team_id = t_home.team_id
            JOIN teams t_away ON m.away_team_id = t_away.team_id
            WHERE (t_home.country = 'Israel' OR t_away.country = 'Israel')
              AND u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
            GROUP BY u.user_id, u.full_name, u.email, u.registration_date
            HAVING SUM(b.bet_amount) > 300
            ORDER BY total_invested DESC
        """,
        "Away Team Upsets": """
            SELECT
                m.match_id, m.match_date,
                t_home.team_name as home_team,
                t_away.team_name as away_team,
                o.away_win_odd
            FROM matches m
            JOIN teams t_home ON m.home_team_id = t_home.team_id
            JOIN teams t_away ON m.away_team_id = t_away.team_id
            JOIN odds o ON m.match_id = o.match_id
            WHERE m.final_result = 'Away'
              AND o.away_win_odd > 3.5
            ORDER BY o.away_win_odd DESC
        """,
        "Monthly Cash Flow": """
            SELECT
                EXTRACT(YEAR FROM transaction_date) as year,
                EXTRACT(MONTH FROM transaction_date) as month,
                COUNT(transaction_id) as txn_count,
                SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END) as total_deposits,
                SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END) as total_withdrawals,
                SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE -amount END) as net_flow
            FROM transactions
            GROUP BY EXTRACT(YEAR FROM transaction_date), EXTRACT(MONTH FROM transaction_date)
            HAVING SUM(amount) > 5000
            ORDER BY year DESC, month DESC
        """,
    }

    PROCEDURES = {
        "Settle Match (proc_settle_match)": {
            "type": "procedure",
            "name": "proc_settle_match",
            "params": [
                {"name": "p_match_id", "type": "INTEGER", "label": "Match ID", "default": ""},
                {"name": "p_final_result", "type": "VARCHAR", "label": "Final Result", "default": "Home", "options": ["Home", "Draw", "Away"]},
            ],
            "description": "Settle a match: update status, pay winning bets, log settlement",
        },
        "Recalculate User Statuses (proc_recalculate_user_statuses)": {
            "type": "procedure",
            "name": "proc_recalculate_user_statuses",
            "params": [
                {"name": "p_high_pending_amount", "type": "NUMERIC", "label": "High Pending Amount", "default": "2000"},
                {"name": "p_low_balance", "type": "NUMERIC", "label": "Low Balance Threshold", "default": "500"},
                {"name": "p_max_users", "type": "INTEGER", "label": "Max Users", "default": "100"},
            ],
            "description": "Re-evaluate account statuses (Blocked/Inactive/Active) based on risk rules",
        },
        "Match Financial Summary (fn_match_financial_summary)": {
            "type": "function",
            "name": "fn_match_financial_summary",
            "params": [
                {"name": "p_match_id", "type": "INTEGER", "label": "Match ID (leave empty for all)", "default": ""},
            ],
            "description": "Show financial exposure per match (bets, stakes, potential liability)",
        },
        "Open User Risk Report (fn_open_user_risk_report)": {
            "type": "function_refcursor",
            "name": "fn_open_user_risk_report",
            "params": [
                {"name": "p_min_risk_score", "type": "NUMERIC", "label": "Min Risk Score", "default": "50"},
            ],
            "description": "Calculate risk scores and insert into risk_review_queue",
            "fetch_sql": "SELECT * FROM risk_review_queue WHERE status = 'Open' ORDER BY risk_score DESC LIMIT 25",
        },
    }

    def __init__(self, db):
        self.db = db

    def get_table_list(self):
        return list(self.TABLE_META.keys())

    def get_table_meta(self, table_name):
        return self.TABLE_META[table_name]

    MAX_ROWS = 500

    def _build_select_query(self, table_name, limit=None, offset=None, search=None, search_cols=None):
        meta = self.TABLE_META[table_name]
        table_alias = "t"

        select_parts = []
        joins = []
        alias_counter = 1

        for col in meta["columns"]:
            if col.get("is_fk") and col.get("ref_table"):
                ref_table = col["ref_table"]
                ref_pk = col["ref_pk"]
                ref_display_expr = col.get("ref_display_expr")
                ref_display = col.get("ref_display")

                alias = f"ref_{alias_counter}"
                alias_counter += 1

                if ref_display_expr:
                    expr = ref_display_expr.replace("{alias}", alias)
                    select_parts.append(f"{expr} AS \"{col['display']}\"")
                else:
                    select_parts.append(f"{alias}.{ref_display} AS \"{col['display']}\"")

                join_cond = f"{table_alias}.{col['name']} = {alias}.{ref_pk}"
                joins.append(f"LEFT JOIN {ref_table} {alias} ON {join_cond}")
            else:
                if col["name"] == col.get("display", col["name"]):
                    select_parts.append(f"{table_alias}.{col['name']}")
                else:
                    select_parts.append(f"{table_alias}.{col['name']} AS \"{col['display']}\"")

        select_clause = ",\n    ".join(select_parts)
        from_clause = f"FROM {table_name} {table_alias}"
        join_clause = "\n".join(joins) if joins else ""

        where_parts = []
        if table_name == "users":
            where_parts.append(f"{table_alias}.account_status != 'Deleted'")

        if search:
            searchable = []
            if search_cols:
                for col in meta["columns"]:
                    if col["name"] in search_cols and col.get("type") in ("VARCHAR", "NUMERIC", "INTEGER"):
                        searchable.append(f"CAST({table_alias}.{col['name']} AS TEXT)")
            else:
                for col in meta["columns"]:
                    if col.get("type") in ("VARCHAR",):
                        searchable.append(f"{table_alias}.{col['name']}")
            if searchable:
                like_clauses = [f"{c} ILIKE '%' || %s || '%'" for c in searchable]
                where_parts.append(f"({' OR '.join(like_clauses)})")

        where_clause = f"WHERE {' AND '.join(where_parts)}" if where_parts else ""

        order_by_raw = meta.get("order_by", "")
        if order_by_raw:
            qualified = []
            for part in order_by_raw.split(","):
                part = part.strip()
                if "." not in part:
                    tokens = part.split()
                    if len(tokens) == 2:
                        qualified.append(f"{table_alias}.{tokens[0]} {tokens[1]}")
                    else:
                        qualified.append(f"{table_alias}.{part}")
                else:
                    qualified.append(part)
            order_clause = f"ORDER BY {', '.join(qualified)}"
        else:
            order_clause = ""
        limit_clause = f"LIMIT {limit}" if limit else ""
        offset_clause = f"OFFSET {offset}" if offset else ""

        sql = f"SELECT\n    {select_clause}\n{from_clause}\n{join_clause}\n{order_clause}\n{limit_clause}\n{offset_clause}"
        return sql

    def _execute_select(self, table_name, limit, offset=0, search=None, search_cols=None):
        meta = self.TABLE_META[table_name]
        sql = self._build_select_query(table_name, limit=limit + 1, offset=offset,
                                       search=search, search_cols=search_cols)

        params = []
        if search:
            searchable_count = 0
            if search_cols:
                for col in meta["columns"]:
                    if col["name"] in search_cols:
                        searchable_count += 1
            else:
                for col in meta["columns"]:
                    if col.get("type") in ("VARCHAR",):
                        searchable_count += 1
            params = [search] * searchable_count

        cursor = self.db.get_cursor()
        cursor.execute(sql, params)

        display_cols = []
        for col in meta["columns"]:
            if col.get("is_fk"):
                display_cols.append(col["display"])
            else:
                if col["name"] == col.get("display", col["name"]):
                    display_cols.append(col["name"])
                else:
                    display_cols.append(col["display"])

        rows = cursor.fetchall()
        cursor.close()

        has_more = len(rows) > limit
        if has_more:
            rows = rows[:limit]

        return {"columns": display_cols, "rows": rows, "has_more": has_more, "limit": limit, "offset": offset}

    def fetch_all(self, table_name):
        return self._execute_select(table_name, self.MAX_ROWS, 0)

    def _get_pk_where(self, table_name, pk_values):
        meta = self.TABLE_META[table_name]
        conditions = []
        for i, pk_col in enumerate(meta["pk"]):
            conditions.append(f"{pk_col} = %s")
        return " AND ".join(conditions)

    def fetch_by_pk(self, table_name, pk_values):
        meta = self.TABLE_META[table_name]

        cols = [c["name"] for c in meta["columns"]]
        pk_where = self._get_pk_where(table_name, pk_values)

        sql = f"SELECT {', '.join(cols)} FROM {table_name} WHERE {pk_where}"
        cursor = self.db.get_cursor()
        cursor.execute(sql, pk_values)
        row = cursor.fetchone()
        cursor.close()

        if row:
            return dict(zip(cols, row))
        return None

    def insert(self, table_name, data):
        meta = self.TABLE_META[table_name]
        pk_cols = set(meta["pk"])

        insert_cols = []
        values = []
        for col in meta["columns"]:
            cname = col["name"]
            if cname in data and data[cname] is not None and data[cname] != "":
                insert_cols.append(cname)
                values.append(data[cname])

        if not insert_cols:
            raise ValueError("No data to insert")

        cols_str = ", ".join(insert_cols)
        placeholders = ", ".join(["%s"] * len(values))
        sql = f"INSERT INTO {table_name} ({cols_str}) VALUES ({placeholders})"

        cursor = self.db.get_cursor()
        try:
            cursor.execute(sql, values)
            cursor.connection.commit()
        except Exception as e:
            cursor.connection.rollback()
            raise e
        finally:
            cursor.close()

    def update(self, table_name, pk_values, data):
        meta = self.TABLE_META[table_name]
        pk_cols = meta["pk"]

        set_parts = []
        values = []
        for col in meta["columns"]:
            cname = col["name"]
            if cname in pk_cols:
                continue
            if cname in data and data[cname] is not None:
                set_parts.append(f"{cname} = %s")
                values.append(data[cname])

        if not set_parts:
            raise ValueError("No data to update")

        set_str = ", ".join(set_parts)
        pk_where = self._get_pk_where(table_name, pk_values)
        all_values = values + pk_values

        sql = f"UPDATE {table_name} SET {set_str} WHERE {pk_where}"

        cursor = self.db.get_cursor()
        try:
            cursor.execute(sql, all_values)
            cursor.connection.commit()
        except Exception as e:
            cursor.connection.rollback()
            raise e
        finally:
            cursor.close()

    def delete(self, table_name, pk_values):
        meta = self.TABLE_META[table_name]
        pk_where = self._get_pk_where(table_name, pk_values)

        if table_name == "users":
            sql = f"UPDATE users SET account_status = 'Deleted' WHERE {pk_where}"
        else:
            sql = f"DELETE FROM {table_name} WHERE {pk_where}"

        cursor = self.db.get_cursor()
        try:
            cursor.execute(sql, pk_values)
            cursor.connection.commit()
        except Exception as e:
            cursor.connection.rollback()
            raise e
        finally:
            cursor.close()

    def get_fk_options(self, table_name, fk_column):
        meta = self.TABLE_META[table_name]
        for col in meta["columns"]:
            if col["name"] == fk_column and col.get("is_fk"):
                ref_table = col["ref_table"]
                ref_pk = col["ref_pk"]
                ref_display = col.get("ref_display")
                ref_display_expr = col.get("ref_display_expr")

                if ref_display_expr:
                    expr_clean = ref_display_expr.replace("{alias}.", "")
                    sql = f"SELECT {ref_pk}, {expr_clean} AS display_value FROM {ref_table} ORDER BY {ref_pk}"
                else:
                    sql = f"SELECT {ref_pk}, {ref_display} FROM {ref_table} ORDER BY {ref_display}"

                cursor = self.db.get_cursor()
                cursor.execute(sql)
                rows = cursor.fetchall()
                cursor.close()
                return rows

        return []

    def execute_query(self, query_name):
        sql = self.QUERIES.get(query_name)
        if not sql:
            raise ValueError(f"Unknown query: {query_name}")

        cursor = self.db.get_cursor()
        cursor.execute(sql)
        columns = [desc[0] for desc in cursor.description]
        rows = cursor.fetchall()
        cursor.close()
        return {"columns": columns, "rows": rows}

    def execute_procedure(self, proc_name, params):
        meta_info = None
        for pname, pinfo in self.PROCEDURES.items():
            if pinfo["name"] == proc_name or pname == proc_name:
                meta_info = pinfo
                break

        if not meta_info:
            raise ValueError(f"Unknown procedure/function: {proc_name}")

        cursor = self.db.get_cursor()

        try:
            if meta_info["type"] == "procedure":
                placeholders = ", ".join(["%s"] * len(params))
                sql = f"CALL {proc_name}({placeholders})"
                cursor.execute(sql, params)
                cursor.connection.commit()
                cursor.close()
                return {"columns": [], "rows": [], "message": f"Procedure {proc_name} executed successfully"}

            elif meta_info["type"] == "function":
                placeholders = ", ".join(["%s"] * len(params))
                sql = f"SELECT * FROM {proc_name}({placeholders})"
                cursor.execute(sql, params)
                columns = [desc[0] for desc in cursor.description]
                rows = cursor.fetchall()
                cursor.close()
                return {"columns": columns, "rows": rows}

            elif meta_info["type"] == "function_refcursor":
                sql = f"SELECT * FROM {proc_name}({', '.join(['%s'] * len(params))})"
                cursor.execute(sql, params)
                cursor.fetchone()

                fetch_sql = meta_info.get("fetch_sql", "SELECT 1")
                cursor.execute(fetch_sql)
                columns = [desc[0] for desc in cursor.description]
                rows = cursor.fetchall()
                cursor.close()
                return {"columns": columns, "rows": rows}

        except Exception as e:
            cursor.connection.rollback()
            cursor.close()
            raise e
