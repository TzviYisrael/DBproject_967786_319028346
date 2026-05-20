-- =============================================================================
-- Stage C - Integration script
-- =============================================================================
-- Project: BetMaster - Football Betting Management System
--
-- Important:
-- This file must integrate the current BetMaster database with the received
-- project using existing tables and ALTER TABLE / CREATE TABLE only where needed.
-- Do not recreate all existing tables from zero.
--
-- Current status:
-- The received backup has not been provided yet, so the concrete integration
-- commands are intentionally left as TODO sections. After inspecting the received
-- schema, replace the TODO blocks with the actual ALTER TABLE, CREATE TABLE,
-- INSERT INTO ... SELECT, and FK commands.

BEGIN;

-- -----------------------------------------------------------------------------
-- 1. Preserve source-system information for integrated records.
-- -----------------------------------------------------------------------------
-- This table is safe and useful for documenting which original project each
-- table/record group came from after integration.
CREATE TABLE IF NOT EXISTS integration_sources (
    source_id INT PRIMARY KEY,
    source_name VARCHAR(100) NOT NULL UNIQUE,
    source_description VARCHAR(500),
    received_backup_file VARCHAR(255),
    integrated_at DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO integration_sources (
    source_id,
    source_name,
    source_description,
    received_backup_file
)
VALUES
    (1, 'BetMaster', 'Original project: football betting management system', NULL)
ON CONFLICT (source_id) DO NOTHING;

-- TODO after receiving the other backup:
-- INSERT INTO integration_sources (
--     source_id,
--     source_name,
--     source_description,
--     received_backup_file
-- )
-- VALUES
--     (2, '<RECEIVED_PROJECT_NAME>', '<RECEIVED_PROJECT_DESCRIPTION>', 'received/backup_other_group.sql')
-- ON CONFLICT (source_id) DO NOTHING;

-- -----------------------------------------------------------------------------
-- 2. BetMaster-side integration changes.
-- -----------------------------------------------------------------------------
-- TODO after deciding the integrated ERD:
-- Add only the columns that are required to connect BetMaster entities to the
-- received project.
--
-- Example pattern:
-- ALTER TABLE users
--     ADD COLUMN IF NOT EXISTS external_customer_id INT;
--
-- ALTER TABLE users
--     ADD CONSTRAINT fk_users_external_customer
--     FOREIGN KEY (external_customer_id)
--     REFERENCES <received_or_integrated_table>(<primary_key_column>);

-- -----------------------------------------------------------------------------
-- 3. Received-project tables or bridge tables.
-- -----------------------------------------------------------------------------
-- TODO after reverse engineering the received project:
-- If a received entity has no equivalent BetMaster table, keep it as a separate
-- table or create it as an integrated table. Use CREATE TABLE only for new
-- entities/bridge tables that do not exist in the current schema.
--
-- Example bridge pattern:
-- CREATE TABLE IF NOT EXISTS user_external_accounts (
--     user_id INT NOT NULL,
--     external_user_id INT NOT NULL,
--     source_id INT NOT NULL,
--     linked_at DATE NOT NULL DEFAULT CURRENT_DATE,
--     PRIMARY KEY (user_id, external_user_id, source_id),
--     FOREIGN KEY (user_id) REFERENCES users(user_id),
--     FOREIGN KEY (source_id) REFERENCES integration_sources(source_id)
-- );

-- -----------------------------------------------------------------------------
-- 4. Data migration from the received backup.
-- -----------------------------------------------------------------------------
-- TODO after restoring/importing received data:
-- Use INSERT INTO ... SELECT from staging/received tables into the integrated
-- tables. Avoid overwriting existing BetMaster data.
--
-- Example pattern:
-- INSERT INTO <target_table> (<columns>)
-- SELECT <columns>
-- FROM <received_schema_or_staging_table>
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM <target_table>
--     WHERE <target_table>.<natural_key> = <received_schema_or_staging_table>.<natural_key>
-- );

-- -----------------------------------------------------------------------------
-- 5. Validation queries.
-- -----------------------------------------------------------------------------
-- Keep these queries in the script so screenshots/output can be used in the
-- report after integration.
SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'teams', COUNT(*) FROM teams
UNION ALL
SELECT 'matches', COUNT(*) FROM matches
UNION ALL
SELECT 'odds', COUNT(*) FROM odds
UNION ALL
SELECT 'bets', COUNT(*) FROM bets
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'integration_sources', COUNT(*) FROM integration_sources
ORDER BY table_name;

COMMIT;
