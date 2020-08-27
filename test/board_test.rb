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

  def test_number_of_coordinates_in_array_equals_length_of_ship
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    assert_equal false, board.valid_placement?(cruiser, %w(A1 A2))
    assert_equal false, board.valid_placement?(submarine, %w(A2 A3 A4))
  end

  def test_number_of_coordinates_in_array_equals_length_of_ship_helper_method
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    assert_equal false, board.placement_is_length_of_ship(cruiser, %w(A1 A2))
    assert_equal false, board.placement_is_length_of_ship(submarine, %w(A2 A3 A4))
  end

  # def test_ship_coordinates_are_consecutive
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #   board = Board.new
  #
  #   assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
  #   assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  # end
  #
  def test_ship_coordinates_are_consecutive_healper_method
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    # board.breakup_ship_placement(["A1", "A2", "A4"])
    # board.breakup_ship_placement_to_letters_and_numbers
    # assert_equal false, board.coordinates_are_consecutive
    #
    # board.breakup_ship_placement(["A1", "C1"])
    # board.breakup_ship_placement_to_letters_and_numbers
    # assert_equal false, board.coordinates_are_consecutive

    board.breakup_ship_placement(["A3", "A2", "A1"])
    board.breakup_ship_placement_to_letters_and_numbers
    assert_equal false, board.coordinates_are_consecutive

    board.breakup_ship_placement(["C1", "B1"])
    board.breakup_ship_placement_to_letters_and_numbers
    assert_equal false, board.coordinates_are_consecutive
  end

  def test_coordinates_cannot_be_diagonal
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_coordinates_cannot_be_diagonal_helper_method
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    board.breakup_ship_placement(["A1", "B2", "C3"])
    board.breakup_ship_placement_to_letters_and_numbers
    assert_equal false, board.ship_is_either_horizontal_or_vertical

    board.breakup_ship_placement(["C2", "D3"])
    board.breakup_ship_placement_to_letters_and_numbers
    assert_equal false, board.ship_is_either_horizontal_or_vertical
  end

  def test_valid_placement_positive_return
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board = Board.new

    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
  end
end
