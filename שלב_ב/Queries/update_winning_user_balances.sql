-- Update Query 1: Loyalty Bonus for Winners
-- Description: Adds a balance bonus to active users who have won at least one bet.
-- Non-trivial: Uses a subquery to filter by behavior (winning).

UPDATE USERS
SET balance = balance + 25.00
WHERE account_status = 'Active'
  AND user_id IN (
    SELECT DISTINCT user_id 
    FROM BETS 
    WHERE bet_status = 'Won'
);
