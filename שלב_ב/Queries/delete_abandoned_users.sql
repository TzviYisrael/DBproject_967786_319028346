-- Delete Query 1: Cleanup Abandoned Accounts
-- Description: Deletes users who registered long ago but never interacted (no bets, no transactions).
-- Non-trivial: Uses multiple subqueries to ensure no active data is lost.

DELETE FROM USERS
WHERE registration_date < CURRENT_DATE - INTERVAL '2 years'
  AND user_id NOT IN (SELECT user_id FROM BETS)
  AND user_id NOT IN (SELECT user_id FROM TRANSACTIONS);
