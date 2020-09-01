require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_it_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_generate_ships
    computer = Computer.new
    assert_equal 2, computer.ships.size
    computer.ships.each do |ship|
      assert_instance_of Ship, ship
    end
    expected = ["cruiser", "submarine"]
    actual   = computer.ships.map do |ship|
      ship.name
    end.sort
    assert_equal  expected , actual
  end

  def test_generate_ship_coordinate_placement_vertical
    computer = Computer.new
    ship = Ship.new("cruiser", 3)

    actual = computer.generate_ship_coordinate_placement_vertical(ship)
    expected = [["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"],
    ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"],
    ["B3", "C3", "D3"], ["B4", "C4", "D4"]]

    assert_equal expected, actual

    ship = Ship.new("submarine", 2)
    actual = computer.generate_ship_coordinate_placement_vertical(ship)
    expected = [["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"],
    ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"],
    ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]

    assert_equal expected, actual
  end

  def test_generate_possible_ship_placements_horizontal
    computer = Computer.new
    ship = Ship.new("cruiser", 3)

    actual = computer.generate_ship_coordinate_placement_horizontal(ship)
    expected = [["A1", "A2", "A3"], ["B1", "B2", "B3"], ["C1", "C2", "C3"],
    ["D1", "D2", "D3"], ["A2", "A3", "A4"], ["B2", "B3", "B4"],
    ["C2", "C3", "C4"], ["D2", "D3", "D4"]]

    assert_equal expected, actual

    ship = Ship.new("submarine", 2)
    actual = computer.generate_ship_coordinate_placement_horizontal(ship)
    expected = [["A1", "A2"], ["B1", "B2"], ["C1", "C2"], ["D1", "D2"],
    ["A2", "A3"], ["B2", "B3"], ["C2", "C3"], ["D2", "D3"], ["A3", "A4"],
    ["B3", "B4"], ["C3", "C4"], ["D3", "D4"]]

    assert_equal expected, actual
  end


  def test_generate_possible_ship_placements_vertical
    computer = Computer.new
    ship = Ship.new("cruiser", 3)
    # computer.generate_random_possible_ship_placement
    actual = computer.generate_ship_coordinate_placement_vertical(ship)
    expected = [["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"],
    ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"],
    ["B3", "C3", "D3"], ["B4", "C4", "D4"]]

    assert_equal expected, actual
    # test letters / numbers are consec.

    ship = Ship.new("submarine", 2)

    # computer.generate_random_possible_ship_placement
    actual   = computer.generate_ship_coordinate_placement_vertical(ship)
    expected = [["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"],
    ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"],
    ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
  end

  def test_generate_random_possible_ship_placement
    computer = Computer.new
    ship = Ship.new("submarine", 2)
    expected_options = [["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"],
    ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"],
    ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert expected_options.include?(computer.generate_random_possible_ship_placement(ship))
  end

  def test_place_ships_places_ships
    #test it loops if invalid placement
    #have already tested methods in this method, just need to test loop logic
    # computer = Computer.new
    # ship = Ship.new("Cruiser", 3)

    #test it changes cell values to ship when placed
  end

end

# possible_column_coordinates = Array.new
# possible_rows.each do |possible|
#   (1..4).each do |row_num|
#      new_array = row_num.map do |num|
#        require "pry"; binding.pry
#        num + column.to_s
#      end
#   end
#   possible_vertical_coordinates
# end
