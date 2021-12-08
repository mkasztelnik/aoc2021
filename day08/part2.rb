#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)

class Row
  def initialize(row)
    input, output = row.split(" | ")
    @row = row
    @input = parse(input)
    @output = output.split
  end

  def decode
    grouped = @input.group_by(&:size)
    one = grouped[2].first
    four = grouped[4].first
    seven = grouped[3].first
    eight = grouped[7].first

    nine = grouped[6].detect{ |g| (g - (four + seven)).size == 1 }
    six = (grouped[6] - [nine]).detect{ |g| (g - one).size == 5 }
    zero = (grouped[6] - [nine, six]).first

    two = grouped[5].detect{ |g| (g - nine).size == 1 }
    five = grouped[5].detect{ |g| (g - six).size == 0 }
    three = (grouped[5] - [two, five]).first

    mapping = {
      zero.sort => 0,
      one.sort => 1,
      two.sort => 2,
      three.sort => 3,
      four.sort => 4,
      five.sort => 5,
      six.sort => 6,
      seven.sort => 7,
      eight.sort => 8,
      nine.sort => 9
    }

    @output.map { |o| o.chars.sort }.map { |o| mapping[o] }.join.to_i
  end

  private
    def parse(str)
      str.split.map(&:chars)
    end
end

rows = input.split("\n").map { |line| Row.new(line) }
puts rows.map(&:decode).sum
