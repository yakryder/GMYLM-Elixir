defmodule Gmylm.PlayerTest do
  @moduledoc """
    Tests the GMYLM player functions and data
  """
  use ExUnit.Case, async: true
  alias Gmylm.Player
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  doctest Player

  setup_all do
    world  = Location.initialize_locations
    poop_trap = %Object{name: "Poop Trap"}
    player = %Player{location: %Location{Enum.find(world, nil, fn(location) -> location.down end) | on_ground: [poop_trap]}}
    {:ok, player: player, world: world, poop_trap: poop_trap}
  end

  describe "%Player{}" do
    test "player has a location that defaults to Hankin Elementary School" do
      assert %Player{}.location == %Gmylm.World.Location{description: "Hankin is my school.  The school is a pretty cool building.  Made of brick and really old with designs in the stone parts.  I like the carvings of gears, and the one of the people dancing.  There are lots of kids out in front of the school right now because the bell just rang.",
  down: nil, east: "Hankin School Playground",
  name: "Hankin Elementary School", north: nil,
  on_ground: ["Carvings of People Dancing",
   "Spoiled Milk", "Balloon"], south: nil, up: nil,
  west: "The Park"}
    end

    test "player has an inventory that defaults to an empty list" do
      assert %Player{}.inventory == []
    end
  end

  describe "move/3" do
    test "player can move north when a location exists to the north", %{player: player, world: world} do
      {player_move_status, player_moved_north, _world} = Player.move(:north, player, world)
      assert player_move_status == :ok
      assert player_moved_north.location.name == "Laundry Room"
    end

    test "player can move east when a location exists to the east", %{player: player, world: world} do
      {player_move_status, player_moved_east, _world} = Player.move(:east, player, world)
      assert player_move_status == :ok
      assert player_moved_east.location.name == "Downstairs Bathroom"
    end

    test "player can move south when a location exists to the south", %{player: player, world: world} do
      {player_move_status, player_moved_south, _world} = Player.move(:south, player, world)
      assert player_move_status == :ok
      assert player_moved_south.location.name == "Foyer"
    end

    test "player can move west when a location exists to the west", %{player: player, world: world}  do
      {player_move_status, player_moved_west, _world} = Player.move(:west, player, world)
      assert player_move_status == :ok
      assert player_moved_west.location.name == "Kitchen"
    end

    test "player can move up when a location exists up", %{player: player, world: world}  do
      {player_move_status, player_moved_up, _world} = Player.move(:up, player, world)
      assert player_move_status == :ok
      assert player_moved_up.location.name == "Upstairs Hallway"
    end

    test "player can move down when a location exists down", %{player: player, world: world}  do
      {player_move_status, player_moved_down, _world} = Player.move(:down, player, world)
      assert player_move_status == :ok
      assert player_moved_down.location.name == "Basement"
    end

    test "player can move multiple times without breaking move", %{player: player, world: world}  do
      {player_move_status, player_moved_down, _world} = Player.move(:down, player, world)
      assert player_move_status == :ok
      assert player_moved_down.location.name == "Basement"
      {player_move_back_status, player_moved_back, _world} = Player.move(:up, player_moved_down, world)
      assert player_move_back_status == :ok
      assert player_moved_back.location.name == "Hallway"
    end
  end

  describe "look/2" do
    test "looking shows the description of the player's current location", %{player: player, world: world} do
      {look_status, location_description, _player, _world} = Player.look(player, world)
      assert look_status == :ok
      assert location_description == "The hallway has wooden floors...not as much fun as the kitchen floors. <br><br>Theres not too much to do here, but from here I can go upstairs to the bedrooms and stuff, or down to the basement!\\n\\nTo the east is the bathroom, to the west is the kitchen, the southern exit leads back to the foyer and the north goes to the laundry room towards the backyard."
    end

    test "it returns a player", %{player: player, world: world} do
      {_look_status, _location_description, player, _world} = Player.look(player, world)
      assert player.__struct__ == Gmylm.Player
    end

    test "it returns a world", %{player: player, world: world} do
      {_look_status, _location_description, _player, world} = Player.look(player, world)
      assert world |> Enum.all?(fn(element) -> element.__struct__ == Gmylm.World.Location end)
    end
  end

  describe "pick_up/2" do
    test "picking up an object in player's location adds it to the inventory", %{player: player, poop_trap: poop_trap} do
      {pick_up_status, player_picked_up, {_remove_object_status, _location}} = Player.pick_up(player, poop_trap)
      assert pick_up_status == :ok
      assert player_picked_up.inventory == [poop_trap]
    end

    test "it returns a player" do

    end

    test "picking up an object in player's location removes it from the ground", %{player: player, poop_trap: poop_trap}  do
      {_pick_up_status, _player, {remove_object_status, location}}  = Player.pick_up(player, poop_trap)
      assert remove_object_status == :ok
      assert location.on_ground   == []
    end
  end
end
