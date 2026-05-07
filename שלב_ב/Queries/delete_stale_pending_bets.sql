-- Delete Query 2: Purge Stale Pending Bets
-- Description: Removes 'Pending' bets associated with matches that have already finished.
-- Non-trivial: Joins BETS with MATCHES in a subquery to find inconsistent states.

DELETE FROM BETS
WHERE bet_status = 'Pending'
  AND match_id IN (
    SELECT match_id 
    FROM MATCHES 
    WHERE status = 'Finished' 
      OR match_date < CURRENT_DATE - INTERVAL '7 days'
  );
