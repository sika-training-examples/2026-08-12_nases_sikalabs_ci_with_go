import time
import random
import os

import psycopg2

DB_HOST = os.getenv("DB_HOST", "postgres.kafka.svc")
DB_PORT = int(os.getenv("DB_PORT", "5432"))
DB_NAME = os.getenv("DB_NAME", "example")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "pg")
INTERVAL = float(os.getenv("INTERVAL", "2"))

FIRST_NAMES = ["Alice", "Bob", "Charlie", "Diana", "Eve", "Frank", "Grace", "Henry", "Iris", "Jack"]
LAST_NAMES = ["Smith", "Jones", "Brown", "Wilson", "Taylor", "Davis", "Miller", "White", "Clark", "Lewis"]
PET_NAMES = ["Buddy", "Max", "Bella", "Charlie", "Lucy", "Cooper", "Luna", "Rocky", "Daisy", "Molly"]
PET_KINDS = ["dog", "cat", "rabbit", "hamster", "parrot", "fish", "turtle", "snake", "lizard", "guinea pig"]


def random_name():
    return f"{random.choice(FIRST_NAMES)} {random.choice(LAST_NAMES)}"


def random_email(name):
    first, last = name.lower().split()
    return f"{first}.{last}_{random.randint(1000, 9999)}@example.com"


def connect():
    while True:
        try:
            conn = psycopg2.connect(
                host=DB_HOST, port=DB_PORT, dbname=DB_NAME,
                user=DB_USER, password=DB_PASSWORD,
            )
            conn.autocommit = True
            print("Connected to PostgreSQL", flush=True)
            return conn
        except Exception as e:
            print(f"Connection failed: {e}, retrying in 5s...", flush=True)
            time.sleep(5)


def main():
    conn = connect()
    cur = conn.cursor()
    user_ids = []
    iteration = 0

    while True:
        try:
            name = random_name()
            email = random_email(name)
            cur.execute(
                "INSERT INTO users (name, email) VALUES (%s, %s) RETURNING id",
                (name, email),
            )
            user_id = cur.fetchone()[0]
            user_ids.append(user_id)
            print(f"[INSERT] user id={user_id} name={name}", flush=True)

            pet_name = random.choice(PET_NAMES)
            pet_kind = random.choice(PET_KINDS)
            cur.execute(
                "INSERT INTO pets (name, kind, owner_id) VALUES (%s, %s, %s) RETURNING id",
                (pet_name, pet_kind, user_id),
            )
            pet_id = cur.fetchone()[0]
            print(f"[INSERT] pet id={pet_id} name={pet_name} kind={pet_kind} owner={user_id}", flush=True)

            if iteration % 3 == 0 and len(user_ids) > 1:
                uid = random.choice(user_ids)
                new_name = random_name()
                cur.execute("UPDATE users SET name=%s WHERE id=%s", (new_name, uid))
                print(f"[UPDATE] user id={uid} new name={new_name}", flush=True)

            if iteration % 7 == 0 and len(user_ids) > 3:
                uid = user_ids.pop(random.randrange(len(user_ids)))
                cur.execute("DELETE FROM pets WHERE owner_id=%s", (uid,))
                cur.execute("DELETE FROM users WHERE id=%s", (uid,))
                print(f"[DELETE] user id={uid} and their pets", flush=True)

            iteration += 1
            time.sleep(INTERVAL)

        except psycopg2.OperationalError:
            print("Connection lost, reconnecting...", flush=True)
            conn = connect()
            cur = conn.cursor()


if __name__ == "__main__":
    main()
