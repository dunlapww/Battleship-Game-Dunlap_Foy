 class Board
   attr_reader :cells
   def initialize()
     coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
       "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

       @cells = Hash.new()
       coordinates.each do |coordinate|
         @cells[coordinate] = Cell.new(coordinate)
       end

       @nums_letters  = []
       @given_numbers = []
       @given_letters = []
   end

   def validate_coordinate?(coordinate)
     @cells.keys.include?(coordinate)
   end

   def valid_placement?(ship, ship_position)
     breakup_ship_placement(ship_position)
     breakup_ship_placement_to_letters_and_numbers
     return false if ship_is_either_horizontal_or_vertical == false
     return false if coordinates_are_consecutive == false
     return false if placement_is_length_of_ship(ship, ship_position) == false
     true
   end

   def placement_is_length_of_ship(ship, ship_position)
     # require "pry"; binding.pry
     if ship_position.length == ship.length
       true
     else
       false
     end
   end


   def breakup_ship_placement(given_array)
     @nums_letters = given_array.map {|coord| coord.scan(/\d+|\D+/)}
   end

   def breakup_ship_placement_to_letters_and_numbers
     @nums_letters.each do |num_let|
       @given_letters << num_let[0]
       @given_numbers << num_let[1].to_i
     end
   end

   def ship_is_either_horizontal_or_vertical
     vertical = @given_letters.all? (@given_letters[0])
     horizontal = @given_numbers.all?(@given_numbers[0])
     vertical || horizontal ? true : false
   end

   def coordinates_are_consecutive
     letters_consec = (@given_letters.min..@given_letters.max).to_a == @given_letters.sort
     numbers_consec = (@given_numbers.min..@given_numbers.max).to_a == @given_numbers.sort
     letters_consec || numbers_consec ? true : false

     if letters_consec == true || numbers_consec == true
       return true
     else
       false
     end

   end
 end
