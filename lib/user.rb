class User
  def initialize
    @ship_1 = Ship.new("cruiser", 3)
    @ship_2 = Ship.new("submarine", 2)
    @board = Board.new
  end
end
