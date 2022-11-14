#!/usr/bin/env ruby

# convert bpm to milliseconds
# for the purpose of syncing attack/release times
# 60000ms = 60s = 1 minute

bpm = ARGV[0].to_i

bpm_in_milliseconds = 60000 / bpm

puts "1/4: #{bpm_in_milliseconds.to_f}"

eigth = bpm_in_milliseconds / 2
sixtenth = bpm_in_milliseconds / 3
thirtysecond = bpm_in_milliseconds / 4
