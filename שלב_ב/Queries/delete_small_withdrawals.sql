-- Delete Query 3: Remove Micro-Withdrawal Noise
-- Description: Deletes withdrawal transactions of negligible amounts to clean up financial logs.
-- Non-trivial: Filters by type and amount while preserving large audit trails.

DELETE FROM TRANSACTIONS
WHERE transaction_type = 'Withdrawal'
  AND amount < 1.00;
