require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_cell_has_a_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_cell_initializes_wo_ship
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_cell_is_empty_if_no_ship
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_place_ship
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(ship)

    assert_equal false, cell.empty?
    assert_equal 'Cruiser', cell.ship.name
  end

  def test_when_cell_fired_upon_and_ship
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(ship)
    cell.fire_upon
    assert_equal 2, ship.health
    cell.fire_upon
    assert_equal 1, ship.health
    cell.fire_upon
    assert_equal 0, ship.health
    cell.fire_upon
    assert_equal 0, ship.health

  end

  def test_when_cell_fired_upon_an_no_ship
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.fire_upon
    assert_equal 3, ship.health
  end

  def test_cell_knows_its_fired_upon
    cell = Cell.new("B4")
    cell.fire_upon
    # require "pry"; binding.pry
    assert_equal true, cell.fired_upon?

    cell = Cell.new("B4")
    assert_equal false, cell.fired_upon?
  end

  def test_if_cell_not_fired_upon_render_period
    cell = Cell.new("B4")

    assert_equal ".", cell.render

    cell.fire_upon
    refute_equal ".", cell.render

  end

  def test_cell_render_sunken_ship
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(ship)
    cell.fire_upon
    assert_equal 2, ship.health
    cell.fire_upon
    assert_equal 1, ship.health
    cell.fire_upon
    assert_equal 0, ship.health
    assert_equal "X", cell.render

  end

  def test_cell_render_hit_and_changes_to_X_when_sunk
    ship = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")

    cell.place_ship(ship)
    cell.fire_upon
    assert_equal "H", cell.render
    cell.fire_upon
    assert_equal "H", cell.render
    cell.fire_upon
    assert_equal "X", cell.render

  end

  def test_cell_redner_miss
      cell = Cell.new("B4")

      cell.fire_upon
      assert_equal "M", cell.render

  end

  def test_cell_renders_s_when_passed_true
    cell = Cell.new("B4")

    assert_equal "S", cell.render(true)

  end

  def test_cell_turns_from_s_to_h_to_x
    cell = Cell.new("B4")
    assert_equal "S", cell.render(true)
    cell.fire_upon
    assert_equal "H", cell.render(true)
    cell.fire_upon
    assert_equal "H", cell.render(true)
    cell.fire_upon
    assert_equal "X", cELL.render(true)
  end



end
