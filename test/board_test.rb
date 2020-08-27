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

  def setup
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

    @cells = Hash.new()
    coordinates.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end
  end

  def test_board_has_correct_cell_values
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

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

  def test_validate_coordinate?

    board = Board.new()

    assert_equal true, board.validate_coordinate?("A1")
    assert_equal true, board.validate_coordinate?("D1")
    assert_equal false, board.validate_coordinate?("A5")
    assert_equal false, board.validate_coordinate?("E1")
    assert_equal false, board.validate_coordinate?("A22")
  end

  def test_valid_placement
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    assert_equal true, board.valid_placement?(submarine, %w(A1 A2))
    assert_equal true, board.valid_placement?(cruiser, %w(A1 A2 A3))
    assert_equal true, board.valid_placement?(submarine, %w(A1 A2))
    assert_equal false, board.valid_placement?(cruiser,%w(A1 A2))
  end


  # def test_ship_placement_is_consecutive
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #   board = Board.new
  #
  #   board.valid_placement?(cruiser, ["A1", "B1", "C1"])
  #
  # end


end
