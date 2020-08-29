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
    print "i got here"
  end


end
