#!/usr/bin/env ruby
# The script should output: [SENDER],[RECEIVER],[FLAGS]

puts ARGV[0].scan(/from:(\+?\w+)\] \[to:(\+?\w+)\] \[flags:([\d:-]+)\]/).join(",")
