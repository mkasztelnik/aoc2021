#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
# file_path = File.expand_path("example.txt", __dir__)
input     = File.read(file_path)
rows      = input.split("\n")


numbers = rows.map { |i| i.chars.map(&:to_i) }
col_size = numbers.first.size

ogr =
  (0..(col_size - 1)).reduce(numbers) do |current, n|
    if current.size > 1
      size = (current.size + 1) / 2
      value = current.map { |row| row[n] }.sum < size ? 0 : 1
      current.select { |row| row[n] == value }
    else
      current
    end
  end.first.join.to_i(2)

co2 =
  (0..(col_size - 1)).reduce(numbers) do |current, n|
    if current.size > 1
      size = (current.size + 1) / 2
      value = current.map { |row| row[n] }.sum < size ? 1 : 0
      current.select { |row| row[n] == value }
    else
      current
    end
  end.first.join.to_i(2)

puts "#{ogr} * #{co2} = #{ogr * co2}"
