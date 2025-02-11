#!/usr/bin/python3
"""Exports all employees' TODO list data to a JSON file."""

import json
import requests

if __name__ == "__main__":
    users_url = "https://jsonplaceholder.typicode.com/users"
    todos_url = "https://jsonplaceholder.typicode.com/todos"

    users = requests.get(users_url).json()
    todos = requests.get(todos_url).json()

    all_data = {}

    for user in users:
        user_id = user["id"]
        username = user["username"]

        user_tasks = [
            {
                "username": username,
                "task": task["title"],
                "completed": task["completed"]
            }
            for task in todos if task["userId"] == user_id
        ]

        all_data[user_id] = user_tasks

    with open("todo_all_employees.json", "w") as file:
        json.dump(all_data, file, indent=4)
