-- Update Query 3: Mass Settle Past Matches
-- Description: Updates matches that are in the past but still marked as 'Scheduled' to 'Finished'.
-- Non-trivial: Ensures data integrity based on temporal discrepancies.

UPDATE MATCHES
SET status = 'Finished'
WHERE match_date < CURRENT_DATE 
  AND status = 'Scheduled';
