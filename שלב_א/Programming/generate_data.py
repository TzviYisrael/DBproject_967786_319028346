import csv
import random
from datetime import date, timedelta

random.seed(42)

BASE_DIR = r"C:\Users\iosse\Desktop\DBproject_967786_319028346\שלב_א\Programing"

def random_date(start, end):
    delta = end - start
    return start + timedelta(days=random.randint(0, delta.days))

# ---------- USERS (500) ----------
with open(f"{BASE_DIR}\\users.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["user_id", "full_name", "email", "balance", "registration_date", "account_status"])
    for i in range(1, 501):
        writer.writerow([
            i,
            f"User {i}",
            f"user{i}@example.com",
            round(random.uniform(50, 5000), 2),
            random_date(date(2025, 1, 1), date(2026, 4, 1)),
            "Active"
        ])

# ---------- TEAMS (500) ----------
with open(f"{BASE_DIR}\\teams.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["team_id", "team_name", "country"])
    for i in range(1, 501):
        writer.writerow([
            i,
            f"Team {i}",
            f"Country {((i - 1) % 20) + 1}"
        ])

# ---------- MATCHES (500) ----------
with open(f"{BASE_DIR}\\matches.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["match_id", "match_date", "status", "final_result", "home_team_id", "away_team_id"])
    for i in range(1, 501):
        home_team = random.randint(1, 500)
        away_team = random.randint(1, 500)
        while away_team == home_team:
            away_team = random.randint(1, 500)

        writer.writerow([
            i,
            random_date(date(2026, 4, 1), date(2026, 12, 31)),
            "Scheduled",
            "",
            home_team,
            away_team
        ])

# ---------- ODDS (500) ----------
with open(f"{BASE_DIR}\\odds.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["odd_id", "home_win_odd", "draw_odd", "away_win_odd", "update_date", "match_id"])
    for i in range(1, 501):
        writer.writerow([
            i,
            round(random.uniform(1.20, 3.50), 2),
            round(random.uniform(2.00, 4.50), 2),
            round(random.uniform(1.20, 3.50), 2),
            random_date(date(2026, 3, 1), date(2026, 4, 15)),
            i
        ])

# ---------- BETS (20000) ----------
with open(f"{BASE_DIR}\\bets.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["bet_id", "predicted_result", "bet_amount", "bet_date", "bet_status", "user_id", "match_id"])
    results = ["Home", "Draw", "Away"]
    statuses = ["Pending", "Won", "Lost"]

    for i in range(1, 20001):
        writer.writerow([
            i,
            random.choice(results),
            round(random.uniform(10, 1000), 2),
            random_date(date(2026, 1, 1), date(2026, 4, 15)),
            random.choice(statuses),
            random.randint(1, 500),
            random.randint(1, 500)
        ])

# ---------- TRANSACTIONS (20000) ----------
with open(f"{BASE_DIR}\\transactions.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["transaction_id", "amount", "transaction_type", "transaction_date", "user_id"])
    transaction_types = ["Deposit", "Withdrawal", "Bet Placement", "Winnings"]

    for i in range(1, 20001):
        writer.writerow([
            i,
            round(random.uniform(10, 5000), 2),
            random.choice(transaction_types),
            random_date(date(2026, 1, 1), date(2026, 4, 15)),
            random.randint(1, 500)
        ])

print("CSV files generated successfully!")