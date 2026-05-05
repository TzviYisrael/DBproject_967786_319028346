# BetMaster – Football Betting Management System

BetMaster is a comprehensive database system designed to manage football betting operations. It tracks users, football teams, matches, betting odds, placed bets, and financial transactions.

## System Overview
The system provides a platform for:
- Viewing scheduled football matches.
- Analyzing betting odds.
- Placing bets on match outcomes.
- Managing user balances and financial transactions (deposits/withdrawals).
- Tracking historical performance and winning streaks.

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
The database is populated with over 20,000 records across key tables (Bets and Transactions) to simulate a real-world high-traffic environment. Data was generated using a custom Python script and imported via CSV files.
