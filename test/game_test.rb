require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/mainmenu'
require './lib/play'
require 'minitest/autorun'

class GameTest < Minitest::Test

  def test_it_exists
    play = Game.new()

    assert_instance_of Game, play
  end

end
