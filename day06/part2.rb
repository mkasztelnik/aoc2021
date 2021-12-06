#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
# file_path = File.expand_path("example.txt", __dir__)
input     = File.read(file_path)
fishes      = input.split(",").map(&:to_i)

groups = (0..8).map { |i| [i, 0] }.to_h.merge(fishes.tally)

result = (1..256).reduce(groups) do |groups, _|
  new_fishes = groups.delete(0)

  groups.map { |k, v| [k - 1, v] }.to_h.tap do |g|
    g[6] = g[6] + new_fishes
    g[8] = new_fishes
  end
end.values.sum

puts result
