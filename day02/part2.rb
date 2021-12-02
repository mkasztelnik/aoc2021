#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
input     = File.read(file_path)

moves = input.split("\n").map do |l|
  elements = l.split(" ")
  [elements[0], elements[1].to_i]
end

class Submarine
  def initialize
    @position, @depth, @aim = 0, 0, 0
  end

  def forward(x)
    @position += x
    @depth += x * @aim
  end

  def up(x)
    @aim -= x
  end

  def down(x)
    @aim += x
  end

  def sum
    @position * @depth
  end
end

submarine = Submarine.new
moves.each { |m| submarine.public_send(*m) }

puts submarine.sum
