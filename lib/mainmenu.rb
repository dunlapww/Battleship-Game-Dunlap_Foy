class MainMenu
attr_accessor :user_input

  def initialize
  end

  def display_game_message
    "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit.\n"
  end

  def get_user_input
    @user_input = gets.chomp
  end

  def interpret_user_input
    if @user_input.downcase == 'p'
      "play the game"
    elsif @user_input.downcase == 'q'
      exit(true)
    else
      "Sorry, it's not clear what you'd like to do, Enter p to play. Enter q to quit."
    end
  end

  def main_menu_loop
    get_user_input
    interpret_user_input
  end

end
