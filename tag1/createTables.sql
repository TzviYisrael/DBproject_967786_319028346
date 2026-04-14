CREATE TABLE USERS (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    balance NUMERIC(12, 2) DEFAULT 0 CHECK (balance >= 0),
    registration_date DATE NOT NULL,
    account_status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE TEAMS (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL

CREATE TABLE MATCHES (
    match_id INT PRIMARY KEY,
    match_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    final_result VARCHAR(10),
    home_team_id INT,
    away_team_id INT,
    FOREIGN KEY (home_team_id) REFERENCES TEAMS(team_id),
    FOREIGN KEY (away_team_id) REFERENCES TEAMS(team_id) 
);

CREATE TABLE ODDS (
    odd_id INT PRIMARY KEY,
    home_win_odd NUMERIC(5, 2) CHECK (home_win_odd > 1),
    draw_odd NUMERIC(5, 2) CHECK (draw_odd > 1),
    away_win_odd NUMERIC(5, 2) CHECK (away_win_odd > 1),
    update_date DATE NOT NULL,
    match_id INT UNIQUE,
    FOREIGN KEY (match_id) REFERENCES MATCHES(match_id)
);

CREATE TABLE BETS (
    bet_id INT PRIMARY KEY,
    predicted_result VARCHAR(10) NOT NULL,
    bet_amount NUMERIC(10, 2) CHECK (bet_amount > 0),
    bet_date DATE NOT NULL,
    bet_status VARCHAR(20) DEFAULT 'Pending',
    user_id INT,
    match_id INT,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (match_id) REFERENCES MATCHES(match_id)
);

CREATE TABLE TRANSACTIONS (
    transaction_id INT PRIMARY KEY,
    amount NUMERIC(10, 2) NOT NULL,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Bet Placement', 'Winnings')),
    transaction_date DATE NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);