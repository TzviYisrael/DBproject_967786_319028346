from db.connection import DatabaseConnection
from db.repository import Repository
from ui.app import BetMasterApp


def main():
    db = DatabaseConnection()
    connected = db.connect()
    if not connected:
        print("Failed to connect to database")
        return

    repo = Repository(db)
    app = BetMasterApp(repo)
    app.run()

    db.disconnect()


if __name__ == "__main__":
    main()
