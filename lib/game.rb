class Game

  def initialize
    @game_start_input = ""
  end


  def display_game_message
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    @game_start_input = gets.chomp.downcase
  end

  def interpret_user_input
    if @game_start_input.downcase == 'p'
      return Play.new()
    elsif @game_start_input.downcase == 'q'
      exit(true)
    else
      print "Sorry, it's not clear what you'd like to do, let's try this again...\n\n"
    end
  end
  #
  #
  def play

    until @game_start_input == 'p' do
      display_game_message
      interpret_user_input
    end
  end


end
