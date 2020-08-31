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
        proposed_placement = gets.chomp
        if @board.valid_placement?(ship, proposed_placement)
          valid = true
          @board.place_ship_on_board(ship, proposed_placement)
        else
          print "Those are invalid coordinates. Please try again:\n"
          # true -> display the board AND display "S"'s
          @board.render(true)
        end
      end
    end
  end
end
