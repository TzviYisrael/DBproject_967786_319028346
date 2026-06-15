# Stage D - PL/pgSQL Programming

This folder contains the Stage D submission for the integrated BetMaster database.

## Files

| Requirement | File |
| --- | --- |
| Supporting schema changes | `AlterTable.sql` |
| Function 1, returns ref cursor | `function_open_user_risk_report.sql` |
| Function 2, table result | `function_match_financial_summary.sql` |
| Procedure 1 | `procedure_settle_match.sql` |
| Procedure 2 | `procedure_recalculate_user_statuses.sql` |
| UPDATE trigger 1 | `trigger_user_account_audit.sql` |
| UPDATE trigger 2 | `trigger_odds_update_audit.sql` |
| Main program 1 | `MainProgram_RiskReview.sql` |
| Main program 2 | `MainProgram_SettleMatch.sql` |
| Full execution script | `RunAllStage4.sql` |
| Execution proof | `evidence/stage4_execution_output.txt` |
| Screenshot proof - risk ref cursor function | `screenshots/function_risk_refcursor.png` |
| Screenshot proof - match financial summary function | `screenshots/function_match_financial_summary.png` |
| Screenshot proof - settle match procedure | `screenshots/procedure_settle_match.png` |
| Screenshot proof - user status procedure and users UPDATE trigger | `screenshots/procedure_recalculate_user_statuses_and_user_trigger.png` |
| Screenshot proof - odds UPDATE trigger | `screenshots/trigger_odds_update_audit.png` |
| Screenshot proof - exception handling | `screenshots/exception_invalid_settlement_result.png` |
| Final backup | `backup4.sql` |
| Report | `דוח הפרויקט שלב ד.md` |

## Screenshot Evidence

### Function 1 - Risk Ref Cursor

![Function risk ref cursor](screenshots/function_risk_refcursor.png)

This screenshot proves that `fn_open_user_risk_report(35)` opened and returned
the `risk_report_cursor`. The following `FETCH ALL IN "risk_report_cursor"`
prints the generated risk-review rows. Each row contains a user, calculated
risk score, explanation, status and opening time, proving that the function
performed both PL/pgSQL processing and database updates before returning the
cursor.

### Function 2 - Match Financial Summary

![Function match financial summary](screenshots/function_match_financial_summary.png)

This screenshot proves that `fn_match_financial_summary(NULL)` can summarize
multiple matches. The function scans match and betting records, groups the
financial state per match, and returns totals such as number of bets, pending
bets, total stake and potential liability. The output is ordered by open betting
exposure, which makes it useful for operational risk monitoring.

### Procedure 1 - Settle Match

![Procedure settle match](screenshots/procedure_settle_match.png)

This screenshot proves that `proc_settle_match` changed database state. Before
the `CALL`, the selected match is still `Scheduled` with pending bets and a
positive potential liability. After the procedure runs, the match is `Finished`,
the final result is set to `Home`, pending bets become zero, winning and losing
bets are counted, winnings are paid, and a row is written to
`match_settlement_log`.

### Procedure 2 And Trigger 1 - User Status Review

![Procedure recalculate user statuses and users trigger](screenshots/procedure_recalculate_user_statuses_and_user_trigger.png)

This screenshot shows the risk-review main program after calling
`proc_recalculate_user_statuses`. The upper result set shows open risk-review
records, and the lower result set shows `account_audit_log` rows created by the
`users_account_audit_update` trigger. The audit rows prove that updates to
`users.balance` or `users.account_status` are automatically recorded with old
values, new values, reason and timestamp.

### Trigger 2 - Odds Update Audit

![Trigger odds update audit](screenshots/trigger_odds_update_audit.png)

This screenshot proves that the `odds_audit_update` trigger runs on `UPDATE`.
The command changes `home_win_odd`, and the audit table immediately records
the old and new odds values, the related match, the reason and the timestamp.
The repeated rows show a full history of odds changes instead of only the
current value in `odds`.

### Exception Handling

![Exception invalid settlement result](screenshots/exception_invalid_settlement_result.png)

This screenshot proves the exception path in `proc_settle_match`. The procedure
is called with `InvalidResult`, which is not a legal match result. The procedure
raises an error, and the outer PL/pgSQL block catches it and prints the captured
message. This demonstrates controlled exception handling instead of silent
failure.

## Execution Order

```bash
docker exec -i betmaster_db psql -U betmaster_user -d betmaster < שלב_ד/RunAllStage4.sql
docker exec betmaster_db pg_dump -U betmaster_user betmaster > שלב_ד/backup4.sql
```
