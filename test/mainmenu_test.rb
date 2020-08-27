require 'minitest/autorun'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/mainmenu'
class MainMenuTest < Minitest::Test

  def test_it_exists
    main_menu = MainMenu.new()

    assert_instance_of MainMenu, main_menu
  end

  def test_it_can_ask_a_user_to_play
    main_menu = MainMenu.new()

    assert_equal "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit.\n", main_menu.display_game_message
  end

  # def test_get_user_input
  #   main_menu = MainMenu.new()
  #
  #   main_menu.user_input = 'P'
  #   assert_equal 'p', main_menu.user_input
  #
  #   main_menu.user_input = 'q'
  #   assert_equal 'q', main_menu.user_input
  #
  #   main_menu.user_input = '2gv09vj'
  #   assert_equal '2gv09vj', main_menu.user_input
  # end

  def test_it_can_handle_all_user_input
    main_menu = MainMenu.new()

    main_menu.user_input = 'P'
    assert_equal "play the game", main_menu.interpret_user_input

    main_menu.user_input = 'q'
    #not sure how to write test, but it seems to work
    #when i try to run a test for 'q', it exits program so...

    main_menu.user_input = '7282s'
    assert_equal "Sorry, it's not clear what you'd like to do, Enter p to play. Enter q to quit.", main_menu.interpret_user_input
  end
end
