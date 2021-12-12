#!/usr/bin/env ruby

require "set"

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
matrix = input.split("\n").map { |row| [-Float::INFINITY] + row.chars.map(&:to_i) + [-Float::INFINITY] }

first_and_last = (1..(matrix[0].size)).map { -Float::INFINITY }
matrix = [first_and_last] + matrix + [first_and_last]

def print(matrix)
  (1..(matrix.size - 2)).each do |y|
    puts matrix[y][1..-2].join
  end
end

def flash(matrix, flashed, x, y)
  return if matrix[y][x] <= 9 ||  flashed.include?([x, y])

  flashed << [x, y]

  matrix[y][x - 1] += 1
  matrix[y][x + 1] += 1
  matrix[y - 1][x] += 1
  matrix[y + 1][x] += 1
  matrix[y - 1][x - 1] += 1
  matrix[y + 1][x - 1] += 1
  matrix[y - 1][x + 1] += 1
  matrix[y + 1][x + 1] += 1

  flash(matrix, flashed, x - 1, y)
  flash(matrix, flashed, x + 1, y)
  flash(matrix, flashed, x, y - 1)
  flash(matrix, flashed, x, y + 1)

  flash(matrix, flashed, x + 1, y + 1)
  flash(matrix, flashed, x + 1, y - 1)
  flash(matrix, flashed, x - 1, y + 1)
  flash(matrix, flashed, x - 1, y - 1)
end

def step(matrix)
  y_interval = (0..(matrix.size - 1))
  x_interval = (0..(matrix[0].size - 1))

  y_interval.each do |y|
    x_interval.each do |x|
      matrix[y][x] += 1
    end
  end

  flashed = Set.new
  y_interval.each do |y|
    x_interval.each do |x|
      flash(matrix, flashed, x, y)
    end
  end

  y_interval.each do |y|
    x_interval.each do |x|
      matrix[y][x] = 0 if matrix[y][x] > 9
    end
  end


  flashed.size
end

def all?(matrix)
  y_interval = (1..(matrix.size - 2))
  x_interval = (1..(matrix[0].size - 2))

  y_interval.all? do |y|
    x_interval.all? do |x|
      matrix[y][x].zero?
    end
  end
end

flash_step =
  (1..Float::INFINITY).reduce(0) do |step, _|
    step += 1
    step(matrix)

    break step if all?(matrix)

    step
  end

puts flash_step
