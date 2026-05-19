-- Delete Query 1: Cleanup Abandoned Accounts
-- Description: Deletes users who registered long ago but never interacted (no bets, no transactions).

-- SETUP FOR DEMO (Run this first to ensure there is data to delete)
INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) VALUES 
(9991, 'Ghost User 1', 'ghost1@example.com', 0.00, '2022-01-01', 'Active'),
(9992, 'Ghost User 2', 'ghost2@example.com', 0.00, '2021-05-15', 'Active'),
(9993, 'Ghost User 3', 'ghost3@example.com', 0.00, '2020-11-20', 'Active')
ON CONFLICT DO NOTHING;

-- INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) 
-- VALUES (8888, 'very User', 'ghost2@example.com', 0.00, '2020-01-01', 'Active')
-- ON CONFLICT DO NOTHING;
-- INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) 
-- VALUES (7777, 'Abandoned User', 'ghost3@example.com', 20.00, '2019-01-01', 'Active')
-- ON CONFLICT DO NOTHING;

-- 1. Show users to be deleted
SELECT * FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);

-- 2. Perform deletion
DELETE FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);

-- 3. Verify deletion (should return empty)
SELECT * FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);


