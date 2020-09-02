require 'minitest/autorun'
require 'mocha/minitest'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/game'


class GameTest < Minitest::Test

  def test_it_exists
    play = Game.new()

    assert_instance_of Game, play
  end

  def test_it_can_ask_a_user_to_play
    game = Game.new()

    expected = "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n"
    actual   = game.display_game_message
    assert_equal expected, actual
  end

  def test_it_can_handle_all_user_input
    game = Game.new()

    game.game_start_input = 'P'
    assert_equal "", game.interpret_user_input

    game.game_start_input = 'q'

    game.game_start_input = '7282s'
    expected = "Sorry, it's not clear what you'd like to do, let's try this again...\n\n"
    actual   = game.interpret_user_input
    assert_equal expected, actual
  end

  def test_get_computer_cell
    game = Game.new()
    computer = Computer.new
    game.stubs(:sample).returns("A1")
  end

end
