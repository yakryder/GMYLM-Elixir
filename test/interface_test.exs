defmodule Gmylm.InterfaceTest do
  @moduledoc """
    Tests the interface for Gmylm
  """
  use ExUnit.Case, async: true
  doctest Gmylm.Interface
  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.Interface

  setup_all do
    world     = World.initialize_world
    poop_trap = %Object{name: "Poop Trap"}
    player    = %Player{location: %Location{Enum.find(world.locations, nil, fn(location) -> location.down end) | on_ground: [poop_trap]}}
    {:ok, player: player, world: world, poop_trap: poop_trap}
  end

  test "it exists" do
    assert Gmylm.Interface.__info__(:functions)
  end

  test "it has a game loop" do

  end

  describe "Interface.controls/3" do
    test "it should return a tuple of module, function, and arguments for directions" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("north", player, world) == {Player, :move, [:north, player, world]}
    end  

    test "it should return a tuple of module, function, and arguments for look" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("look", player, world) == {Player, :look, [player, world]}
    end  

    test "it should return a tuple of module, function, and arguments for quit" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("quit", player, world) == {Gmylm, :game_loop, [player, world, "victory"]}
    end  

    # test "north moves player north", %{player: player, world: world} do
    #   {player_move_status, player_moved_north, _world} = Gmylm.process_command("north", player, world)
    #   assert player_move_status == :ok
    #   assert player_moved_north.location.name == "Laundry Room"
    # end

    # test "east moves player east", %{player: player, world: world} do
    #   {player_move_status, player_moved_east, _world} = Gmylm.process_command("east", player, world)
    #   assert player_move_status == :ok
    #   assert player_moved_east.location.name == "Downstairs Bathroom"
    # end

    # test "west moves player west", %{player: player, world: world} do
    #   {player_move_status, player_moved_west, _world} = Gmylm.process_command("west", player, world)
    #   assert player_move_status == :ok
    #   assert player_moved_west.location.name == "Kitchen"
    # end

    # test "south moves player south", %{player: player, world: world} do
    #   {player_move_status, player_moved_west, _world} = Gmylm.process_command("south", player, world)
    #   assert player_move_status == :ok
    #   assert player_moved_west.location.name == "Foyer"
    # end

    # test "up moves player up", %{player: player, world: world}  do
    #   {player_move_status, player_moved_up, _world} = Gmylm.process_command("up", player, world)
    #   assert player_move_status == :ok
    #   assert player_moved_up.location.name == "Upstairs Hallway"
    # end

    # test "down moves player down", %{player: player, world: world}  do
    #   {player_move_status, player_moved_down, _world} = Gmylm.process_command("down", player, world)
    #   assert player_move_status == :ok
    #   assert player_moved_down.location.name == "Basement"
    # end
  end 
end
