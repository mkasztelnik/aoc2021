require "set"

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

def load_numbers_and_boards(relative_file)
  file_path = File.expand_path(relative_file, __dir__)
  input     = File.read(file_path)
  rows      = input.split("\n").reject(&:empty?)

  numbers = rows.shift.split(",")
  boards = rows.map(&:split).each_slice(5).map { |b| Board.new(b) }

  [numbers, boards]
end
