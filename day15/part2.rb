#!/usr/bin/env ruby

require "set"
require 'pqueue'

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
map = input.split("\n").map { |row| row.chars.map(&:to_i) }

def neighbours(current, x_max, y_max)
  x, y = current
  points = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
  points.reject do |p|
    p_x, p_y = p
    p_x < 0 || p_y < 0 || p_x > x_max || p_y > y_max
  end
end

def shortest_path(map, from, to)
  visited = {}
  candidates = PQueue.new([[from, 0]]){ |a, b| a[1] < b[1] }
  x_max, y_max = [map[0].size - 1, map.size - 1]

  while candidates.size.positive?
    current, risk = candidates.pop

    return risk if current == to
    next if visited.key?(current)

    visited[current] = risk
    neighbours(current, x_max, y_max)
      .reject { |n| visited.key?(n) }
      .each { |n| candidates.push([n, risk + map[n[1]][n[0]]]) }
  end

  "no result"
end

def bigger(map)
  y_size = map.size

  lines =
    map.map do |line|
      (0..4).map { |i| line.map { |n| n + i }.map { |n| n > 9 ? n - 9 : n } }.flatten
    end

  (lines * 5).each_with_index.map do |line, i|
    addition = i / y_size
    line.map { |n| n + addition }.map { |n| n > 9 ? n - 9 : n }
  end
end

big_map = bigger(map)

puts shortest_path(big_map, [0, 0], [big_map[0].size - 1, big_map.size - 1])
