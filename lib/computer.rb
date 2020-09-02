
class Computer
  attr_reader :ships, :board

  def initialize(width = 4)
    @ships = generate_ships
    @board  = Board.new(width)
  end

  def generate_ships
    ships = []
    ships << Ship.new("cruiser", 3)
    ships << Ship.new("submarine", 2)
    ships
  end

  def generate_ship_coordinate_placement_vertical(ship)
    possible_letter_placements  = Array.new
    (1..@board.width).each_cons(ship.length) do |consec_nums|
      consec_letter_placement = consec_nums.map do |num|
        (num + 64).chr
      end
      possible_letter_placements << consec_letter_placement
      # possible_letter_placements = [["A", "B", "C"], ["B", "C", "D"]]
    end

    possible_vertical_placements = Array.new
    possible_letter_placements.each do |letter_placement|
      (1..@board.length).each do |num|
        possible_vertical_placements  << letter_placement.map do |cap_letter|
          cap_letter + num.to_s
        end
      end
    end
    possible_vertical_placements
  end

  def generate_ship_coordinate_placement_horizontal(ship)
    possible_number_placements  = Array.new
    (1..@board.length).each_cons(ship.length) do |consec_nums|
      possible_number_placements << consec_nums
    end
    # possible_number_placements = [[1, 2, 3], [2, 3, 4]]

    possible_horizontal_placements = Array.new
    possible_number_placements.each do |num_placement|
      (1..@board.width).each do |num|
        possible_horizontal_placements  << num_placement.map do |column_num|
          (num + 64).chr + column_num.to_s
        end
      end
    end
    possible_horizontal_placements
  end

  def generate_random_possible_ship_placement(ship)
    horizontal_holder = generate_ship_coordinate_placement_horizontal(ship)
    vertical_holder   = generate_ship_coordinate_placement_vertical(ship)
    possible_ship_placement = horizontal_holder + vertical_holder
    possible_ship_placement.sample
  end


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

  def display_board(bool = false)
    @board.render(bool)
  end

  def is_fired_upon(coord)
    @board.fire_upon(coord)
  end

  def valid_coordinate?(coord)
    @board.validate_coordinate?(coord)
  end

  def already_shot_at?(coord)
    @board.already_shot?(coord)
  end
end
