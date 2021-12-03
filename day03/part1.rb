#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
input     = File.read(file_path)
rows      = input.split("\n")

size = rows.size / 2
gammar_rate, epsilon_rate =
  rows
  .map { |i| i.chars.map(&:to_i) }
  .transpose.map { |r| r.sum <= size ? [0, 1] : [1, 0] }
  .transpose.map(&:join)
  .map { |binary| binary.to_i(2) }

puts gammar_rate * epsilon_rate
