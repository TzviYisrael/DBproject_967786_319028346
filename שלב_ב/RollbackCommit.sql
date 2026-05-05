-- ==============================================================================
-- Stage B: Rollback & Commit
-- ==============================================================================

-- Scenario 1: Rollback
-- 1. Show state
SELECT * FROM USERS WHERE user_id = 1;

BEGIN;
-- 2. Perform update
UPDATE USERS SET balance = balance + 1000 WHERE user_id = 1;
-- 3. Show updated state
SELECT * FROM USERS WHERE user_id = 1;
-- 4. Rollback
ROLLBACK;
-- 5. Show state is back to original
SELECT * FROM USERS WHERE user_id = 1;


-- Scenario 2: Commit
-- 1. Show state
SELECT * FROM USERS WHERE user_id = 2;

BEGIN;
-- 2. Perform update
UPDATE USERS SET balance = balance + 500 WHERE user_id = 2;
-- 3. Show updated state
SELECT * FROM USERS WHERE user_id = 2;
-- 4. Commit
COMMIT;
-- 5. Show state is persisted
SELECT * FROM USERS WHERE user_id = 2;
