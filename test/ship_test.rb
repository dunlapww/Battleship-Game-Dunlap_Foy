require 'minitest/autorun'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_does_ship_exist
    ship = Ship.new("Cruiser", 3)

    assert_instance_of Ship, ship
  end

  def test_does_ship_have_name_and_length
    ship = Ship.new("Cruiser", 3)

    assert_equal 3, ship.length
    assert_equal "Cruiser", ship.name
  end

  def test_health_equal_length
    ship = Ship.new("Cruiser", 3)

    assert_equal 3, ship.length
    assert_equal 3, ship.health
    assert_equal true, ship.length == ship.health
  end

  def test_ship_sunk
    ship = Ship.new("Cruiser", 3)

    assert_equal false, ship.sunk?
  end

  def test_when_cruiser_hit_health_decremented_and_sunk
    ship = Ship.new("Cruiser", 3)
    ship.hit
    assert_equal 2, ship.health
    assert_equal false, ship.sunk?

    ship.hit
    assert_equal 1, ship.health
    assert_equal false, ship.sunk?

    ship.hit
    assert_equal 0, ship.health
    assert_equal true, ship.sunk?
  end


end
