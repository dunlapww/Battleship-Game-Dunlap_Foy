class Game
  attr_accessor :game_start_input

  def initialize
    @game_start_input = ""
  end


  def display_game_message
    "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n"
  end

  def get_user_input
    @game_start_input = gets.chomp.downcase
  end

  def interpret_user_input
    if @game_start_input.downcase == 'p'
      return ""
    elsif @game_start_input.downcase == 'q'
      # exit will take user back to terminal.
      exit(true)
    else
      return "Sorry, it's not clear what you'd like to do, let's try this again...\n\n"
    end
  end
  #
  #
  def play

    until @game_start_input == 'p' do
      print display_game_message
      get_user_input
      print interpret_user_input
    end
  end

# arguments requierd?
  computer = Computer.new
  user     = User.new
  # will initialize with ships and board, need to call computer atrribute in the
  # compter method. Cannot call from game class.
  valid = false
  until valid == true do
    ship_1 = computer.ship_1
    ship_1_placement = computer.generate_random_coordinate(computer.ship_1)


    if valid_placement?(ship_1, ship_1_placement)
      valid = true
      computer.place_ship(ship_1, ship_1_placement)
    end
  end

  valid = false
  until valid == true do
    ship_2 = computer.ship_2
    ship_2_placement = computer.generate_random_coordinate(computer.ship_2)

    if valid_placement?(ship_2, ship_2_placement)
      valid = true
      computer.place_ship(ship_2, ship_2_placement)
    end
  end
  print "I have laid out my ships on the grid.\n"
  print "You now need to layout your two ships.\n"
  print "The cruiser is three units long and the submarine is two units long.\n"
  user.board.render
  print "Enter the squares for the cruiser(three spaces):"
  user_input = gets.chomp

  valid = false
  until valid == true do

  end
  end

end
