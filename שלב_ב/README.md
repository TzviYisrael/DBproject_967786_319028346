# Stage B - Queries, Constraints, and Indexes

**BetMaster Project** - Football Betting Management System.

## Queries (Queries.sql)

### SELECT Queries (4 pairs of comparable forms)

1. **Top Winning Users in 2026**
   - **Description:** Finds the top 5 users with the highest total winnings in the year 2026.
   - **Form A (JOIN):** Direct join between USERS and TRANSACTIONS.
   - **Form B (Subquery):** Calculates totals in a subquery before joining with user details.
   - **Efficiency:** Form B can be more efficient if the subquery significantly reduces the data set size before the join operation.

2. **Away Team Victories**
   - **Description:** Lists matches where the away team won, including team names and odds.
   - **Form A (JOIN):** Standard joins to the TEAMS and ODDS tables.
   - **Form B (Scalar Subquery):** Uses subqueries in the SELECT clause to fetch team names.
   - **Efficiency:** Form A is significantly better as scalar subqueries often result in N+1 execution patterns, while JOINs are optimized by the PostgreSQL engine.

3. **Users Betting on Specific Countries**
   - **Description:** Identifies users who placed bets on matches involving teams from a specific country ('Country 1').
   - **Form A (JOIN):** A continuous join path: Users -> Bets -> Matches -> Teams.
   - **Form B (IN):** Uses nested `WHERE ... IN` clauses.
   - **Efficiency:** JOINs are generally better for large datasets as they allow the optimizer more flexibility compared to nested IN clauses.

4. **Monthly Deposit vs Withdrawal Summary**
   - **Description:** Summarizes total deposits and withdrawals per month for the year 2026.
   - **Form A (CASE WHEN):** Uses conditional aggregation in a single scan of the TRANSACTIONS table.
   - **Form B (CTE):** Uses Common Table Expressions to calculate deposits and withdrawals separately, then joins them.
   - **Efficiency:** Form A is more efficient because it performs a "single pass" over the data, whereas Form B might involve multiple scans or temporary tables.

### Additional SELECT Queries
5. **Average Bet Amount by Account Status:** Analyzes behavior differences between Active and Suspended users.
6. **Matches with Odds Updated in April 2026:** Tracks market volatility for a specific period.
7. **Heavy Bettors (More than 5 bets/month):** Identifies highly active users.
8. **New User Activity (Registered in 2025):** Focuses on engagement of users from the previous year.

### UPDATE and DELETE Queries
- **Update:** Updates balances for winners, sets past matches to 'Finished', and suspends inactive accounts.
- **Delete:** Cleans up small transactions, removes pending bets for finished matches, and deletes old inactive user accounts.

## Constraints (Constraints.sql)
1. **chk_registration_date:** Prevents future registration dates.
2. **chk_different_teams:** Ensures a match cannot be played between the same team (Home vs Home).
3. **chk_positive_transaction:** Validates that deposits and winnings must have a positive amount.

## Indexes (Index.sql)
1. **idx_transaction_date:** Speeds up historical reports and monthly summaries.
2. **idx_match_status_date:** Optimizes queries for active/scheduled matches.
3. **idx_user_email:** Improves performance for user lookups and login operations.

## Transactions (RollbackCommit.sql)
- **Rollback Demo:** Shows a balance update being reverted to the original state.
- **Commit Demo:** Shows a balance update being permanently saved to the database.
