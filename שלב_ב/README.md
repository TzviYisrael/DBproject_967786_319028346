# Stage B - Queries, Constraints, and Indexes

**BetMaster Project** - Football Betting Management System.

## Queries (Queries/ folder)

Reorganized into modular files with advanced business logic, temporal filters, and performance metrics. **Artificial limits (LIMIT) have been removed** in favor of meaningful business filters (`HAVING`, `WHERE` based on duration/volume).

### SELECT Queries
1. **[top_recent_winners.sql](Queries/top_recent_winners.sql)**: Top earners who registered in the last 6 months (targeting successful new users).
2. **[winning_efficiency.sql](Queries/winning_efficiency.sql)**: **(New)** Winnings per day of membership (efficiency metric).
3. **[away_team_upsets.sql](Queries/away_team_upsets.sql)**: High-yield away wins (odds > 3.0).
4. **[high_value_regional_users.sql](Queries/high_value_regional_users.sql)**: New high-volume users specifically from matches involving 'Country 1'.
5. **[new_whale_users.sql](Queries/new_whale_users.sql)**: **(New)** Users with high average bets (> 200) registered in the last 90 days.
6. **[recent_odds_updates.sql](Queries/recent_odds_updates.sql)**: Tracks matches with odd changes in April 2026.
7. **[high_frequency_bettors.sql](Queries/high_frequency_bettors.sql)**: Users with a high "bets per day" ratio.
8. **[bets_by_new_users.sql](Queries/bets_by_new_users.sql)**: Engagement tracking for users who registered in 2025.
9. **[suspicious_winning_patterns.sql](Queries/suspicious_winning_patterns.sql)**: Detects potential cheaters (win rate > 75%) combined with high win frequency.
10. **[monthly_transaction_summary.sql](Queries/monthly_transaction_summary.sql)**: Significant monthly cash flows (> 1000 net).

### UPDATE and DELETE Queries
- **[update_winning_user_balances.sql](Queries/update_winning_user_balances.sql)**: Rewards active winning users.
- **[update_match_status.sql](Queries/update_match_status.sql)**: Maintains data integrity.
- **[suspend_inactive_users.sql](Queries/suspend_inactive_users.sql)**: Suspends inactive accounts.
- **[delete_small_withdrawals.sql](Queries/delete_small_withdrawals.sql)**: Removes micro-transaction noise.
- **[delete_stale_pending_bets.sql](Queries/delete_stale_pending_bets.sql)**: Cleans up invalid bets.
- **[delete_abandoned_users.sql](Queries/delete_abandoned_users.sql)**: Removes old inactive accounts.

## Constraints (Constraints.sql)
... (unchanged)
