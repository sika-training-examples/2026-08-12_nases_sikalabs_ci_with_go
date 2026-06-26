import time
import random
import os
from datetime import datetime, timezone

from pymongo import MongoClient
from pymongo.errors import PyMongoError

MONGO_URI = os.getenv("MONGO_URI", "mongodb://mongodb.kafka.svc:27017/?replicaSet=rs0")
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
            client = MongoClient(MONGO_URI, serverSelectionTimeoutMS=5000)
            client.admin.command("ping")
            print("Connected to MongoDB", flush=True)
            return client
        except PyMongoError as e:
            print(f"Connection failed: {e}, retrying in 5s...", flush=True)
            time.sleep(5)


def main():
    client = connect()
    db = client["example"]
    users = db["users"]
    pets = db["pets"]
    user_ids = []
    iteration = 0

    while True:
        try:
            name = random_name()
            email = random_email(name)
            result = users.insert_one({
                "name": name,
                "email": email,
                "created_at": datetime.now(timezone.utc),
            })
            user_id = result.inserted_id
            user_ids.append(user_id)
            print(f"[INSERT] user id={user_id} name={name}", flush=True)

            pet_name = random.choice(PET_NAMES)
            pet_kind = random.choice(PET_KINDS)
            pet_result = pets.insert_one({
                "name": pet_name,
                "kind": pet_kind,
                "owner_id": user_id,
                "created_at": datetime.now(timezone.utc),
            })
            print(f"[INSERT] pet id={pet_result.inserted_id} name={pet_name} kind={pet_kind} owner={user_id}", flush=True)

            if iteration % 3 == 0 and len(user_ids) > 1:
                uid = random.choice(user_ids)
                new_name = random_name()
                users.update_one({"_id": uid}, {"$set": {"name": new_name}})
                print(f"[UPDATE] user id={uid} new name={new_name}", flush=True)

            if iteration % 7 == 0 and len(user_ids) > 3:
                uid = user_ids.pop(random.randrange(len(user_ids)))
                pets.delete_many({"owner_id": uid})
                users.delete_one({"_id": uid})
                print(f"[DELETE] user id={uid} and their pets", flush=True)

            iteration += 1
            time.sleep(INTERVAL)

        except PyMongoError as e:
            print(f"Error: {e}, reconnecting...", flush=True)
            client = connect()
            db = client["example"]
            users = db["users"]
            pets = db["pets"]


if __name__ == "__main__":
    main()
