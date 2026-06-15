# Stage D - PL/pgSQL Programming

This folder contains the Stage D submission for the integrated BetMaster
database. The implementation adds non-trivial PL/pgSQL functions, procedures,
UPDATE triggers, main programs, execution evidence, screenshots and the final
database backup.

## Folder Structure

| Path | Purpose |
| --- | --- |
| `programs/` | All functions, procedures, triggers and main programs |
| `screenshots/` | Screenshot proof for each required program |
| `evidence/stage4_execution_output.txt` | Full psql execution output |
| `AlterTable.sql` | Supporting schema changes required by Stage D |
| `backup4.sql` | Final database backup after Stage D |
| `RunAllStage4.sql` | Main script that loads and runs all Stage D programs |
| `דוח הפרויקט שלב ד.md` | Stage D project report, including full code appendix |

## Program Files

| Requirement | File |
| --- | --- |
| Supporting schema changes | `AlterTable.sql` |
| Function 1, returns ref cursor | `programs/function_open_user_risk_report.sql` |
| Function 2, table result | `programs/function_match_financial_summary.sql` |
| Procedure 1 | `programs/procedure_settle_match.sql` |
| Procedure 2 | `programs/procedure_recalculate_user_statuses.sql` |
| UPDATE trigger 1 | `programs/trigger_user_account_audit.sql` |
| UPDATE trigger 2 | `programs/trigger_odds_update_audit.sql` |
| Main program 1 | `programs/MainProgram_RiskReview.sql` |
| Main program 2 | `programs/MainProgram_SettleMatch.sql` |

## Screenshot Evidence

| Proof | Screenshot |
| --- | --- |
| Function 1 - risk report ref cursor | `screenshots/function_risk_refcursor.png` |
| Function 2 - match financial summary | `screenshots/function_match_financial_summary.png` |
| Procedure 1 - match settlement | `screenshots/procedure_settle_match.png` |
| Procedure 2 and users UPDATE trigger | `screenshots/procedure_recalculate_user_statuses_and_user_trigger.png` |
| Odds UPDATE trigger | `screenshots/trigger_odds_update_audit.png` |
| Exception handling | `screenshots/exception_invalid_settlement_result.png` |

### Function 1 - Risk Ref Cursor

![Function risk ref cursor](screenshots/function_risk_refcursor.png)

`fn_open_user_risk_report(35)` opens and returns `risk_report_cursor`. The
following `FETCH ALL IN "risk_report_cursor"` prints users with calculated risk
scores, reasons, status and opening time. This proves the function uses
PL/pgSQL logic, writes risk-review rows, and returns the result through a
ref cursor.

### Function 2 - Match Financial Summary

![Function match financial summary](screenshots/function_match_financial_summary.png)

`fn_match_financial_summary(NULL)` summarizes multiple matches. It scans match,
team, bet and odds data and returns total bets, pending bets, total stake and
potential liability for each match.

### Procedure 1 - Settle Match

![Procedure settle match](screenshots/procedure_settle_match.png)

`proc_settle_match` changes real database state. Before the `CALL`, the selected
match is `Scheduled` with pending bets. After the procedure runs, the match is
`Finished`, pending bets become zero, winning and losing bets are counted,
winnings are paid, and `match_settlement_log` receives a settlement row.

### Procedure 2 And Trigger 1 - User Status Review

![Procedure recalculate user statuses and users trigger](screenshots/procedure_recalculate_user_statuses_and_user_trigger.png)

`proc_recalculate_user_statuses` reviews account risk and updates user status
when needed. The same screenshot also proves the `users_account_audit_update`
trigger, because `account_audit_log` contains old values, new values, reason and
timestamp for user balance/status updates.

### Trigger 2 - Odds Update Audit

![Trigger odds update audit](screenshots/trigger_odds_update_audit.png)

The `odds_audit_update` trigger runs automatically on `UPDATE odds`. It records
the old and new odds values, related match, reason and timestamp in
`odds_audit_log`.

### Exception Handling

![Exception invalid settlement result](screenshots/exception_invalid_settlement_result.png)

The exception screenshot calls `proc_settle_match` with `InvalidResult`. The
procedure rejects the invalid result, raises an error, and the outer PL/pgSQL
block catches it and prints a controlled `NOTICE`.

## Execution

Run the full Stage D script from the project root:

```bash
docker exec -w /project betmaster_db psql -U betmaster_user -d betmaster -f /project/שלב_ד/RunAllStage4.sql
```

Create the final backup:

```bash
docker exec betmaster_db pg_dump -U betmaster_user betmaster > שלב_ד/backup4.sql
```
