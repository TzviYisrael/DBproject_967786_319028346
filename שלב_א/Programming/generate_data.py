import csv
import random
import re
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

# Project reference date used for realistic generated data.
PROJECT_DATE = date(2026, 5, 1)

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
    if start_date > end_date:
        raise ValueError(f"Invalid date range: {start_date} > {end_date}")

    days_range = (end_date - start_date).days
    return start_date + timedelta(days=random.randint(0, days_range))


def write_csv(file_name, headers, rows):
    """Write rows into a CSV file."""
    file_path = BASE_DIR / file_name

    with open(file_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow(headers)
        writer.writerows(rows)


def clean_for_email(text):
    """Convert text into a safe email part."""
    cleaned = text.lower()
    cleaned = re.sub(r"[^a-z]", "", cleaned)
    return cleaned or "user"


def make_email(first_name, last_name, user_id):
    """Create an email that matches the user's generated name."""
    domains = [
        "gmail.com",
        "outlook.com",
        "yahoo.com",
        "mail.com",
        "betmaster.com",
        "footballmail.com"
    ]

    first = clean_for_email(first_name)
    last = clean_for_email(last_name)
    domain = random.choice(domains)

    return f"{first}.{last}{user_id}@{domain}"


def make_unique_team_name(country, used_names):
    """Create a realistic unique football team name."""
    cities_by_country = {
        "Israel": ["Tel Aviv", "Jerusalem", "Haifa", "Beer Sheva", "Netanya", "Ashdod", "Rishon LeZion", "Petah Tikva"],
        "Brazil": ["Sao Paulo", "Rio de Janeiro", "Salvador", "Curitiba", "Porto Alegre", "Belo Horizonte", "Recife", "Fortaleza"],
        "Argentina": ["Buenos Aires", "Rosario", "Cordoba", "La Plata", "Mendoza", "Santa Fe", "Tucuman", "Mar del Plata"],
        "Spain": ["Madrid", "Barcelona", "Valencia", "Seville", "Bilbao", "Malaga", "Villarreal", "Zaragoza"],
        "England": ["London", "Manchester", "Liverpool", "Leeds", "Birmingham", "Newcastle", "Brighton", "Nottingham"],
        "France": ["Paris", "Lyon", "Marseille", "Lille", "Nice", "Nantes", "Toulouse", "Bordeaux"],
        "Germany": ["Berlin", "Munich", "Dortmund", "Hamburg", "Leipzig", "Cologne", "Frankfurt", "Stuttgart"],
        "Italy": ["Rome", "Milan", "Turin", "Naples", "Florence", "Genoa", "Bologna", "Verona"],
        "Portugal": ["Lisbon", "Porto", "Braga", "Coimbra", "Faro", "Guimaraes", "Aveiro", "Setubal"],
        "Netherlands": ["Amsterdam", "Rotterdam", "Eindhoven", "Utrecht", "Arnhem", "Groningen", "Tilburg", "Breda"],
        "Uruguay": ["Montevideo", "Salto", "Paysandu", "Maldonado", "Rivera", "Colonia", "Durazno", "Florida"],
        "Belgium": ["Brussels", "Antwerp", "Bruges", "Ghent", "Liege", "Genk", "Mechelen", "Charleroi"],
        "Croatia": ["Zagreb", "Split", "Rijeka", "Osijek", "Zadar", "Pula", "Varazdin", "Sibenik"],
        "Mexico": ["Mexico City", "Guadalajara", "Monterrey", "Puebla", "Tijuana", "Leon", "Toluca", "Queretaro"],
        "United States": ["New York", "Los Angeles", "Chicago", "Miami", "Dallas", "Seattle", "Atlanta", "Orlando"],
        "Japan": ["Tokyo", "Osaka", "Kyoto", "Yokohama", "Kobe", "Sapporo", "Nagoya", "Hiroshima"],
        "South Korea": ["Seoul", "Busan", "Incheon", "Daegu", "Daejeon", "Ulsan", "Suwon", "Gwangju"],
        "Morocco": ["Casablanca", "Rabat", "Marrakesh", "Tangier", "Fes", "Agadir", "Oujda", "Tetouan"],
        "Switzerland": ["Zurich", "Basel", "Geneva", "Bern", "Lausanne", "Lugano", "Lucerne", "St. Gallen"],
        "Denmark": ["Copenhagen", "Aarhus", "Odense", "Aalborg", "Esbjerg", "Randers", "Vejle", "Horsens"]
    }

    suffixes = [
        "FC", "United", "City", "Athletic", "Rovers", "Wanderers",
        "Sporting", "Dynamo", "Maccabi", "Hapoel", "Lions", "Eagles"
    ]

    while True:
        city = random.choice(cities_by_country[country])
        suffix = random.choice(suffixes)
        team_name = f"{city} {suffix}"

        if team_name not in used_names:
            used_names.add(team_name)
            return team_name


def get_match_odd(match_id, predicted_result, odds_by_match):
    """Return the correct odd according to the predicted result."""
    odd_data = odds_by_match[match_id]

    if predicted_result == "Home":
        return odd_data["Home"]
    if predicted_result == "Draw":
        return odd_data["Draw"]
    return odd_data["Away"]


def add_transaction(transactions, balances, transaction_id, user_id, amount, transaction_type, transaction_date):
    """Add a transaction and update the user's current balance."""
    amount = round(amount, 2)

    transactions.append([
        transaction_id,
        amount,
        transaction_type,
        transaction_date,
        user_id
    ])

    if transaction_type in ["Deposit", "Winnings"]:
        balances[user_id] += amount
    else:
        balances[user_id] -= amount

    return transaction_id + 1


# ============================================================
# VALID ID LISTS
# ============================================================
# These lists are the key to respecting the foreign keys.
# A foreign key must always point to an existing primary key.

user_ids = list(range(1, NUM_USERS + 1))
team_ids = list(range(1, NUM_TEAMS + 1))
match_ids = list(range(1, NUM_MATCHES + 1))


# ============================================================
# USERS DATA
# Parent table.
# User rows are written after balances are calculated.
# ============================================================

user_profiles = {}
user_registration_dates = {}
account_statuses = ["Active", "Inactive", "Blocked"]

for user_id in user_ids:
    first_name = fake.first_name()
    last_name = fake.last_name()
    full_name = f"{first_name} {last_name}"

    # Email is based on the same generated name.
    email = make_email(first_name, last_name, user_id)

    registration_date = random_date(date(2024, 1, 1), date(2026, 4, 15))
    account_status = random.choice(account_statuses)

    user_profiles[user_id] = {
        "first_name": first_name,
        "last_name": last_name,
        "full_name": full_name,
        "email": email,
        "account_status": account_status
    }

    user_registration_dates[user_id] = registration_date


# ============================================================
# TEAMS
# Parent table.
# MATCHES will reference team_id from this table.
# ============================================================

teams = []
used_team_names = set()

football_countries = [
    "Israel", "Brazil", "Argentina", "Spain", "England", "France",
    "Germany", "Italy", "Portugal", "Netherlands", "Uruguay",
    "Belgium", "Croatia", "Mexico", "United States", "Japan",
    "South Korea", "Morocco", "Switzerland", "Denmark"
]

for team_id in team_ids:
    country = random.choice(football_countries)
    team_name = make_unique_team_name(country, used_team_names)

    teams.append([
        team_id,
        team_name,
        country
    ])


# ============================================================
# MATCHES
# Child table of TEAMS.
# home_team_id and away_team_id are selected only from team_ids.
# ============================================================

matches = []
match_dates = {}
match_statuses = {}
match_results = {}

result_options = ["Home", "Draw", "Away"]
match_status_options = ["Scheduled", "Finished", "Cancelled"]

for match_id in match_ids:
    home_team_id = random.choice(team_ids)
    away_team_id = random.choice(team_ids)

    while away_team_id == home_team_id:
        away_team_id = random.choice(team_ids)

    status = random.choices(
        match_status_options,
        weights=[60, 35, 5],
        k=1
    )[0]

    if status == "Finished":
        match_date = random_date(date(2026, 1, 10), date(2026, 4, 25))
        final_result = random.choice(result_options)
    elif status == "Scheduled":
        match_date = random_date(date(2026, 5, 15), date(2026, 12, 31))
        final_result = ""
    else:
        match_date = random_date(date(2026, 2, 1), date(2026, 12, 31))
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


# ============================================================
# ODDS
# Child table of MATCHES.
# ODDS.match_id is UNIQUE, so we create one odds row per match.
# ============================================================

odds = []
odds_by_match = {}

for odd_id, match_id in enumerate(match_ids, start=1):
    match_date = match_dates[match_id]

    update_date = random_date(
        match_date - timedelta(days=30),
        match_date - timedelta(days=1)
    )

    home_win_odd = round(random.uniform(1.25, 4.25), 2)
    draw_odd = round(random.uniform(2.40, 5.20), 2)
    away_win_odd = round(random.uniform(1.30, 4.50), 2)

    odds_by_match[match_id] = {
        "Home": home_win_odd,
        "Draw": draw_odd,
        "Away": away_win_odd
    }

    odds.append([
        odd_id,
        home_win_odd,
        draw_odd,
        away_win_odd,
        update_date,
        match_id
    ])


# ============================================================
# BETS
# Child table of USERS and MATCHES.
# user_id and match_id are selected only from existing IDs.
# ============================================================

bets = []
bets_by_id = {}

for bet_id in range(1, NUM_BETS + 1):
    while True:
        match_id = random.choice(match_ids)
        match_date = match_dates[match_id]
        latest_bet_date = min(PROJECT_DATE, match_date - timedelta(days=1))

        eligible_users = [
            user_id for user_id in user_ids
            if user_registration_dates[user_id] <= latest_bet_date
        ]

        if eligible_users:
            break

    user_id = random.choice(eligible_users)
    predicted_result = random.choice(result_options)
    bet_amount = round(random.uniform(10, 250), 2)

    bet_date = random_date(
        user_registration_dates[user_id],
        latest_bet_date
    )

    if match_statuses[match_id] == "Finished":
        bet_status = "Won" if predicted_result == match_results[match_id] else "Lost"
    elif match_statuses[match_id] == "Cancelled":
        bet_status = "Cancelled"
    else:
        bet_status = "Pending"

    bet_row = [
        bet_id,
        predicted_result,
        bet_amount,
        bet_date,
        bet_status,
        user_id,
        match_id
    ]

    bets.append(bet_row)
    bets_by_id[bet_id] = bet_row


# ============================================================
# TRANSACTIONS
# Child table of USERS.
# user_id is selected only from existing user_ids.
# Some transactions are based on existing bets for realistic data.
# ============================================================

transactions = []
balances = {user_id: 0.0 for user_id in user_ids}
transaction_id = 1

# Every user receives at least one realistic deposit.
for user_id in user_ids:
    amount = round(random.uniform(3000, 15000), 2)
    transaction_date = random_date(user_registration_dates[user_id], PROJECT_DATE)

    transaction_id = add_transaction(
        transactions,
        balances,
        transaction_id,
        user_id,
        amount,
        "Deposit",
        transaction_date
    )

# Additional deposits.
while len(transactions) < 5000:
    user_id = random.choice(user_ids)
    amount = round(random.uniform(500, 8000), 2)
    transaction_date = random_date(user_registration_dates[user_id], PROJECT_DATE)

    transaction_id = add_transaction(
        transactions,
        balances,
        transaction_id,
        user_id,
        amount,
        "Deposit",
        transaction_date
    )

# Bet placement transactions connected to existing bets.
shuffled_bets = bets.copy()
random.shuffle(shuffled_bets)

for bet in shuffled_bets:
    if len(transactions) >= 15000:
        break

    bet_id, predicted_result, bet_amount, bet_date, bet_status, user_id, match_id = bet

    if balances[user_id] >= bet_amount:
        transaction_id = add_transaction(
            transactions,
            balances,
            transaction_id,
            user_id,
            bet_amount,
            "Bet Placement",
            bet_date
        )

# Winnings transactions connected to won bets.
won_bets = [bet for bet in bets if bet[4] == "Won"]
random.shuffle(won_bets)

for bet in won_bets:
    if len(transactions) >= 17500:
        break

    bet_id, predicted_result, bet_amount, bet_date, bet_status, user_id, match_id = bet
    winning_odd = get_match_odd(match_id, predicted_result, odds_by_match)
    amount = round(bet_amount * winning_odd, 2)
    transaction_date = min(match_dates[match_id] + timedelta(days=random.randint(1, 3)), PROJECT_DATE)

    transaction_id = add_transaction(
        transactions,
        balances,
        transaction_id,
        user_id,
        amount,
        "Winnings",
        transaction_date
    )

# Withdrawal transactions only when the user has enough balance.
withdrawal_attempts = 0

while len(transactions) < 19000 and withdrawal_attempts < 10000:
    withdrawal_attempts += 1
    user_id = random.choice(user_ids)

    if balances[user_id] < 300:
        continue

    max_withdrawal = min(2000, balances[user_id] * 0.30)
    amount = round(random.uniform(50, max_withdrawal), 2)
    transaction_date = random_date(user_registration_dates[user_id], PROJECT_DATE)

    transaction_id = add_transaction(
        transactions,
        balances,
        transaction_id,
        user_id,
        amount,
        "Withdrawal",
        transaction_date
    )

# Fill remaining rows with deposits to reach exactly NUM_TRANSACTIONS.
while len(transactions) < NUM_TRANSACTIONS:
    user_id = random.choice(user_ids)
    amount = round(random.uniform(200, 5000), 2)
    transaction_date = random_date(user_registration_dates[user_id], PROJECT_DATE)

    transaction_id = add_transaction(
        transactions,
        balances,
        transaction_id,
        user_id,
        amount,
        "Deposit",
        transaction_date
    )


# ============================================================
# USERS FINAL ROWS
# Current balance is calculated from the generated transactions.
# ============================================================

users = []

for user_id in user_ids:
    profile = user_profiles[user_id]
    balance = round(balances[user_id], 2)

    users.append([
        user_id,
        profile["full_name"],
        profile["email"],
        balance,
        user_registration_dates[user_id],
        profile["account_status"]
    ])


# ============================================================
# BASIC VALIDATION
# These checks prove that the generated data respects the logic.
# ============================================================

for row in users:
    user_id, full_name, email, balance, registration_date, account_status = row
    first_name = user_profiles[user_id]["first_name"]
    last_name = user_profiles[user_id]["last_name"]
    expected_prefix = f"{clean_for_email(first_name)}.{clean_for_email(last_name)}"

    assert email.startswith(expected_prefix)
    assert len(email) <= 100
    assert balance >= 0

for row in teams:
    team_id, team_name, country = row

    assert team_id in team_ids
    assert len(team_name) <= 100
    assert len(country) <= 50

for row in matches:
    match_id, match_date, status, final_result, home_team_id, away_team_id = row

    assert home_team_id in team_ids
    assert away_team_id in team_ids
    assert home_team_id != away_team_id

    if status == "Finished":
        assert final_result in result_options
        assert match_date < PROJECT_DATE
    else:
        assert final_result == ""

for row in odds:
    odd_id, home_win_odd, draw_odd, away_win_odd, update_date, match_id = row

    assert match_id in match_ids
    assert update_date < match_dates[match_id]
    assert home_win_odd > 1
    assert draw_odd > 1
    assert away_win_odd > 1

assert len({row[5] for row in odds}) == len(odds)

for row in bets:
    bet_id, predicted_result, bet_amount, bet_date, bet_status, user_id, match_id = row

    assert user_id in user_ids
    assert match_id in match_ids
    assert predicted_result in result_options
    assert bet_amount > 0
    assert user_registration_dates[user_id] <= bet_date
    assert bet_date < match_dates[match_id]

    if match_statuses[match_id] == "Finished":
        expected_status = "Won" if predicted_result == match_results[match_id] else "Lost"
        assert bet_status == expected_status
    elif match_statuses[match_id] == "Cancelled":
        assert bet_status == "Cancelled"
    else:
        assert bet_status == "Pending"

for row in transactions:
    transaction_id, amount, transaction_type, transaction_date, user_id = row

    assert user_id in user_ids
    assert amount > 0
    assert transaction_type in ["Deposit", "Withdrawal", "Bet Placement", "Winnings"]
    assert transaction_date >= user_registration_dates[user_id]

assert len(transactions) == NUM_TRANSACTIONS


# ============================================================
# WRITE CSV FILES
# Files are written in the recommended database import order.
# ============================================================

write_csv(
    "users.csv",
    ["user_id", "full_name", "email", "balance", "registration_date", "account_status"],
    users
)

write_csv(
    "teams.csv",
    ["team_id", "team_name", "country"],
    teams
)

write_csv(
    "matches.csv",
    ["match_id", "match_date", "status", "final_result", "home_team_id", "away_team_id"],
    matches
)

write_csv(
    "odds.csv",
    ["odd_id", "home_win_odd", "draw_odd", "away_win_odd", "update_date", "match_id"],
    odds
)

write_csv(
    "bets.csv",
    ["bet_id", "predicted_result", "bet_amount", "bet_date", "bet_status", "user_id", "match_id"],
    bets
)

write_csv(
    "transactions.csv",
    ["transaction_id", "amount", "transaction_type", "transaction_date", "user_id"],
    transactions
)


print("CSV files generated successfully!")
print(f"Output folder: {BASE_DIR}")
print(f"Users: {len(users)}")
print(f"Teams: {len(teams)}")
print(f"Matches: {len(matches)}")
print(f"Odds: {len(odds)}")
print(f"Bets: {len(bets)}")
print(f"Transactions: {len(transactions)}")