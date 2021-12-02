#!/usr/bin/env ruby

file_path = File.expand_path("input.txt", __dir__)
input     = File.read(file_path)

moves = input.split("\n").map do |l|
  elements = l.split(" ")
  [elements[0], elements[1].to_i]
end

class Submarine
  def initialize
    @position, @depth = 0, 0
  end

  def forward(x)
    @position += x
  end

  def up(x)
    @depth -= x
  end

  def down(x)
    @depth += x
  end

  def sum
    @position * @depth
  end
end

submarine = Submarine.new
moves.each { |m| submarine.public_send(*m) }

puts submarine.sum
