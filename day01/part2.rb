#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
input     = File.read(file_path)

measures = input.split("\n").map(&:to_i)

puts measures.each_cons(3).map { |e| e.sum }.each_cons(2).map { |e| e[0] < e[1] ? 1 : 0 }.sum
