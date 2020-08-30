require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_it_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_it_has_attributes
    computer = Computer.new

    assert_nil computer.ship_1
    assert_nil computer.ship_2
  end

  def test_place_ship
    coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

    @cells = Hash.new()
    coordinates.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end

    board = Board.new
    # require "pry"; binding.pry
    computer = Computer.new
    computer.place_ship_1
    refute_equal board.cells.keys.shuffle, coordinates


  end

end
