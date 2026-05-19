-- Update Query 3: Mass Settle Past Matches
-- Description: Updates matches that are in the past but still marked as 'Scheduled' to 'Finished'.

-- SETUP FOR DEMO (Run this first to ensure there is data to update)
INSERT INTO MATCHES (match_id, home_team_id, away_team_id, match_date, status) VALUES
(5551, 1, 2, CURRENT_DATE - INTERVAL '1 day', 'Scheduled'),
(5552, 3, 4, CURRENT_DATE - INTERVAL '2 days', 'Scheduled'),
(5553, 5, 6, CURRENT_DATE - INTERVAL '3 days', 'Scheduled')
ON CONFLICT DO NOTHING;

-- 1. Show records before update
SELECT match_id, match_date, status FROM MATCHES
WHERE match_date < CURRENT_DATE 
  AND status = 'Scheduled';

-- 2. Perform update
UPDATE MATCHES
SET status = 'Finished'
WHERE match_date < CURRENT_DATE 
  AND status = 'Scheduled';

-- 3. Show records after update
SELECT match_id, match_date, status FROM MATCHES
WHERE match_id IN (
    -- Check specific matches that were updated
    SELECT match_id FROM MATCHES WHERE status = 'Finished' AND match_date < CURRENT_DATE
)
LIMIT 10;

