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

  # def test_it_has_attributes
  #   computer = Computer.new
  #
  #   assert_nil computer.ship_1
  #   assert_nil computer.ship_2
  # end

  def test_generate_ship_coordinate_placement_vertical
    computer = Computer.new
    actual = computer.generate_ship_coordinate_placement_vertical
    
    expected = [["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"]]
    assert_equal expected, actual
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
