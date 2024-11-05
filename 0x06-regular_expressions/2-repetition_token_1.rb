#!/usr/bin/env ruby
# Script to match "hb?tn" pattern in the output pattern.

puts ARGV[0].scan(/hb?tn/).join
