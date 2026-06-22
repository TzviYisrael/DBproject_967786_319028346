import psycopg2


class DatabaseConnection:
    def __init__(self):
        self.conn = None

    def connect(self):
        self.conn = psycopg2.connect(
            host="localhost",
            port=5432,
            dbname="betmaster",
            user="betmaster_user",
            password="betmaster_pass",
        )
        self.conn.autocommit = True
        return True

    def disconnect(self):
        if self.conn and not self.conn.closed:
            self.conn.close()

    def get_cursor(self):
        if not self.conn or self.conn.closed:
            raise ConnectionError("Not connected to database")
        return self.conn.cursor()

    def is_connected(self):
        return self.conn is not None and not self.conn.closed
