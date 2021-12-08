#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
rows       = input.split("\n")

outputs = rows.map { |i| i.split(" | ") }.map(&:last)

puts outputs.flatten.map(&:split).flatten.map(&:size).select { |x| [2, 4, 3, 7].include?(x) }.count
