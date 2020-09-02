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
    if empty?
      @fired_upon ? "M" : "."
    else
      if @fired_upon
        @ship.sunk? ? "X" : "H"
      else
        show_ship ? "S" : "."
      end
    end
  end

  def impact
    return "was a hit!" if render == "H"
    return "was a miss." if render == "M"
    return "sunk a #{@ship.name}!" if render == "X"
  end

end
