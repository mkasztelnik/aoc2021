#!/usr/bin/env ruby

require "debug"

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
points, foldings = input.split("\n\n")

points = points.split("\n").map { |p| [p.split(",").map(&:to_i), true] }.to_h
foldings = foldings.split("\n").each_with_object([]) do |folding, acc|
  /\Afold along (?<direction>x|y)=(?<value>(\d+))\z/ =~ folding
  acc << [direction, value.to_i]

  acc
end

def fold(points, instruction)
  x, y = instruction[0] == ?x ? [instruction[1], nil] : [nil, instruction[1]]

  # puts "instruction: #{instruction.inspect}"
  # puts "folding: #{x}, #{y}"

  points.keys.reduce({}) do |acc, point|
    new_x = new_location(point[0], x)
    new_y = new_location(point[1], y)

    acc[[new_x, new_y]] = true if new_x && new_y

    acc
  end
end

def new_location(value, folding)
  if !folding || value < folding
    value
  elsif value == folding
    nil
  else
    new_value = folding - (value - folding)
    new_value# if new_value >= 0
  end
end

def print(points)
  points_arr = points.keys
  x_min, x_max = points_arr.map(&:first).minmax
  y_min, y_max = points_arr.map(&:last).minmax

  map =
    (y_min..y_max).map do |y|
      (x_min..x_max).map { |x| points[[x, y]] ? "#" : " " }.join
    end

  puts map.join("\n")
end

puts "PART 1: #{fold(points, foldings[0]).size}"

result = foldings.reduce(points) do |acc, instruction|
  acc = fold(acc, instruction)
end

puts "PART 2:"
print(result)
