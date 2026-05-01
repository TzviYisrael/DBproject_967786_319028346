import csv
import random
from datetime import date, timedelta
from pathlib import Path

from faker import Faker


# ============================================================
# SETTINGS
# ============================================================

random.seed(42)

fake = Faker("en_US")
Faker.seed(42)

# This script is expected to be inside:
# שלב_א/Programming/generate_data.py
#
# The CSV files will be created inside:
# שלב_א/DataImportFiles
BASE_DIR = Path(__file__).resolve().parent.parent / "DataImportFiles"
BASE_DIR.mkdir(parents=True, exist_ok=True)

# More than 500 records in the main tables.
NUM_USERS = 800
NUM_TEAMS = 600
NUM_MATCHES = 1200
NUM_BETS = 20000
NUM_TRANSACTIONS = 20000


# ============================================================
# HELPER FUNCTIONS
# ============================================================

def random_date(start_date, end_date):
    """Return a random date between start_date and end_date."""
    days_range = (end_date - start_date).days
    return start_date + timedelta(days=random.randint(0, days_range))


def write_csv(file_name, headers, rows):
    """Write rows into a CSV file."""
    file_path = BASE_DIR / file_name

    with open(file_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow(headers)
        writer.writerows(rows)


def make_unique_team_name(used_names):
    """Create a realistic unique football team name."""
    suffixes = [
        "FC", "United", "City", "Athletic", "Rovers", "Wanderers",
        "Sporting", "Dynamo", "Maccabi", "Hapoel", "Lions", "Eagles"
    ]

    while True:
        city = fake.city().replace(",", "")
        suffix = random.choice(suffixes)
        team_name = f"{city} {suffix}"

        if team_name not in used_names:
            used_names.add(team_name)
            return team_name


# ============================================================
# VALID ID LISTS
# ============================================================
# These lists are the key to respecting the foreign keys.
#
# A foreign key must always point to an existing primary key.
#
# Example:
# BETS.user_id references USERS.user_id.
# Therefore, every bet must use a user_id from user_ids.
#
# BETS.match_id references MATCHES.match_id.
# Therefore, every bet must use a match_id from match_ids.
#
# MATCHES.home_team_id and MATCHES.away_team_id reference TEAMS.team_id.
# Therefore, every match must use team IDs from team_ids.
#
# ODDS.match_id references MATCHES.match_id and is UNIQUE.
# Therefore, we create exactly one odds row for each match.
#
# TRANSACTIONS.user_id references USERS.user_id.
# Therefore, every transaction must use a user_id from user_ids.

user_ids = list(range(1, NUM_USERS + 1))
team_ids = list(range(1, NUM_TEAMS + 1))
match_ids = list(range(1, NUM_MATCHES + 1))


# ============================================================
# USERS
# Parent table.
# Other tables can safely reference user_ids from this table.
# ============================================================

users = []
user_registration_dates = {}

account_statuses = ["Active", "Inactive", "Blocked"]

for user_id in user_ids:
    full_name = fake.name()
    email = fake.unique.email()
    balance = round(random.uniform(50, 10000), 2)
    registration_date = random_date(date(2024, 1, 1), date(2026, 3, 31))
    account_status = random.choice(account_statuses)

    user_registration_dates[user_id] = registration_date

    users.append([
        user_id,
        full_name,
        email,
        balance,
        registration_date,
        account_status
    ])

write_csv(
    "users.csv",
    ["user_id", "full_name", "email", "balance", "registration_date", "account_status"],
    users
)


# ============================================================
# TEAMS
# Parent table.
# MATCHES will reference team_id from this table.
# ============================================================

teams = []
used_team_names = set()

football_countries = [
    "Israel",
    "Brazil",
    "Argentina",
    "Spain",
    "England",
    "France",
    "Germany",
    "Italy",
    "Portugal",
    "Netherlands",
    "Uruguay",
    "Belgium",
    "Croatia",
    "Mexico",
    "United States",
    "Japan",
    "South Korea",
    "Morocco",
    "Switzerland",
    "Denmark"
]

for team_id in team_ids:
    team_name = make_unique_team_name(used_team_names)
    country = random.choice(football_countries)

    teams.append([
        team_id,
        team_name,
        country
    ])

write_csv(
    "teams.csv",
    ["team_id", "team_name", "country"],
    teams
)

# ============================================================
# MATCHES
# Child table of TEAMS.
#
# FK rules:
# home_team_id references TEAMS.team_id
# away_team_id references TEAMS.team_id
#
# We choose both IDs only from team_ids.
# We also make sure a team does not play against itself.
# ============================================================

matches = []
match_dates = {}
match_statuses = {}
match_results = {}

match_status_options = ["Scheduled", "Finished", "Cancelled"]
result_options = ["Home", "Draw", "Away"]

for match_id in match_ids:
    home_team_id = random.choice(team_ids)
    away_team_id = random.choice(team_ids)

    while away_team_id == home_team_id:
        away_team_id = random.choice(team_ids)

    match_date = random_date(date(2026, 5, 1), date(2026, 12, 31))
    status = random.choice(match_status_options)

    if status == "Finished":
        final_result = random.choice(result_options)
    else:
        final_result = ""

    match_dates[match_id] = match_date
    match_statuses[match_id] = status
    match_results[match_id] = final_result

    matches.append([
        match_id,
        match_date,
        status,
        final_result,
        home_team_id,
        away_team_id
    ])

write_csv(
    "matches.csv",
    ["match_id", "match_date", "status", "final_result", "home_team_id", "away_team_id"],
    matches
)


# ============================================================
# ODDS
# Child table of MATCHES.
#
# FK rule:
# ODDS.match_id references MATCHES.match_id.
#
# UNIQUE rule:
# ODDS.match_id is UNIQUE in the SQL file.
#
# Therefore, we create exactly one odds row for each match_id.
# ============================================================

odds = []

for odd_id, match_id in enumerate(match_ids, start=1):
    match_date = match_dates[match_id]

    update_date = random_date(
        match_date - timedelta(days=30),
        match_date - timedelta(days=1)
    )

    home_win_odd = round(random.uniform(1.20, 4.50), 2)
    draw_odd = round(random.uniform(2.00, 5.50), 2)
    away_win_odd = round(random.uniform(1.20, 4.50), 2)

    odds.append([
        odd_id,
        home_win_odd,
        draw_odd,
        away_win_odd,
        update_date,
        match_id
    ])

write_csv(
    "odds.csv",
    ["odd_id", "home_win_odd", "draw_odd", "away_win_odd", "update_date", "match_id"],
    odds
)


# ============================================================
# BETS
# Child table of USERS and MATCHES.
#
# FK rules:
# BETS.user_id references USERS.user_id.
# BETS.match_id references MATCHES.match_id.
#
# We choose user_id only from user_ids.
# We choose match_id only from match_ids.
# Therefore, every bet points to an existing user and match.
# ============================================================

bets = []

for bet_id in range(1, NUM_BETS + 1):
    user_id = random.choice(user_ids)
    match_id = random.choice(match_ids)

    predicted_result = random.choice(result_options)
    bet_amount = round(random.uniform(10, 1000), 2)

    user_registration_date = user_registration_dates[user_id]
    match_date = match_dates[match_id]

    bet_date = random_date(
        user_registration_date,
        match_date - timedelta(days=1)
    )

    if match_statuses[match_id] == "Finished":
        if predicted_result == match_results[match_id]:
            bet_status = "Won"
        else:
            bet_status = "Lost"
    elif match_statuses[match_id] == "Cancelled":
        bet_status = "Cancelled"
    else:
        bet_status = "Pending"

    bets.append([
        bet_id,
        predicted_result,
        bet_amount,
        bet_date,
        bet_status,
        user_id,
        match_id
    ])

write_csv(
    "bets.csv",
    ["bet_id", "predicted_result", "bet_amount", "bet_date", "bet_status", "user_id", "match_id"],
    bets
)


# ============================================================
# TRANSACTIONS
# Child table of USERS.
#
# FK rule:
# TRANSACTIONS.user_id references USERS.user_id.
#
# We choose user_id only from user_ids.
# Therefore, every transaction belongs to an existing user.
#
# transaction_type must match the CHECK constraint in createTables.sql:
# Deposit, Withdrawal, Bet Placement, Winnings
# ============================================================

transactions = []

transaction_types = ["Deposit", "Withdrawal", "Bet Placement", "Winnings"]

for transaction_id in range(1, NUM_TRANSACTIONS + 1):
    user_id = random.choice(user_ids)
    transaction_type = random.choice(transaction_types)
    amount = round(random.uniform(10, 5000), 2)

    user_registration_date = user_registration_dates[user_id]
    transaction_date = random_date(user_registration_date, date(2026, 12, 31))

    transactions.append([
        transaction_id,
        amount,
        transaction_type,
        transaction_date,
        user_id
    ])

write_csv(
    "transactions.csv",
    ["transaction_id", "amount", "transaction_type", "transaction_date", "user_id"],
    transactions
)


# ============================================================
# BASIC VALIDATION
# These checks prove that the generated data respects the FK logic.
# ============================================================

for row in matches:
    home_team_id = row[4]
    away_team_id = row[5]

    assert home_team_id in team_ids
    assert away_team_id in team_ids
    assert home_team_id != away_team_id

for row in odds:
    match_id = row[5]
    assert match_id in match_ids

assert len({row[5] for row in odds}) == len(odds)

for row in bets:
    user_id = row[5]
    match_id = row[6]

    assert user_id in user_ids
    assert match_id in match_ids

for row in transactions:
    user_id = row[4]
    assert user_id in user_ids


print("CSV files generated successfully!")
print(f"Output folder: {BASE_DIR}")
print(f"Users: {len(users)}")
print(f"Teams: {len(teams)}")
print(f"Matches: {len(matches)}")
print(f"Odds: {len(odds)}")
print(f"Bets: {len(bets)}")
print(f"Transactions: {len(transactions)}")