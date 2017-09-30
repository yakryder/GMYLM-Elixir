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


  describe "Interface.input_to_command_map/2" do
    test "it is a map with regex keys and tuple values", %{player: player, world: world} do
      input_to_command_map = Interface.input_to_command_map(player, world)
      assert is_map(input_to_command_map)

      itc_keys   = Map.keys(input_to_command_map)
      itc_values = Map.values(input_to_command_map) 
      
      assert Enum.all?(itc_keys, fn(key) -> Regex.regex?(key) end) == true
      assert Enum.all?(itc_values, fn(value) -> is_tuple(value) end) == true
    end  
  end  

  describe "Interface.controls/3" do
    test "it should return a tuple of module, function, and arguments for north" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("north\n", player, world) == {Player, :move, [:north, player, world]}
    end

    test "it should return a tuple of module, function, and arguments for east" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("east\n", player, world) == {Player, :move, [:east, player, world]}
    end

    test "it should return a tuple of module, function, and arguments for south" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("south\n", player, world) == {Player, :move, [:south, player, world]}
    end

    test "it should return a tuple of module, function, and arguments for west" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("west\n", player, world) == {Player, :move, [:west, player, world]}
    end

    test "it should return a tuple of module, function, and arguments for up" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("up\n", player, world) == {Player, :move, [:up, player, world]}
    end

    test "it should return a tuple of module, function, and arguments for down" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("down\n", player, world) == {Player, :move, [:down, player, world]}
    end

    test "it should return a tuple of module, function, and arguments for look" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("look\n", player, world) == {Player, :look, [player, world]}
    end

    test "it should return a tuple of module, function, and arguments for quit" do
      {world, player} = {%World{}, %Player{}}
      assert Interface.controls("quit\n", player, world) == {Gmylm, :game_loop, [player, world, "victory"]}
    end
  end
end
