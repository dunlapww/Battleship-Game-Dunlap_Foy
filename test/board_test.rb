require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_board_has_correct_cell_values
    coordinates = %w(A1, A2, A3, A4, B1, B2, B3, B4,
      C1, C2, C3, C4, D1, D2, D3, D4)

    cells = Hash.new()
    coordinates.each do |coordinate|
      cells[coordinate] = Cell.new(coordinate)
    end



    board = Board.new()

    assert_equal coordinates.sort, board.cells.keys.sort
    cells.each do |coord, cell|
      assert_equal Cell, cell.class
      assert_equal coord, cell.coordinate
    end

  end

end
