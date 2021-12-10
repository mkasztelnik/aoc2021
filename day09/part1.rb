#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
matrix = input.split("\n").map { |row| [9] + row.chars.map(&:to_i) + [9] }

first_and_last = (1..(matrix[0].size)).map { 9 }
matrix = [first_and_last] + matrix + [first_and_last]

x_interval = 1..(matrix[0].size - 2)
y_interval = 1..(matrix.size - 2)

# puts "x interval #{x_interval}"
# puts "y interval #{y_interval}"

mins =
  y_interval.map do |y|
    x_interval.map do |x|
      point = matrix[y][x]
      min = [
        matrix[y - 1][x], matrix[y + 1][x],
        matrix[y][x - 1], matrix[y][x + 1]
      ].min

      point < min ? point : nil
    end
  end.flatten.compact

puts mins.sum { |m| m + 1 }
