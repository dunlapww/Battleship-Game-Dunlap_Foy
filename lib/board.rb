 class Board
   attr_reader :cells
   def initialize()
     coordinates = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4",
       "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

       @cells = Hash.new()
       coordinates.each do |coordinate|
         @cells[coordinate] = Cell.new(coordinate)
       end
   end

   def validate_coordinate?(coordinate)
     @cells.keys.include?(coordinate)
   end

   def valid_placement?(ship, ship_position)
     if ship_position.length == ship.length
       true
     else
       false
     end
   end

 end
