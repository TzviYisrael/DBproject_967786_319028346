-- Delete Query 2: Purge Stale Pending Bets
-- Description: Removes 'Pending' bets associated with matches that have already finished.

-- SETUP FOR DEMO (Run this first to ensure there is data to delete)
-- Using match_id 1 (assume finished) and user_id 1
INSERT INTO BETS (bet_id, user_id, match_id, bet_amount, bet_date, bet_status, predicted_result) VALUES
(7771, 1, 1, 10.00, CURRENT_DATE - INTERVAL '10 days', 'Pending', 'Home'),
(7772, 2, 1, 20.00, CURRENT_DATE - INTERVAL '10 days', 'Pending', 'Away'),
(7773, 3, 1, 5.00, CURRENT_DATE - INTERVAL '10 days', 'Pending', 'Draw')
ON CONFLICT DO NOTHING;

-- 1. Show records to be deleted
SELECT * FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );

-- 2. Perform deletion
DELETE FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );

-- 3. Verify deletion
SELECT * FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );

