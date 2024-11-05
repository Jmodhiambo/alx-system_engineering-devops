#!/usr/bin/env ruby
# Script to match the word "School" in the input argument

# ARGV[0] is the first argument passed to the script
# .scan(/School/) finds all occurrences of "School" in the input
# .join prints all matches in a single line without extra spaces

puts ARGV[0].scan(/School/).join
