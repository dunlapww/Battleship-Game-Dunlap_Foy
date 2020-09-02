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

  def test_it_exists
    board = Board.new()
    assert_instance_of Board, board
  end

  def test_board_length_is_a_number
    board = Board.new()
    assert_instance_of Integer, board.length
  end

  def test_board_width_is_a_number
    board = Board.new()
    assert_instance_of Integer, board.width
  end

  def test_board_rows_returns_incremental_letters
    board = Board.new()
    assert_equal %w(A B C D), board.board_rows
  end

  def test_board_columns_returns_incremental_numbers
    board = Board.new()
    assert_equal [1, 2, 3, 4], board.board_columns
  end

  def test_gen_coord
    board = Board.new()
    assert_equal "A1", board.gen_coord("A", 1)
  end

  def test_it_can_order_the_board_coordinates
    board = Board.new
    sorted_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1",
      "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal sorted_coords, board.ordered_coords
  end

  def test_it_can_generate_a_board
    board = Board.new()
    # board size = 4 x 4
    board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

    assert_instance_of Hash, board.cells
    assert_equal board.length * board.width, board.cells.size
    assert_equal board_coords, board.cells.keys
    board_coords.each do |coord|
      assert_instance_of Cell, board.cells[coord]
    end
  end

  def test_it_can_validate_a_coordinate
    board = Board.new()
    assert_equal true, board.validate_coordinate?("A1")
    assert_equal false, board.validate_coordinate?("ZZ")
  end

  def test_it_can_validate_all_user_coordinates
    board = Board.new()
    assert_equal true, board.user_coords_are_on_board(%w(A1 A2 A3))
    assert_equal false, board.user_coords_are_on_board(%w(A1 Z3 E5))
  end

  def test_coords_are_length_of_ship
    board = Board.new()
    ship = Ship.new("Cruiser", 3)
    assert_equal true, board.user_coords_are_length_of_ship(ship, %w(A1 A2 A3))
    assert_equal false, board.user_coords_are_length_of_ship(ship, %w(A1))
  end

  def test_it_can_extrat_letters_from_user_coords
    board = Board.new()
    assert_equal %w(A A A), board.user_letters(%w(A1 A2 A3))
    assert_equal %w(X Y Z), board.user_letters(%w(X1 Y1 Z2))
  end

  def test_it_knows_if_placement_is_horizontal
    board = Board.new()
    assert_equal true, board.ship_is_horizontal(%w(A1 A2 A3))
    assert_equal false, board.ship_is_horizontal(%w(A1 B1 C1))
  end

  def test_it_can_extract_numbers_from_user_coords
    board = Board.new()
    assert_equal [1, 2, 3], board.user_numbers(%w(A1 A2 A3))
    assert_equal [1, 1, 2], board.user_numbers(%w(X1 Y1 Z2))
  end

  def test_it_knows_if_placement_is_vertical
    board = Board.new
    assert_equal false, board.ship_is_vertical(%w(A1 A2 A3))
    assert_equal true, board.ship_is_vertical(%w(A1 B1 C1))
  end

  def test_placement_must_be_vertical_or_horizontal
    board = Board.new
    assert_equal true, board.ship_is_horizontal_or_vertical(%w(A1 A2 A3))
    assert_equal true, board.ship_is_horizontal_or_vertical(%w(A1 B1 C1))
    assert_equal false, board.ship_is_horizontal_or_vertical(%w(A1 B2 C3))
  end

  def test_user_range_can_be_calculated
    board = Board.new
    set = [1, 3, 5]
    assert_equal [1, 2, 3, 4, 5], board.user_range(set)

    set = ["A", "E", "C"]
    assert_equal %w(A B C D E), board.user_range(set)
  end

  def test_it_can_determine_whether_user_letters_are_consecutive
    board = Board.new

    user_coords = ["A1", "E1", "C1"]
    assert_equal false, board.letters_are_consec(user_coords)

    user_coords = ["A1", "B1", "C1"]
    assert_equal true, board.letters_are_consec(user_coords)

    user_coords = ["B1", "A1", "C1"]
    assert_equal true, board.letters_are_consec(user_coords)
  end

  def test_it_can_determine_whether_user_numbers_are_consecutive
    board = Board.new
    user_coords = ["A1", "E2", "C3"]
    assert_equal true, board.numbers_are_consec(user_coords)

    user_coords = ["A2", "E1", "C3"]
    assert_equal true, board.numbers_are_consec(user_coords)

    user_coords = ["A5", "E2", "C3"]
    assert_equal false, board.numbers_are_consec(user_coords)
  end

  def test_it_knows_if_letters_or_numbers_are_consecutive
    board = Board.new

    user_coords = ["A1", "E2", "C3"]
    assert_equal true, board.user_coords_are_consecutive(user_coords)

    user_coords = ["A2", "B7", "C3"]
    assert_equal true, board.user_coords_are_consecutive(user_coords)

    user_coords = ["A5", "E2", "C3"]
    assert_equal false, board.user_coords_are_consecutive(user_coords)
  end

  def test_it_can_check_for_empty_cells
    board = Board.new()
    ship = Ship.new("Cruiser", 3)
    assert_equal true, board.empty_coordinate?("B2")

    board.cells["B2"].place_ship(ship)
    assert_equal false, board.empty_coordinate?("B2")
  end

  def test_it_can_tell_if_a_ship_is_on_user_coords
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    user_coords = ["A1", "A2", "A3"]
    assert_equal true, board.user_coords_are_empty(user_coords)

    user_coords.each do |coord|
      board.cells[coord].place_ship(ship)
    end

    assert_equal false, board.user_coords_are_empty(user_coords)
  end

  def test_it_can_validate_a_ship_placement
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    user_coords = ["ZZ1", "A2", "A3"]
    assert_equal false, board.valid_placement?(ship, user_coords)

    user_coords = ["A2", "A3"]
    assert_equal false, board.valid_placement?(ship, user_coords)

    user_coords = ["A2", "B3", "C1"]
    assert_equal false, board.valid_placement?(ship, user_coords)

    user_coords = ["A2", "A3", "A5"]
    assert_equal false, board.valid_placement?(ship, user_coords)

    user_coords = ["D1", "D2", "D3"]
    assert_equal true, board.valid_placement?(ship, user_coords)

    other_coords = %w(C2 C3 C4)
    other_coords.each do |coord|
      board.cells[coord].place_ship(ship)
    end

    user_coords = %w(B3 C3 D3)
    assert_equal false, board.valid_placement?(ship, user_coords)
  end

  def test_it_can_displa_column_headers
    board = Board.new
    assert_equal "  1 2 3 4 \n", board.display_column_headers
  end

  def test_it_can_display_row_headers
    board = Board.new
    assert_equal "D ", board.display_row_header(15)
  end

  def test_it_can_render_the_board
    board = Board.new
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n",
    board.render
  end

  def test_place_ship_on_board
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    placement = ["A1","B1","C1"]
    board.place_ship_on_board(ship, placement)
    assert_equal "Cruiser", board.cells["A1"].ship.name
    assert_equal "Cruiser", board.cells["B1"].ship.name
    assert_equal "Cruiser", board.cells["C1"].ship.name
  end

  def test_board_knows_its_been_fired_upon
    board = Board.new
    refute board.cells["A1"].fired_upon?
    board.fire_upon("A1")
    assert board.cells["A1"].fired_upon?
  end

  def test_targetted_cell_not_included_in_untargeted_cells
    board = Board.new
    assert_equal board.cells.size, board.untargeted_cells.size
    board.fire_upon("A1")
    refute board.untargeted_cells.include?("A1")
  end

  def test_cell_has_been_fired_upon
    board = Board.new
    refute board.already_shot?("A1")
    board.fire_upon("A1")
    assert board.already_shot?("A1")
  end

end
