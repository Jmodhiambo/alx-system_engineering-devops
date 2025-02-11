#!/usr/bin/python3
"""This script gets employee data from REST API and exports it in JSON format.
"""

import json
import requests
import sys

if __name__ == "__main__":
    user_id = sys.argv[1]  # Read user ID from command line argument

    # Define API endpoints
    emp_url = f"https://jsonplaceholder.typicode.com/users/{user_id}"
    todo_url = f"https://jsonplaceholder.typicode.com/todos?userId={user_id}"

    # Fetch employee and tasks data
    employee = requests.get(emp_url).json()
    todos = requests.get(todo_url).json()

    # Structure the data in the required format
    tasks_list = [
        {
            "task": task["title"],
            "completed": task["completed"],
            "username": employee["username"]
        }
        for task in todos
    ]

    json_data = {user_id: tasks_list}

    # Write data to JSON file
    filename = f"{user_id}.json"
    with open(filename, "w") as file:
        json.dump(json_data, file, indent=4)
