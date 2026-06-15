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
| Final backup | `backup4.sql` |
| Report | `דוח הפרויקט שלב ד.md` |

## Execution Order

```bash
docker exec -i betmaster_db psql -U betmaster_user -d betmaster < שלב_ד/RunAllStage4.sql
docker exec betmaster_db pg_dump -U betmaster_user betmaster > שלב_ד/backup4.sql
```
