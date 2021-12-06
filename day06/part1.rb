#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
# file_path = File.expand_path("example.txt", __dir__)
input     = File.read(file_path)
fishes      = input.split(",").map(&:to_i)

result = (1..80).reduce(fishes) do |fishes, _|
  new_fishes = 0

  fishes.map do |f|
    if f == 0
      new_fishes += 1
      6
    else
      f -= 1
    end
  end + (1..new_fishes).map { 8 }
end.count

puts result
