#!/usr/bin/env ruby

require "set"

file_path = File.expand_path("input.txt", __dir__)
# file_path = File.expand_path("example.txt", __dir__)
input     = File.read(file_path)
rows      = input.split("\n").reject(&:empty?)

class Board
  def initialize(board)
    @board = board
    @rows = (board.dup + board.transpose).map { |r| Row.new(r) }
    @numbers = []
  end

  def select(number)
    @numbers << number
    @rows.each { |r| r.select(number) }
  end

  def win?
    @rows.any?(&:win?)
  end

  def score
    (@board.flatten - @numbers).map(&:to_i).sum * @numbers.last.to_i
  end
end

class Row < Set
  def initialize(array)
    super

    @selected = 0
  end

  def select(number)
    @selected += 1 if include?(number)
  end

  def win?
    @selected == 5
  end
end

numbers = rows.shift.split(",")
boards = rows.map(&:split).each_slice(5).map { |b| Board.new(b) }

winning_boards, _ =
  numbers.reduce([[], boards]) do |acc, number|
    winning_boards, boards = acc

    boards.each { |b| b.select(number) }
    new_winners = boards.select(&:win?)

    boards -= new_winners

    break [winning_boards + new_winners, boards] if boards.empty?

    [winning_boards + new_winners, boards]
  end

puts "PART1: #{winning_boards.first.score}"
puts "PART2: #{winning_boards.last.score}"
