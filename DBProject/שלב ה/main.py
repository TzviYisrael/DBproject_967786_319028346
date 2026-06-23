from db.connection import DatabaseConnection
from db.repository import Repository
from ui.app import BetMasterAdmin


def main():
    db = DatabaseConnection()
    connected = db.connect()
    if not connected:
        print("Failed to connect to database")
        return

    repo = Repository(db)
    admin = BetMasterAdmin(repo)
    admin.run()

    db.disconnect()


if __name__ == "__main__":
    main()
