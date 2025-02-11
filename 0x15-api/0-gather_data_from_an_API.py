#!/usr/bin/python3
"""This script gets employee data from a REST API and returns info about
his/her TODO list progress.
"""

import requests
from sys import argv

user_id = int(argv[1])

emp_url = f"https://jsonplaceholder.typicode.com/users/{user_id}"
todo_url = f"https://jsonplaceholder.typicode.com/todos?userId={user_id}"

# Gets the employee data and their todo list.
employee = requests.get(emp_url).json()
todos = requests.get(todo_url).json()

# Finds the completed and total task for the specific employee
completed_task = len([task for task in todos if task["completed"]])
total_task = len(todos)

print("Employee {} is done with tasks({}/{}):"
      .format(employee["name"], completed_task, total_task))

# Prints the tasks completed by the employee
for task in todos:
    if task["completed"]:
        print("\t {}".format(task["title"]))
