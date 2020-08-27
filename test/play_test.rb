require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/mainmenu'
require './lib/play'
require 'minitest/autorun'

class PlayTest < Minitest::Test

  def test_it_exists
    play = Play.new()

    assert_instance_of Play, play
  end

end
