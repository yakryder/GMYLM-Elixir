defmodule Gmylm.PlayerTest do
  @moduledoc """
    Tests the GMYLM player functions and data
  """
  use ExUnit.Case, async: true
  alias Gmylm.Player
  alias Gmylm.World.Location

  doctest Player

  setup_all do
    north_room = %Location{north: %Location{name: "Move north"}}
    east_room = %Location{east: %Location{name: "Move east"}}
    west_room = %Location{west: %Location{name: "Move west"}}
    south_room = %Location{south: %Location{name: "Move south"}}
    {:ok, north_room: north_room, east_room: east_room, west_room: west_room, south_room: south_room}
  end

  describe "%Player{}" do
    test "it has a location that defaults to nil" do
      assert %Player{}.location == nil
    end

    test "it has an inventory that defaults to an empty list" do
      assert %Player{}.inventory == []
    end
  end

  describe "move/2" do
    test "player can move north when a location exists to the north", %{north_room: north_room} do
      player             = %Player{location: north_room}
      player_moved_north = Player.move(player, 'north')
      assert player_moved_north.location == %Location{name: "Move north"}
    end

    test "player can move east when a location exists to the east", %{east_room: east_room} do
      player            = %Player{location: east_room}
      player_moved_east = Player.move(player, 'east')
      assert player_moved_east.location == %Location{name: "Move east"}
    end

    test "player can move west when a location exists to the west", %{west_room: west_room} do
      player            = %Player{location: west_room}
      player_moved_west = Player.move(player, 'west')
      assert player_moved_west.location == %Location{name: "Move west"}
    end

    test "player can move south when a location exists to the south", %{south_room: south_room} do
      player            = %Player{location: south_room}
      player_moved_south = Player.move(player, 'south')
      assert player_moved_south.location == %Location{name: "Move south"}
    end
  end
end
