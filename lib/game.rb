require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/user'
require './lib/computer'

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


    computer = Computer.new
    user     = User.new
    # will initialize with ships and board, need to call computer atrribute in the
    # compter method. Cannot call from game class.
    valid = false
    until valid == true do
      ship_1 = computer.ship_1
      ship_1_placement = computer.generate_random_coordinate(computer.ship_1)


      if computer.board.valid_placement?(ship_1, ship_1_placement)
        valid = true
        computer.place_ship(ship_1, ship_1_placement)
      end
    end

    valid = false
    until valid == true do
      ship_2 = computer.ship_2
      ship_2_placement = computer.generate_random_coordinate(computer.ship_2)

      if computer.board.valid_placement?(ship_2, ship_2_placement)
        valid = true
        computer.place_ship(ship_2, ship_2_placement)
      end
    end
    print "I have laid out my ships on the grid.\n"
    print "You now need to layout your two ships.\n"
    print "The cruiser is three units long and the submarine is two units long.\n"
    user.board.render


    valid = false
    until valid == true do
      print "Enter the squares for the #{user.ship_1.name}(#{user.ship_1.length} spaces):"
      user_input = gets.chomp
      if user.board.valid_placement?(user.ship_1, user_input)
        valid = true
        user.place_ship(ship_1, user_input)
      else
        print "Those are invalid coordinates. Please try again:\n"
        user.board.render
      end
    end

    user.board.render
    valid = false
    until valid == true do
      print "Enter the squares for the #{user.ship_2.name}(#{user.ship_2.length} spaces):"
      user_input = gets.chomp
      if user.board.valid_placement?(user.ship_2, user_input)
        valid = true
        user.place_ship(ship_2, user_input)
      else
        print "Those are invalid coordinates. Please try again:\n"
        user.board.render
      end
    end

    until (user.ship_1.sunk? && user.ship_2.sunk?) || (computer.ship_1.sunk? && computer.ship_2.sunk?)
      display_game_boards
      user_shot
      computer_shot
    end
  end_game
  end

  def end_game
    if (user.ship_1.sunk? && user.ship_2.sunk?)
      print "I Won!\n"
    else
      print "You won!\n"
    end
    main_menu
  end

  def computer_shot
    avail_cells = user.board.select {|cell| cell.fired_upon == false}
    computer.fire_upon(avail_cells.sample)
  end

  def user_shot
    valid = false
    print "Enter the coordinate for your shot:"
    until valid == true do
      user_input = gets.chomp
      if computer.board.validate_coordinate?(user_input)
        valid = true
        user.fire_upon(user_input)
      else
        computer.board.render
        print "Please enter a valid coordinate:\n"
      end
    end
  end

  def display_game_boards
    print "=================COMPUTER BOARD=================\n"
    computer.board.render
    print "==================PLAYER BOARD=================\n"
    user.board.render(true)
  end

end
