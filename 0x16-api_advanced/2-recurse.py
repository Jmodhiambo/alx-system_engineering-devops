#!/usr/bin/python3
"""
This module queries the Reddit API recursively to return a list
containing the titles of all hot articles for a given subreddit.
If the subreddit is invalid or has no results, it returns None.
"""

import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    Recursively fetches hot article titles from a given subreddit.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {
        "User-Agent": "custom:hot_posts_recurse:v1.0 (by /u/yourusername)"
    }
    params = {"after": after, "limit": 100}

    try:
        response = requests.get(url, headers=headers,
                                params=params, allow_redirects=False)

        if response.status_code == 200:
            data = response.json()
            posts = data['data']['children']

            for post in posts:
                hot_list.append(post['data']['title'])

            next_page = data['data']['after']
            if next_page is not None:
                return recurse(subreddit, hot_list, next_page)
            else:
                return hot_list
        else:
            return None

    except requests.RequestException:
        return None
