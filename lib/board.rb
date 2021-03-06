 class Board
   attr_reader :cells , :width, :length
   def initialize(width = 4)

    @width = width
    @length = width
    @cells = generate_board
   end

   def board_rows
     ("A"..(@length + 64).chr).to_a
   end

   def board_columns
     (1..@width).to_a
   end

   def gen_coord(letter, number)
     letter + number.to_s
   end

   def ordered_coords
     board_coords = []
     board_rows.each do |letter|
       board_columns.each do |number|
         board_coords << gen_coord(letter, number)
       end
     end
     board_coords
   end

   def generate_board
     cells = Hash.new()
     ordered_coords.each do |coord|
       cells[coord] = Cell.new(coord)
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

   def display_column_headers
     first_row = "  "
     board_columns.each do |column|
       first_row += "#{column} "
     end
     first_row += "\n"
     first_row
   end

   def display_row_header(counter)
     board_rows[counter == 0 ? 0 : counter / @width] + " "
   end


   def render(bool = false)
     counter = 0
     display = display_column_headers
     ordered_coords.each do |coord|
       display += display_row_header(counter) if counter % @width == 0
       counter += 1
       display += "#{@cells[coord].render(bool)} "
       display += "\n" if counter % @width == 0
     end
     display
   end

   def place_ship_on_board(ship, ship_position)
     ship_position.each do |coord|
       @cells[coord].place_ship(ship)
     end
   end

   def fire_upon(coord)
     @cells[coord].fire_upon
   end

   def untargeted_cells
     untargeted_coords = []
     @cells.each do |coord, cell|
       untargeted_coords << coord if @cells[coord].fired_upon == false
     end
     untargeted_coords
   end

   def already_shot?(coord)
     @cells[coord].fired_upon?
   end

   def shot_impact(coord)
     @cells[coord].impact
   end

 end
