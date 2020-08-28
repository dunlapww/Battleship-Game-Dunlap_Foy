class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil ? true : false
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    @ship.health -= 1 if @ship.class == Ship && @ship.health > 0
  end

  def fired_upon?
    @fired_upon
  end

  def render(show_ship = false)
    if @fired_upon == false && show_ship == false
      return "."
    elsif @fired_upon && @ship.class == Ship && @ship.health == 0
      return "X"
    elsif @fired_upon && @ship == nil
      return "M"
    elsif @fired_upon && @ship.class == Ship
      return "H"
    elsif show_ship && @ship.class == Ship
     return "S"
    else
     return "error_catcher"
    end
  end

end
