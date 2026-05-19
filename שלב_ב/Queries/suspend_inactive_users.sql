-- Update Query 2: Suspend Inactive Bettors
-- Description: Suspends users who haven't placed a bet in the last year.

-- SETUP FOR DEMO (Run this first to ensure there is data to update)
INSERT INTO USERS (user_id, full_name, email, balance, registration_date, account_status) VALUES 
(6661, 'Inactive User 1', 'inactive1@example.com', 50.00, '2020-01-01', 'Active'),
(6662, 'Inactive User 2', 'inactive2@example.com', 10.00, '2020-01-01', 'Active'),
(6663, 'Inactive User 3', 'inactive3@example.com', 100.00, '2020-01-01', 'Active')
ON CONFLICT DO NOTHING;

-- 1. Show users before update
SELECT user_id, full_name, account_status FROM USERS
WHERE account_status = 'Active'
  AND user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_date >= CURRENT_DATE - INTERVAL '1 year'
);

-- 2. Perform update
UPDATE USERS
SET account_status = 'Suspended'
WHERE account_status = 'Active'
  AND user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_date >= CURRENT_DATE - INTERVAL '1 year'
);

-- 3. Show users after update
SELECT user_id, full_name, account_status FROM USERS
WHERE user_id IN (
    -- Re-select same IDs for verification
    SELECT user_id FROM USERS WHERE account_status = 'Suspended'
);

