INSERT INTO users (user_id, full_name, email, balance, registration_date, account_status)
VALUES
(1, 'Levi Kaprow', 'levi@example.com', 500.00, '2026-01-10', 'Active'),
(2, 'Tzvi Ben David', 'tzvi@example.com', 700.00, '2026-01-11', 'Active'),
(3, 'Daniel Cohen', 'daniel@example.com', 300.00, '2026-01-12', 'Active'),
(4, 'Yossi Mizrahi', 'yossi@example.com', 850.00, '2026-01-13', 'Active'),
(5, 'Avi Levi', 'avi@example.com', 420.00, '2026-01-14', 'Active');

INSERT INTO teams (team_id, team_name, country)
VALUES
(1, 'Maccabi Haifa', 'Israel'),
(2, 'Hapoel Beer Sheva', 'Israel'),
(3, 'Maccabi Tel Aviv', 'Israel'),
(4, 'Beitar Jerusalem', 'Israel'),
(5, 'Barcelona', 'Spain'),
(6, 'Real Madrid', 'Spain'),
(7, 'Manchester City', 'England'),
(8, 'Liverpool', 'England');

INSERT INTO matches (match_id, match_date, status, final_result, home_team_id, away_team_id)
VALUES
(1, '2026-04-20', 'Scheduled', NULL, 1, 2),
(2, '2026-04-21', 'Scheduled', NULL, 3, 4),
(3, '2026-04-22', 'Scheduled', NULL, 5, 6),
(4, '2026-04-23', 'Scheduled', NULL, 7, 8);

INSERT INTO odds (odd_id, home_win_odd, draw_odd, away_win_odd, update_date, match_id)
VALUES
(1, 1.80, 3.20, 2.50, '2026-04-15', 1),
(2, 2.10, 3.00, 1.95, '2026-04-15', 2),
(3, 2.30, 3.10, 1.75, '2026-04-15', 3),
(4, 1.95, 3.40, 2.05, '2026-04-15', 4);

INSERT INTO bets (bet_id, predicted_result, bet_amount, bet_date, bet_status, user_id, match_id)
VALUES
(1, 'Home', 100.00, '2026-04-15', 'Pending', 1, 1),
(2, 'Away', 150.00, '2026-04-15', 'Pending', 2, 2),
(3, 'Draw', 80.00, '2026-04-15', 'Pending', 3, 3),
(4, 'Home', 120.00, '2026-04-15', 'Pending', 4, 4),
(5, 'Away', 60.00, '2026-04-15', 'Pending', 5, 1);

INSERT INTO transactions (transaction_id, amount, transaction_type, transaction_date, user_id)
VALUES
(1, 500.00, 'Deposit', '2026-04-10', 1),
(2, 700.00, 'Deposit', '2026-04-11', 2),
(3, 300.00, 'Deposit', '2026-04-12', 3),
(4, 850.00, 'Deposit', '2026-04-13', 4),
(5, 420.00, 'Deposit', '2026-04-14', 5),
(6, 100.00, 'Bet Placement', '2026-04-15', 1),
(7, 150.00, 'Bet Placement', '2026-04-15', 2),
(8, 80.00, 'Bet Placement', '2026-04-15', 3),
(9, 120.00, 'Bet Placement', '2026-04-15', 4),
(10, 60.00, 'Bet Placement', '2026-04-15', 5);