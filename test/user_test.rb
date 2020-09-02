require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/user'
require './lib/computer'

class UserTest < Minitest::Test

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

  # def tas
  #
  # end

end
