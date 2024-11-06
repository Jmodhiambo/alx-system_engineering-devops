#!/usr/bin/env ruby
# Script that matches "hbt{1,}n pattern.

puts ARGV[0].scan(/hbt+n|hbn/).join
