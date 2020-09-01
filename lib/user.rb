class User
  attr_reader :ships, :board
  def initialize
    @ships = generate_ships
    @board = Board.new
  end

  def generate_ships
    ships = []
    ships << Ship.new("cruiser", 3)
    ships << Ship.new("submarine", 2)
    ships
  end

  def place_ships
    @ships.each do |ship|
      valid = false
      until valid do
        print "Enter the squares for the #{ship.name}(#{ship.length} spaces):"
        proposed_placement = gets.chomp.split(" ")
        if @board.valid_placement?(ship, proposed_placement)
          valid = true
          @board.place_ship_on_board(ship, proposed_placement)
          print display_board(true)
        else
          print "Those are invalid coordinates. Please try again:\n"
        end
      end
    end
  end

  def display_board(bool = false)
    @board.render(bool)
  end

  def untargeted_cells
    @board.untargeted_cells
  end

  def is_fired_upon(coord)
    @board.fired_upon(coord)
  end

  def already_shot_at?(coord)
    @board.already_shot?(coord)
  end

end
