-- ==============================================================================
-- Stage B: Rollback & Commit (Multi-Row Operations)
-- ==============================================================================

-- Scenario 1: Multi-Row Rollback
-- Goal: Give a 10% bonus to all 'Inactive' users, then decide to cancel it.

-- 1. Show state of 'Inactive' users before (Checking first 20)
SELECT user_id, full_name, balance, account_status 
FROM USERS 
WHERE account_status = 'Inactive' 
ORDER BY user_id;

BEGIN;

-- 2. Perform bulk update (Affects ~285 rows)
UPDATE USERS 
SET balance = balance * 1.10 
WHERE account_status = 'Inactive';

-- 3. Show updated state (See the increased balances)
SELECT user_id, full_name, balance, account_status 
FROM USERS 
WHERE account_status = 'Inactive' 
ORDER BY user_id;

-- 4. Rollback - Undo the bonus for ALL users
ROLLBACK;

-- 5. Verify state is back to original
SELECT user_id, full_name, balance, account_status 
FROM USERS 
WHERE account_status = 'Inactive' 
ORDER BY user_id;


-- Scenario 2: Multi-Row Commit
-- Goal: Block a specific range of users (IDs 100 to 120) for maintenance, and save the change.

-- 1. Show state before
SELECT user_id, full_name, account_status 
FROM USERS 
WHERE user_id BETWEEN 100 AND 120 
ORDER BY user_id;

BEGIN;

-- 2. Perform bulk update (Affects 21 rows)
UPDATE USERS 
SET account_status = 'Blocked' 
WHERE user_id BETWEEN 100 AND 120;

-- 3. Show updated state
SELECT user_id, full_name, account_status 
FROM USERS 
WHERE user_id BETWEEN 100 AND 120 
ORDER BY user_id;

-- 4. Commit - Persist the changes
COMMIT;

-- 5. Verify changes are permanent
SELECT user_id, full_name, account_status 
FROM USERS 
WHERE user_id BETWEEN 100 AND 120 
ORDER BY user_id;
