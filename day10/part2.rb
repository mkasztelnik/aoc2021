#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
rows = input.split("\n").map(&:chars)

POINTS = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }
PARSER = { "[" => "]", "(" => ")", "{" => "}", "<" => ">" }
STARTS = PARSER.keys

def parse(chars)
  chars.reduce([[], nil]) do |acc, char|
    acc, = acc
    if STARTS.include?(char)
      acc.push(PARSER[char])
    else
      expected = acc.pop
      break [acc, char] if expected != char
    end
    [acc, nil]
  end
end

valid =
  rows
  .map { |chars| parse(chars) }
  .reject { |result| result[1] }
  .map { |result| result[0] }
  .map { |acc| acc.reverse }

scores =
  valid.map do |rest|
    rest.reduce(0) { |acc, r| acc * 5 + POINTS[r] }
  end.sort

middle = scores.size / 2

puts scores[middle]
