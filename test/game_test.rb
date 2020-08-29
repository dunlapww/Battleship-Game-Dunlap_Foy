require 'minitest/autorun'
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

    assert_equal "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n", game.display_game_message
  end

  def test_it_can_handle_all_user_input
    game = Game.new()

    game.game_start_input = 'P'
    assert_equal "", game.interpret_user_input

    game.game_start_input = 'q'
    #not sure how to write test, but it seems to work
    #when i try to run a test for 'q', it exits program so...

    game.game_start_input = '7282s'
    assert_equal "Sorry, it's not clear what you'd like to do, let's try this again...\n\n", game.interpret_user_input
  end

end
