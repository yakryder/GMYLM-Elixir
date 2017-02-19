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
    spoiled_milk_bomb = %Object{ name: "Spoiled Milk Bomb" }
    dart_gun          = %Object{ name: "Dart Gun" }
    poop_trap         = %Object{ name: "Poop Trap" }
    north_room = %Location{ north: %Location{ name: "Move north" }, on_ground: [ dart_gun ] }
    east_room  = %Location{ east: %Location{ name: "Move east", on_ground: [ poop_trap ] } }
    west_room  = %Location{ west: %Location{ name: "Move west" } }
    south_room = %Location{ south: %Location{ name: "Move south" }, on_ground: [ spoiled_milk_bomb ]  }
    player = %Player{ location: south_room }
    player_in_hallway = %Player{location: Enum.find(world, nil, fn(location) -> location.down end)}
    { :ok, north_room: north_room, east_room: east_room, west_room: west_room, south_room: south_room, player_in_hallway: player_in_hallway,
     player: player, spoiled_milk_bomb: spoiled_milk_bomb, dart_gun: dart_gun, poop_trap: poop_trap, world: world }
  end

  describe "%Player{}" do
    test "player has a location that defaults to nil" do
      assert %Player{}.location == "Hankin Elementary School"
    end

    test "player has an inventory that defaults to an empty list" do
      assert %Player{}.inventory == []
    end
  end

  describe "move/3" do
    test "player can move north when a location exists to the north", %{ player_in_hallway: player_in_hallway, world: world } do
      { player_move_status, player_moved_north, _world } = Player.move(:north, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_north.location.name == "Laundry Room"
    end

    test "player can move east when a location exists to the east", %{ player_in_hallway: player_in_hallway, world: world } do
      { player_move_status, player_moved_east, _world } = Player.move(:east, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_east.location.name == "Downstairs Bathroom"
    end

    test "player can move south when a location exists to the south", %{ player_in_hallway: player_in_hallway, world: world } do
      { player_move_status, player_moved_south, _world } = Player.move(:south, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_south.location.name == "Foyer"
    end

    test "player can move west when a location exists to the west", %{ player_in_hallway: player_in_hallway, world: world }  do
      { player_move_status, player_moved_west, _world } = Player.move(:west, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_west.location.name == "Kitchen"
    end

    test "player can move up when a location exists up", %{ player_in_hallway: player_in_hallway, world: world }  do
      { player_move_status, player_moved_up, _world } = Player.move(:up, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_up.location.name == "Upstairs Hallway"
    end

    test "player can move down when a location exists down", %{ player_in_hallway: player_in_hallway, world: world }  do
      { player_move_status, player_moved_down, _world } = Player.move(:down, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_down.location.name == "Basement"
    end

    test "player can move multiple times without breaking move", %{ player_in_hallway: player_in_hallway, world: world }  do
      { player_move_status, player_moved_down, _world } = Player.move(:down, player_in_hallway, world)
      assert player_move_status == :ok
      assert player_moved_down.location.name == "Basement"
      { player_move_back_status, player_moved_back, _world } = Player.move(:up, player_moved_down, world)
      assert player_move_back_status == :ok
      assert player_moved_back.location.name == "Hallway"
    end
  end

  describe "pick_up/2" do
    test "picking up an object in player's location adds it to the inventory", %{ player: player, spoiled_milk_bomb: spoiled_milk_bomb }  do
      { pick_up_status, player_picked_up, {_remove_object_status, _location} }  = Player.pick_up(player, spoiled_milk_bomb)
      assert pick_up_status == :ok
      assert player_picked_up.inventory == [ spoiled_milk_bomb ]
    end

    test "picking up an object in player's location removes it from the ground", %{ player: player, spoiled_milk_bomb: spoiled_milk_bomb }  do
      { _pick_up_status, _player, {remove_object_status, location} }  = Player.pick_up(player, spoiled_milk_bomb)
      assert remove_object_status == :ok
      assert location.on_ground == []
    end
  end
end
