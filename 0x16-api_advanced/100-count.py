#!/usr/bin/python3
"""
This module queries the Reddit API recursively to count occurrences
of keywords in the titles of hot articles for a given subreddit.
"""

import requests
from collections import Counter
import re

def count_words(subreddit, word_list, counts=None, after=None):
    """
    Recursively fetches hot article titles and counts occurrences of keywords.
    """
    if counts is None:
        counts = Counter()
    
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "custom:word_counter:v1.0 (by /u/yourusername)"}
    params = {"after": after, "limit": 100}
    
    try:
        response = requests.get(url, headers=headers,
                                params=params, allow_redirects=False)
        
        if response.status_code != 200:
            return
        
        data = response.json()
        posts = data['data']['children']
        
        word_list = [word.lower() for word in word_list]
        
        for post in posts:
            title = post['data']['title'].lower()
            words = re.findall(r"\b\w+\b", title)
            
            for word in words:
                if word in word_list:
                    counts[word] += 1
        
        after = data['data']['after']
        if after is not None:
            return count_words(subreddit, word_list, counts, after)
        
        if counts:
            sorted_counts = sorted(counts.items(),
                                   key=lambda x: (-x[1], x[0]))
            for word, count in sorted_counts:
                print(f"{word}: {count}")
    
    except requests.RequestException:
        return
