# Stage B Report Requirements - Screenshot List

To complete the report for Stage B, you need to capture the following screenshots.

## 1. Dual-Version SELECT Queries (4 Queries)
For each of these, capture:
1. **Execution Code**: The SQL script in your editor.
2. **Execution Result**: The first 5 rows of the output.
3. **Efficiency Comparison**: (Optional but recommended) `EXPLAIN ANALYZE` output for both versions to justify which is better.

* v **Query 1: Top Recent Winners** (`top_recent_winners.sql`)
* v **Query 2: High-Value Regional Users** (`high_value_regional_users.sql`)
* v **Query 3: Suspicious Winning Patterns** (`suspicious_winning_patterns.sql`)
* v **Query 4: Away Team Upsets** (`away_team_upsets.sql`)

## 2. Additional SELECT Queries (4 Queries)
Capture the code and the first 5 rows of results.

* v **Query 5: High-Frequency Bettors** (`high_frequency_bettors.sql`)
* v **Query 6: New Whale Users** (`new_whale_users.sql`)
* v **Query 7: Monthly Cash Flow Analysis** (`monthly_transaction_summary.sql`)
* v **Query 8: Winning Efficiency Metric** (`winning_efficiency.sql`)

## 3. UPDATE and DELETE Operations
For each, capture:
1. **Before**: `SELECT` query showing the data before the change.
2. **Execution**: The `UPDATE` or `DELETE` command being run.
3. **After**: The same `SELECT` query showing the change.

* v **Update 1**: Reward winning users (`update_winning_user_balances.sql`)
* v **Update 2**: Maintain match status (`update_match_status.sql`)
* v **Delete 1**: Remove small withdrawals (`delete_small_withdrawals.sql`)
* ? **Delete 2**: Clean up stale bets (`delete_stale_pending_bets.sql`)

## 4. Constraints
Capture:
1. **Alter Table**: The `ALTER TABLE` command adding the constraint.
2. **Failure Proof**: An `INSERT` or `UPDATE` command that violates the constraint, showing the resulting error message.

* v **Constraint 1**: Registration date check (`chk_registration_date`)
* v **Constraint 2**: Different teams check (`chk_different_teams`)
* v **Constraint 3**: Positive transaction check (`chk_positive_transaction`)

## 5. Rollback & Commit
Capture the output of `RollbackCommit.sql` showing the database state at every step:
1. v **Rollback Scenario**: Initial state -> After Update -> After Rollback.
2.  nothing to show **Commit Scenario**: Initial state -> After Update -> After Commit.

## 6. Indexes
Capture `EXPLAIN ANALYZE` output for a query:
1. **Before Index**: Showing a "Seq Scan".
2. **After Index**: Showing an "Index Scan" and the time difference.

*   **Index 1**: `idx_transaction_date`
*   **Index 2**: `idx_match_status_date`
*   **Index 3**: `idx_bets_user_id`
