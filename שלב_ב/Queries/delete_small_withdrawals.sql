-- Delete Query 3: Remove Micro-Withdrawal Noise
-- Description: Deletes withdrawal transactions of negligible amounts to clean up financial logs.

-- SETUP FOR DEMO (Run this first to ensure there is data to delete)
-- Using existing user_id 1
-- INSERT INTO TRANSACTIONS (transaction_id, user_id, transaction_type, amount, transaction_date) VALUES
-- (20001, 1, 'Withdrawal', 0.50, CURRENT_DATE),
-- (20002, 1, 'Withdrawal', 0.25, CURRENT_DATE),
-- (20003, 1, 'Withdrawal', 0.99, CURRENT_DATE)
-- ON CONFLICT DO NOTHING;

-- 1. Show records to be deleted
SELECT * FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 100.00;

-- 2. Perform deletion
DELETE FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 100.00;

-- 3. Verify deletion
SELECT * FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 100.00;

