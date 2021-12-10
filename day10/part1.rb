#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
rows = input.split("\n").map(&:chars)

POINTS = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }
PARSER = { "[" => "]", "(" => ")", "{" => "}", "<" => ">" }
STARTS = PARSER.keys

def first_error(chars)
  _, error =
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

  error
end

puts rows.map { |chars| first_error(chars) }.compact.map { |ch| POINTS[ch] }.sum
