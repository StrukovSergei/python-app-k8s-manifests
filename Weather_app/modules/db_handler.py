import json
import os
import bcrypt

USERS_FILE = "db.json"

def load_users_from_file():
    """
    Load user data from the JSON file.
    """
    if os.path.exists(USERS_FILE):
        with open(USERS_FILE, 'r') as file:
            return json.load(file)
    return {}

def save_users_to_file(users):
    """
    Save user data to the JSON file.
    """
    with open(USERS_FILE, 'w') as file:
        json.dump(users, file)

def add_user_to_file(username, password):
    """
    Add a new user to the JSON file.
    """
    users = load_users_from_file()
    if username != '' and len(username) >= 3:
        # Check if the username already exists
        if username in users:
            return False    
        else: 
            # Hash the password
            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
            # Insert user into the database
            users[username] = hashed_password
            save_users_to_file(users)
            return True
    else:
        return False

def login_user_from_file(username, password):
    """
    Authenticate user credentials from the JSON file.
    """
    users = load_users_from_file()
    if username in users:
        hashed_password = users[username]
        # Check if the hashed password matches the provided password
        if bcrypt.checkpw(password.encode('utf-8'), hashed_password.encode('utf-8')):
            return True
    return False
