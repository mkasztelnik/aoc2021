#!/usr/bin/env ruby

require "set"

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
matrix = input.split("\n").map { |row| [9] + row.chars.map(&:to_i) + [9] }

first_and_last = (1..(matrix[0].size)).map { 9 }
matrix = [first_and_last] + matrix + [first_and_last]

x_max = matrix[0].size - 2
x_interval = 1..x_max
y_interval = 1..(matrix.size - 2)

def print(matrix)
  (0..(matrix.size - 1)).each do |y|
    line = (0..(matrix[0].size - 1)).map { |x| matrix[y][x] == 9 ? 9 : "." }.join
    puts line
  end
end


def nil_if_nine(matrix, x, y)
  [x, y] if matrix[y][x] != 9
end

def find(matrix, point, visited)
  return [] if visited.include?(point)

  x, y = point
  visited << point

  neighbors =
    [nil_if_nine(matrix, x, y - 1), nil_if_nine(matrix, x, y + 1),
    nil_if_nine(matrix, x - 1, y), nil_if_nine(matrix, x + 1, y)]
      .compact

  other_points = neighbors
    .map { |n| find(matrix, n, visited) }
    .flatten(1)

  other_points << point
end

result =
  y_interval.reduce(Struct.new(:visited, :basens).new(Set.new, [])) do |acc, y|
    x_interval.reduce(acc) do |acc, x|
      point = nil_if_nine(matrix, x, y)
      acc.basens << find(matrix, point, acc.visited) if point && !acc.visited.include?(point)

      acc
    end
  end

print(matrix)
puts result.basens.map(&:size).max(3).inject(&:*)
