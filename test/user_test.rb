

def test_generate_ships
  computer = Computer.new
  assert_equal 2, computer.ships.size
  computer.ships.each do |ship|
    assert_instance_of Ship, ship
  end
  expected = ["cruiser", "submarine"]
  actual   = computer.ships.map do |ship|
    ship.name
  end.sort
  assert_equal  expected , actual
end
