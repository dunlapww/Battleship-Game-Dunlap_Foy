
class Computer
  attr_reader :ships, :board

  def initialize
    @ships = generate_ships
    @board  = Board.new
  end

  def generate_ships
    ships = []
    ships << Ship.new("cruiser", 3)
    ships << Ship.new("submarine", 2)
    ships
  end

  def generate_ship_coordinate_placement_vertical(ship)
    possible_rows = Array.new
    (1..@board.board_size).each_cons(ship.length) do |vertical_sequence|
      new_array = vertical_sequence.map do |columns_label|
        #ascci capital a, to char in string
        (columns_label + 64).chr
      end
      possible_rows << new_array
      # possible_rows = [["A", "B", "C"], ["B", "C", "D"]]
    end

    possible_column_coordinates = Array.new
    possible_rows.each do |consec_row_label|
      (1..@board.board_size).each do |column_label|
        possible_column_coordinates  << consec_row_label.map do |cap_letter|
          cap_letter + column_label.to_s
        end
      end
    end
    possible_column_coordinates
  end

  def generate_ship_coordinate_placement_horizontal(ship)
    possible_columns  = Array.new
    (1..@board.board_size).each_cons(ship.length) do |horizontal_sequence|
      possible_columns << horizontal_sequence
    end
    # possible_columns = [[1, 2, 3], [2, 3, 4]]

    possible_column_coordinates = Array.new
    possible_columns.each do |consec_column_label|
      (1..@board.board_size).each do |row_label|
        possible_column_coordinates  << consec_column_label.map do |column_num|
          (row_label + 64).chr + column_num.to_s
        end
      end
    end
    possible_column_coordinates
  end

  def generate_random_possible_ship_placement(ship)
    possible_ship_placement = generate_ship_coordinate_placement_horizontal(ship) + generate_ship_coordinate_placement_vertical(ship)
    possible_ship_placement.sample
  end
  # (1..4).each_cons(3) do |vertical_sequence|
  #   new_array = vertical_sequence.map do |columns_label|
  #     (row_label + 64).chr
  #   end


  def place_ships
    @ships.each do |ship|
      valid = false
      until valid do
        proposed_placement = generate_random_possible_ship_placement(ship)
        if @board.valid_placement?(ship, proposed_placement)
          valid = true
          @board.place_ship_on_board(ship, proposed_placement)
        end
      end
    end
  end


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
