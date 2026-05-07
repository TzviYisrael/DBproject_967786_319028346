-- Query 7: Monthly Cash Flow Analysis
-- Purpose: Summary of high-volume financial months for the platform.
-- Uses EXTRACT for temporal breakdown and CASE for side-by-side comparison.

SELECT 
    EXTRACT(YEAR FROM transaction_date) as year,
    EXTRACT(MONTH FROM transaction_date) as month,
    COUNT(transaction_id) as txn_count,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END) as total_deposits,
    SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END) as total_withdrawals,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE -amount END) as net_platform_flow
FROM TRANSACTIONS
GROUP BY EXTRACT(YEAR FROM transaction_date), EXTRACT(MONTH FROM transaction_date)
HAVING SUM(amount) > 5000
ORDER BY year DESC, month DESC;
