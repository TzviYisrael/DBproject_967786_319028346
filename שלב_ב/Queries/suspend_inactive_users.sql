-- Update Query 2: Suspend Inactive Bettors
-- Description: Suspends users who haven't placed a bet in the last year.
-- Non-trivial: Joins logic with time-based filtering and nested exclusion.

UPDATE USERS
SET account_status = 'Suspended'
WHERE account_status = 'Active'
  AND user_id NOT IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_date >= CURRENT_DATE - INTERVAL '1 year'
);
