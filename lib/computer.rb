class Computer

  attr_reader :ship_1, :ship_2
  def initialize
    @ship_1 = Ship.new("cruiser", 3)
    @ship_2 = Ship.new("Submarine", 2)
    @board  = Board.new
  end

  def generate_fire_upon_coordinate
    available_coords = user.board.
  # method that gets valid placements, rand, and then passes coordinates
  # into valid_placement? board method. Loop until rand coord passes true
  # from valid_placement?.
  # thus, 2 helper methods, atleast.

  def generate_ship_coordinate_placement(ship) # place in length of the ship, dynamic
    possible_rows = Array.new
    (1..@board.width).each_cons(ship.length) do |column|
      possible_rows << column.map { |ordinate| (ordinate+64).chr }
    end

    possible_vertical_coordinates = Array.new
      possible_rows.each do |a|
        (1..@board.length).each do |column|
          possible_vertical_coordinates << a.map { |num| num + column.to_s}
        end
      end
      # get all possible horizontal coordinates, add array to possible_vertical_coordinates
      # sample from collective rand array.
      require "pry"; binding.pry

  end

  def place_ship(ship, )
    #places
  end

# consider will, if start with list of hash keys on board. Board.keys
# B3, C3, D3 - not generated in the array.

# fire_upon


end
#  pick random cell, pick a random direction *, move consecutively ~to ship.length
#  letters, vertical -> A1, B1, C1
# * A1 -> east, add 1 to A.
# def breakup_ship_placement(ship_position)
#   @nums_letters = ship_position.map {|coord| coord.scan(/\d+|\D+/)}
# end

# ascii - how to convert ascii to string characters. how to get them,
# how to convert, convert back

#   (ship_1)@cells.keys => array or cell coordinates (randomize’s one coordinate,
#   how to then generate 1-2 consecutive coordinates horizontal or vertical.
#   Randomize if horizontal or vertical. Out of order is invalid) I like this.
#   Might be able to take advantage of computing power and just have it try
#   multiple spots until one works.
#   Cell_coordinate array.randomize => rand_coordinate =>
#   validate_coordinate?(rand_coordinate) => true, cell.place_ship(ship)
