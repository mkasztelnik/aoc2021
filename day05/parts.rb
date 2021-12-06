#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
# file_path = File.expand_path("example.txt", __dir__)
input     = File.read(file_path)
rows      = input.split("\n")

class Fc
  def initialize(x1, y1, x2, y2)
    @x1, @y1 = x1.to_i, y1.to_i
    @x2, @y2 = x2.to_i, y2.to_i

    @fn_common = @x2 - @x1 == 0 ? @x1 : (@y2 - @y1) / (@x2 - @x1)
  end

  def horizontal_or_vertical?
    @x1 == @x2 || @y1 == @y2
  end

  def diagonal?
    @fn_common == 1 || @fn_common == -1
  end

  def value_at(x)
    (x - @x1) * @fn_common + @y1
  end

  def points
    if @x1 == @x2
      min, max = [@y1, @y2].minmax
      (min..max).map { |y| [@x1, y] }
    else
      min, max = [@x1, @x2].minmax
      (min..max).map { |x| [x, value_at(x)] }
    end
  end
end

all_lines = rows.map do |row|
  /\A(?<x1>[0-9]+),(?<y1>[0-9]+) -> (?<x2>[0-9]+),(?<y2>[0-9]+)\z/ =~ row
  Fc.new(x1, y1, x2, y2)
end

def overlap_count(lines)
  lines.map(&:points).flatten(1).tally.values.select { |v| v > 1 }.count
end

part1 = overlap_count(all_lines.select(&:horizontal_or_vertical?))
part2 = overlap_count(all_lines.select { |l| l.horizontal_or_vertical? || l.diagonal? })

puts "PART 1: #{part1}"
puts "PART 2: #{part2}"
