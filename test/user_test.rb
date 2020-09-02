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

  def test_display_board
    user = User.new

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, user.display_board
  end

  def test_untargeted_cells
    user = User.new

  end

  def test_targetted_cell_not_included_in_untargeted_cells
    user = User.new
    assert_equal user.board.cells.size, user.untargeted_cells.size
    user.board.fire_upon("A1")
    refute user.untargeted_cells.include?("A1")
  end

  def test_is_fired_upon
    user = User.new

    refute user.already_shot_at?("A1")
    user.is_fired_upon("A1")
    assert user.already_shot_at?("A1")
  end

  def test_already_shot_at?
    user = User.new

    refute user.already_shot_at?("D1")
    user.is_fired_upon("D1")
    assert user.already_shot_at?("D1")
  end

end
