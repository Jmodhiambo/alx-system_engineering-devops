#!/usr/bin/python3
"""This script gets employee data from a REST API and returns info about
his/her TODO list progress.
"""

import csv
import requests
import sys


if __name__ == "__main__":
    user_id = int(sys.argv[1])

    filename = f"{user_id}.csv"

    emp_url = f"https://jsonplaceholder.typicode.com/users/{user_id}"
    todo_url = f"https://jsonplaceholder.typicode.com/todos?userId={user_id}"

    # Gets the employee data and their todo list.
    employee = requests.get(emp_url).json()
    todos = requests.get(todo_url).json()

    with open(filename, "w", newline="") as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)

        # Iterating through todos to write the tasks
        for task in todos:
            writer.writerow([str(task["userId"]), employee["username"],
                            str(task["completed"]), task["title"]])
