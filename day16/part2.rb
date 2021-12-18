#!/usr/bin/env ruby
#
def to_binary(hex)
  hex.chars.map { |ch| format("%04d", ch.to_i(16).to_s(2)) }.join.chars
end

file_path  = File.expand_path("input.txt", __dir__)
input = File.read(file_path).strip

def number(input, location, number_str = "")
  prefix = input[location]
  number = input[(location + 1)..(location + 4)].join

  if prefix == "1"
    number(input, location + 5, "#{number_str}#{number}")
  else
    ["#{number_str}#{number}".to_i(2), location + 5]
  end
end

def packet(input, location = 0)
  version = input[location..(location + 2)].join.to_i(2)
  id = input[(location + 3)..(location + 5)].join.to_i(2)

  case id
  when 4 # binary number
    number, location = number(input, location + 6)
    [version, id, number, location]
  else # operator
    mode = input[location + 6]
    subpackages = []
    if mode == "0"
      size = input[(location + 7)..(location + 21)].join.to_i(2)
      l = location + 22
      location = location + 22 + size
      loop do
        subpackage = packet(input, l)
        l = subpackage.last
        subpackages << subpackage
        break if location == subpackage.last
      end
    else
      subpackages_size = input[(location + 7)..(location + 17)].join.to_i(2)
      l = location + 18
      subpackages =
        (1..subpackages_size).each_with_object([]) do |_, acc|
          subpackage = packet(input, l)
          l = subpackage.last
          acc << subpackage
        end
    end
    [version, id, subpackages, subpackages.last.last]
  end
end

def sum(parsed, sum = 0)
  parsed.reduce(sum) do |s, package|
    s += package[0]
    s += sum(package[2]) if package[1] != 4
    s
  end
end

def calculate(packet)
  id = packet[1]
  return packet[2] if id == 4

  sums = packet[2].map { |p| calculate(p) }

  case id
  when 0
    sums.reduce(0) { |acc, sum| acc + sum }
  when 1
    sums.reduce(1) { |acc, sum| acc * sum }
  when 2
    sums.min
  when 3
    sums.max
  when 5
    sums[0] > sums[1] ? 1 : 0
  when 6
    sums[0] < sums[1] ? 1 : 0
  when 7
    sums[0] == sums[1] ? 1 : 0
  end
end

puts "PART 1: #{sum([packet(to_binary(input))])}"
puts "PART 2: #{calculate(packet(to_binary(input)))}"
