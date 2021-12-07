#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
possitions = input.split(",").map(&:to_i)

def cost(possitions, possition)
  possitions.map { |p| yield (p - possition).abs }.sum
end

def min_cost(possitions)
  min, max = possitions.minmax
  (min..max).map { |p| cost(possitions, p) { |n| yield n } }.min
end

puts "PART1: #{min_cost(possitions) { |n| n }}"
puts "PART2: #{min_cost(possitions) { |n| n * (n + 1) / 2 }}"
