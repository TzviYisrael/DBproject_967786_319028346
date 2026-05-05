# BetMaster – Football Betting Management System

BetMaster is a comprehensive database system designed to manage football betting operations. It tracks users, football teams, matches, betting odds, placed bets, and financial transactions.

## System Overview
The system provides a platform for:
- Viewing scheduled football matches.
- Analyzing betting odds.
- Placing bets on match outcomes.
- Managing user balances and financial transactions (deposits/withdrawals).
- Tracking historical performance and winning streaks.

## Google AI Studio Application Link
**Application Link:** [BetMaster App](https://aistudio.google.com/apps/6016d178-4c68-4631-b42c-c4ed68553f7f)

## Screens

### Screen 1 – User Account
This screen presents the user’s personal account details, including the user name, user ID, account status, and current balance. It also allows financial actions such as deposits and withdrawals.
**Relevant entities:** `USERS`, `TRANSACTIONS`
![Screen 1](שלב_א/Screens/screen1.png)

### Screen 2 – Matches
This screen presents the list of football matches available for betting, including participating teams, match date, status, and odds.
**Relevant entities:** `MATCHES`, `TEAMS`, `ODDS`
![Screen 2](שלב_א/Screens/screen2.png)

### Screen 3 – Place Bet
This screen allows the user to choose a specific match, select a predicted result, enter a betting amount, and confirm the bet.
**Relevant entities:** `BETS`, `USERS`, `MATCHES`, `ODDS`, `TRANSACTIONS`
![Screen 3](שלב_א/Screens/screen3.png)

### Screen 4 – History
This screen presents the user’s betting history and financial transaction history, including profits, losses, and account actions.
**Relevant entities:** `BETS`, `TRANSACTIONS`, `MATCHES`
![Screen 4](שלב_א/Screens/screen4.png)

## Technologies
- **Database:** PostgreSQL 16
- **Containerization:** Docker & Docker Compose
- **Data Generation:** Python 3 (Faker/Random)
- **Tools:** VS Code, pg_dump

## Database Design (3NF)
The schema is normalized to 3NF to ensure data integrity and minimize redundancy.

### Core Entities:
- **USERS**: Profiles, balances, and account status.
- **TEAMS**: Team details and country of origin.
- **MATCHES**: Dates, participating teams, and final results.
- **ODDS**: Dynamic betting odds linked to specific matches.
- **BETS**: Records of user wagers, predictions, and outcomes.
- **TRANSACTIONS**: Financial logs for all account movements.

### Diagrams
- **ERD (Entity Relationship Diagram):** [View ERD](שלב_א/Diagrams/ERD.png)
- **DSD (Data Structure Diagram):** [View DSD](שלב_א/Diagrams/DSD.png)

## Getting Started

### Prerequisites
- Docker and Docker Compose.

### Running the Environment
1. Start the database:
   ```bash
   docker compose up -d
   ```
2. The database is available at `localhost:5432`.
   - **User:** `betmaster_user`
   - **Password:** `betmaster_pass`
   - **DB:** `betmaster`

### Project Structure
- `שלב_א/`: Stage A - Schema design, manual inserts, and initial diagrams.
- `שלב ב/`: Stage B - Advanced queries, indexes, and constraints.
- `docker-compose.yml`: Infrastructure configuration.

## Data Population
The database is populated with over 20,000 records across key tables to simulate a real-world high-traffic environment. Data was generated using a custom Python script and imported via CSV files.

### Final Record Counts:
| Table | Number of Records |
|---|---:|
| `USERS` | 800 |
| `TEAMS` | 600 |
| `MATCHES` | 1,200 |
| `ODDS` | 1,200 |
| `BETS` | 20,000 |
| `TRANSACTIONS` | 20,000 |

## Backup and Restore

### Logical SQL Backup
A logical SQL backup of the database was created using `pg_dump`.
- **File:** [backup_2026-05-01.sql](שלב_א/backup_2026-05-01.sql)
Contains the database structure and data in SQL format.

### Physical Docker Volume Backup
A second backup was created by backing up the PostgreSQL Docker volume itself.
- **File:** [backup_volume_2026-05-01.tar.gz](שלב_א/backup_volume_2026-05-01.tar.gz)
Preserves the physical contents of the PostgreSQL database storage volume.

### Restore Verification
The logical backup was successfully tested by restoring into a separate database (`betmaster_restore`), verifying that all 43,800+ records were preserved.
![Restore Verification](שלב_א/Screenshots/restore_counts.png)

