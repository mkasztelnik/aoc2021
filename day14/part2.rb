#!/usr/bin/env ruby

require "debug"

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
polymer, formulas = input.split("\n\n")

polymer = polymer.chars
formulas = formulas.split("\n").map do |line|
  pair, insertion = line.split(" -> ")
  [pair.chars, insertion]
end.to_h

pairs = polymer.each_cons(2).tally
pairs.default = 0

frequency =
  (1..40)
  .reduce(pairs) do |acc, step|
    puts "step: #{step}"
    acc.each_with_object(Hash.new(0)) do |el, new_acc|
      key, count = el
      first, last = key
      new = formulas[key]

      a = [first, new]
      b = [new, last]

      new_acc[a] += count
      new_acc[b] += count
    end
  end
  .each_with_object(Hash.new(0)) do |el, acc|
    pair, count = el

    acc[pair.first] += count
  end

frequency[polymer.last] += 1
min, max = frequency.values.minmax

puts "PART 2: #{max - min}"
