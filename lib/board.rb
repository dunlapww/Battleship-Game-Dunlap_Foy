 class Board
   attr_reader :cells
   def initialize()
    @cells = generate_board
   end

   def board_size
     4
   end

   def board_rows
     ("A"..(board_size + 64).chr).to_a
   end

   def board_columns
     (1..board_size).to_a
   end

   def gen_coord(letter, number)
     letter + number.to_s
   end

   def generate_board
     cells = Hash.new()
     board_rows.each do |letter|
       board_columns.each do |number|
         cells[gen_coord(letter, number)] = Cell.new(gen_coord(letter, number))
       end
     end
     cells
   end

   def validate_coordinate?(coordinate)
     @cells.keys.include?(coordinate)
   end

   def user_coords_are_on_board(user_coords)
     user_coords.each do |coord|
       return false if validate_coordinate?(coord) == false
     end
     true
   end

   def user_coords_are_length_of_ship(ship, user_coords)
     return false if user_coords.length != ship.length
     true
   end

   def user_letters(user_coords)
     user_coords.map {|coord| coord[0]}
   end

   def ship_is_horizontal(user_coords)
     user_letters(user_coords).all? (user_letters(user_coords)[0])
   end

   def user_numbers(user_coords)
     user_coords.map {|coord| coord.gsub(coord[0],"").to_i}
   end

   def ship_is_vertical(user_coords)
     user_numbers(user_coords).all? (user_numbers(user_coords)[0])
   end

   def ship_is_horizontal_or_vertical(user_coords)
     ship_is_vertical(user_coords) || ship_is_horizontal(user_coords) ? true : false
   end

   def user_range(set)
     (set.min..set.max).to_a
   end

   def letters_are_consec(user_coords)
     user_range(user_letters(user_coords)) == user_letters(user_coords).sort
   end

   def numbers_are_consec(user_coords)
     user_range(user_numbers(user_coords)) == user_numbers(user_coords).sort
   end

   def user_coords_are_consecutive(user_coords)
     letters_are_consec(user_coords) || numbers_are_consec(user_coords) ? true : false
   end

   def empty_coordinate?(coordinate)
     @cells[coordinate].empty?
   end

   def user_coords_are_empty(user_coords)
     user_coords.each do |coord|
       return false if empty_coordinate?(coord) == false
     end
     true
   end

   def valid_placement?(ship, user_coords)
    return false if user_coords_are_on_board(user_coords) == false
    return false if user_coords_are_length_of_ship(ship, user_coords) == false
    return false if ship_is_horizontal_or_vertical(user_coords) == false
    return false if user_coords_are_consecutive(user_coords) == false
    return false if user_coords_are_empty(user_coords) == false
    true
   end

   def display_columns
     print "  "
     board_columns.each do |column|
       print "#{column} "
     end
     print "\n"
   end

   def display_row(counter, board_size)
     board_rows[counter == 0 ? 0 : counter / board_size] + " "
   end

   def render
     counter = 0
     @cells.each do |coord, cell|
       print display_row(counter, board_size) if counter % board_size == 0
       counter += 1
       print "#{cell.render} "
       print "\n" if counter % board_size == 0
     end
   end


 end
