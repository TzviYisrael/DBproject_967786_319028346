-- Update Query 1: Loyalty Bonus for Winners
-- Description: Adds a balance bonus to active users who have won at least one bet.

-- SETUP FOR DEMO (Run this first to ensure there is data to update)
INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) VALUES 
(4441, 'Winner User 1', 'winner1@example.com', 100.00, CURRENT_DATE - INTERVAL '1 month', 'Active'),
(4442, 'Winner User 2', 'winner2@example.com', 200.00, CURRENT_DATE - INTERVAL '1 month', 'Active'),
(4443, 'Winner User 3', 'winner3@example.com', 50.00, CURRENT_DATE - INTERVAL '1 month', 'Active')
ON CONFLICT DO NOTHING;
INSERT INTO BETS (bet_id, user_id, match_id, bet_amount, bet_date, bet_status, predicted_result) VALUES
(4441, 4441, 1, 10.00, CURRENT_DATE - INTERVAL '5 days', 'Won', 'Home'),
(4442, 4442, 1, 10.00, CURRENT_DATE - INTERVAL '5 days', 'Won', 'Away'),
(4443, 4443, 1, 10.00, CURRENT_DATE - INTERVAL '5 days', 'Won', 'Draw')
ON CONFLICT DO NOTHING;

-- 1. Show balances before update
SELECT user_id, full_name, balance FROM USERS
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);

-- 2. Perform update
UPDATE USERS
SET balance = balance + 25.00
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);

-- 3. Show balances after update
SELECT user_id, full_name, balance FROM USERS
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);

