# BetMaster - Football Betting Management System

BetMaster is a comprehensive database system designed to manage football betting operations. It tracks users, football teams, matches, betting odds, placed bets, and financial transactions.

## System Overview

The system provides a platform for:

- Viewing scheduled football matches.
- Analyzing betting odds.
- Placing bets on match outcomes.
- Managing user balances and financial transactions.
- Tracking historical performance and winning streaks.

## Google AI Studio Application Link

**Application Link:** [BetMaster App](https://aistudio.google.com/apps/6016d178-4c68-4631-b42c-c4ed68553f7f)

## Screens

### Screen 1 - User Account

This screen presents the user's personal account details, including the user name, user ID, account status, and current balance. It also allows financial actions such as deposits and withdrawals.

**Relevant entities:** `USERS`, `TRANSACTIONS`

![Screen 1](שלב_א/Screens/screen1.png)

### Screen 2 - Matches

This screen presents the list of football matches available for betting, including participating teams, match date, status, and odds.

**Relevant entities:** `MATCHES`, `TEAMS`, `ODDS`

![Screen 2](שלב_א/Screens/screen2.png)

### Screen 3 - Place Bet

This screen allows the user to choose a specific match, select a predicted result, enter a betting amount, and confirm the bet.

**Relevant entities:** `BETS`, `USERS`, `MATCHES`, `ODDS`, `TRANSACTIONS`

![Screen 3](שלב_א/Screens/screen3.png)

### Screen 4 - History

This screen presents the user's betting history and financial transaction history, including profits, losses, and account actions.

**Relevant entities:** `BETS`, `TRANSACTIONS`, `MATCHES`

![Screen 4](שלב_א/Screens/screen4.png)

## Technologies

- **Database:** PostgreSQL 16
- **Containerization:** Docker & Docker Compose
- **Data Generation:** Python 3
- **Tools:** VS Code, pg_dump, Dear PyGui, psycopg2

## Database Design

The schema is normalized and was expanded through the integration stage. The final database includes the original BetMaster tables, the received football-management schema, integrated football tables, integration mapping tables, and Stage D audit/risk tables.

### Core Entities

- **USERS:** Profiles, balances, and account status.
- **TEAMS:** Team details and country of origin.
- **MATCHES:** Dates, participating teams, and final results.
- **ODDS:** Dynamic betting odds linked to specific matches.
- **BETS:** Records of user wagers, predictions, and outcomes.
- **TRANSACTIONS:** Financial logs for all account movements.

### Diagrams

- **ERD:** [View ERD](שלב_א/Diagrams/ERD.png)
- **DSD:** [View DSD](שלב_א/Diagrams/DSD.png)
- **Integrated ERD:** [View Integrated ERD](שלב_ג/Diagrams/integrated_ERD.png)
- **Integrated DSD:** [View Integrated DSD](שלב_ג/Diagrams/integrated_DSD.png)

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Python 3.10 or newer for the Stage E GUI

### Running The Database

Start PostgreSQL:

```powershell
docker compose up -d
```

The database is available at `localhost:5432`.

- **User:** `betmaster_user`
- **Password:** `betmaster_pass`
- **DB:** `betmaster`

On a fresh machine or empty Docker volume, restore the Stage D backup:

```powershell
docker exec -i betmaster_db psql -U betmaster_user -d betmaster < .\שלב_ד\backup4.sql
```

## Project Structure

- `שלב_א/`: Stage A - schema design, data generation, backup and initial screens.
- `שלב_ב/`: Stage B - advanced queries, indexes, constraints and transactions.
- `שלב_ג/`: Stage C - integration with the received football database.
- `שלב_ד/`: Stage D - PL/pgSQL functions, procedures, triggers and audit tables.
- `שלב_ה/`: Stage E - graphical interface for the database.
- `DBProject/שלב ה/`: delivery copy for Stage E.
- `docker-compose.yml`: PostgreSQL infrastructure.

## Stage E - Graphical Database Interface

Stage E adds a desktop administration interface for the integrated BetMaster database.

### How To Run

1. Start PostgreSQL:

   ```powershell
   docker compose up -d
   ```

2. If the Docker volume is empty, restore the Stage D database:

   ```powershell
   docker exec -i betmaster_db psql -U betmaster_user -d betmaster < .\שלב_ד\backup4.sql
   ```

3. Install the GUI dependencies:

   ```powershell
   cd .\שלב_ה
   python -m pip install -r requirements.txt
   ```

4. Run the application:

   ```powershell
   python main.py
   ```

The application connects to `localhost:5432`, database `betmaster`, with user `betmaster_user` and password `betmaster_pass`.

### Tools Used For The GUI

- **Python 3** for the application code.
- **Dear PyGui** for the graphical desktop interface.
- **psycopg2-binary** for PostgreSQL access.
- **Docker Compose** for running PostgreSQL 16.

### Application Coverage

The GUI provides access to all **40 public tables** in the integrated database:

- original BetMaster tables
- received football-management tables
- normalized integrated football tables
- integration mapping tables
- Stage D audit and risk tables

Supported operations:

- Create, read, update and delete records from the table screens.
- Update flow by primary key: enter key, fetch existing row, edit fields, save.
- Foreign-key display using readable values instead of raw IDs.
- Execution of Stage B queries.
- Execution of Stage D procedures/functions.

Stage B queries exposed in the GUI:

- `Top Recent Winners`
- `Suspicious Winning Patterns`
- `High-Value Regional Users`
- `Away Team Upsets`
- `Monthly Cash Flow`

Stage D programs exposed in the GUI:

- `proc_settle_match`
- `proc_recalculate_user_statuses`
- `fn_match_financial_summary`
- `fn_open_user_risk_report`

### Stage E Screenshots

![Stage E Home](שלב_ה/screenshots/home_page.png)

![Stage E Data Management](שלב_ה/screenshots/data_page.png)

![Stage E Queries and Programs](שלב_ה/screenshots/query_page.png)

