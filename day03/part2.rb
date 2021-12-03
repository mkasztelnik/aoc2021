#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
# file_path = File.expand_path("example.txt", __dir__)
input     = File.read(file_path)
rows      = input.split("\n")


numbers = rows.map { |i| i.chars.map(&:to_i) }
col_size = numbers.first.size

def reduce(numbers)
  col_size = numbers.first.size
  (0..(col_size - 1)).reduce(numbers) do |current, n|
    break current if current.size == 1

    size = (current.size + 1) / 2
    value = yield current.map { |row| row[n] }.sum < size
    current.select { |row| row[n] == value }
  end.first.join.to_i(2)
end

ogr = reduce(numbers) { |e| e ? 0 : 1 }
co2 = reduce(numbers) { |e| e ? 1 : 0 }

puts "#{ogr} * #{co2} = #{ogr * co2}"
