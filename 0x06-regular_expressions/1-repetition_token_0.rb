#!/usr/bin/env ruby
# Script to match "hbt{2,5}n" pattern in the input argument

puts ARGV[0].scan(/hbt{2,5}n/).join
