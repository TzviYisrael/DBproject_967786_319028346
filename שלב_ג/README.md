# Stage C - Integration and Views

## Project

BetMaster - Football Betting Management System

## Current Status

This folder contains the initial Stage C work that can be prepared before receiving the other group's backup.

Prepared files:

- `InspectReceivedSchema.sql` - read-only queries for extracting the received project's tables, columns, keys, constraints and relationships.
- `Integrate.sql` - integration script skeleton with safe initial integration metadata and TODO sections for the received schema.
- `Views.sql` - complete BetMaster-side view and placeholders for the received-project and integrated views.
- `received/` - place the other group's backup here.
- `Diagrams/` - place Stage C diagrams here.
- `screenshots/` - place query outputs and report evidence here.

## Where To Put The Other Group Backup

Put the received backup here:

```text
שלב_ג/received/backup_other_group.sql
```

If the file has another format, keep the original extension, for example:

```text
שלב_ג/received/backup_other_group.backup
שלב_ג/received/backup_other_group.dump
שלב_ג/received/backup_other_group.tar
```

## Reverse Engineering Algorithm

The received ERD must be rebuilt from the restored database using the following process:

1. Restore the received backup into a separate database.
2. List all tables and row counts.
3. For each table, list columns, data types, nullability and default values.
4. Identify primary keys. Each table with its own primary key is a candidate strong entity.
5. Identify foreign keys. Each FK from table A to table B becomes a relationship from A to B.
6. Determine cardinality:
   - FK without UNIQUE usually means many-to-one from child to parent.
   - FK with UNIQUE usually means one-to-one.
   - A table whose primary key is composed mainly of foreign keys is usually a bridge table for an M:N relationship.
7. Identify weak entities:
   - Tables whose identity depends on another table through a mandatory FK.
   - Tables with composite keys containing a parent key.
8. Identify inheritance only if several tables share the same PK or if one table has a type/status column that separates subtypes.
9. Convert tables and relationships into an ERD.
10. Document assumptions where the database constraints are not enough to prove the business meaning.

## Existing BetMaster Schema Summary

Current BetMaster tables:

- `users`
- `teams`
- `matches`
- `odds`
- `bets`
- `transactions`

Main relationships:

- `users` 1:N `bets`
- `users` 1:N `transactions`
- `teams` 1:N `matches` through `home_team_id`
- `teams` 1:N `matches` through `away_team_id`
- `matches` 1:N `bets`
- `matches` 1:1 `odds`

## Integration Decisions To Fill After Receiving Backup

TODO:

- Name and subject of the received project.
- Tables in the received database.
- Which received entities are equivalent to BetMaster entities.
- Which entities stay separate.
- Which bridge tables are needed.
- Which attributes should be added to existing BetMaster tables.
- How conflicting primary keys will be handled.
- How duplicate real-world objects will be detected.
- Which data will be migrated with `INSERT INTO ... SELECT`.
- Which FKs and constraints will be added after migration.

## Required Final Files For Submission

The final `שלב_ג` folder should contain:

- New department DSD image.
- New department ERD image.
- Integrated ERD image.
- DSD after integration image.
- `Integrate.sql`.
- `Views.sql`.
- `backup3.sql`.
- Stage C report.

Suggested diagram file names:

- `Diagrams/received_DSD.png`
- `Diagrams/received_ERD.png`
- `Diagrams/integrated_ERD.png`
- `Diagrams/integrated_DSD.png`

## Views Plan

`Views.sql` currently contains:

1. `vw_betmaster_user_activity` - BetMaster user activity summary.

Still needed after receiving the other project:

2. `vw_received_project_summary` - one useful view from the received project's point of view.
3. `vw_integrated_activity` - one useful view joining BetMaster and received-project data.

Each view must include:

- `SELECT * FROM <view_name> LIMIT 10`
- Two meaningful queries on the view.
- A short explanation and output screenshot in the report.

## Backup3 Plan

After integration is executed and validated:

```bash
pg_dump -U betmaster_user -h localhost -d betmaster > שלב_ג/backup3.sql
```

If running inside Docker:

```bash
docker exec betmaster_db pg_dump -U betmaster_user betmaster > שלב_ג/backup3.sql
```

## External Inputs Still Required

The work cannot be completed without the other group's backup and basic project context. See the main assistant response for the exact list to request.
