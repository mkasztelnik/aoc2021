#!/usr/bin/env ruby

require "debug"

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
polymer, formulas = input.split("\n\n")

polymer = polymer.chars
formulas = formulas.split("\n").map { |line| line.split(" -> ") }.to_h

def step(polymer, formulas)
  new_polymer =
    polymer.each_cons(2)
           .map { |pair| [pair.first, formulas[pair.join]] }
  new_polymer << polymer.last

  new_polymer.flatten
end

min, max = (1..10).reduce(polymer) { |acc, _| step(acc, formulas) }.tally.values.minmax

puts "PART 1: #{max - min}"
