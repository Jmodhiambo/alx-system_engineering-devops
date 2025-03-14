#!/usr/bin/python3
"""
This module queries the Reddit API to print the titles of the first 10 hot
posts for a given subreddit. If the subreddit is invalid, it prints None.
"""

import requests


def top_ten(subreddit):
    """
    Queries the Reddit API and prints the titles of the first 10 hot posts
    for a given subreddit. Prints None if the subreddit is invalid.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {
        "User-Agent": "custom:top_posts_checker:v1.0 (by /u/yourusername)"
    }

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)

        if response.status_code == 200:
            data = response.json()
            posts = data['data']['children']

            for post in posts:
                print(post['data']['title'])
        else:
            print(None)

    except requests.RequestException:
        print(None)
