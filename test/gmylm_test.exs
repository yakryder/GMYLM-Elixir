defmodule GmylmTest do
  @moduledoc """
    Tests that GMYLM has needed submodules
  """
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Gmylm
  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Objects
  alias Gmylm.World.Event
  alias Gmylm.Interface

  setup_all do
    game = Gmylm.initialize_game
    { _status, player, world} = game
    %World{locations: locations, objects: objects, events: events} = world
    {:ok, game: game, player: player, locations: locations, objects: objects, events: events, world: world}
  end

  @tag :play_through
  describe "acceptance test" do
    test "it plays through the game" do
       {_, player, world} = Gmylm.initialize_game
       {player, world}    = Gmylm.game_loop("west\n", nil, true, player, world)
       assert player.location.name == "The Park"
       {player, world}    = Gmylm.game_loop("west\n", nil, true, player, world)
       assert player.location.name == "My Secret Stash"
       # assert capture_io(Gmylm.game_loop("look lunchbox\n", nil, true, player, world)) == "Lunchbox description"
       
    end  
  end  

  # Maybe player should be part of world (like as a player key of the world struct)

  describe "get_input_if_not_provided/1" do
    test "it returns passed input unchanged" do
      input = "north\n"
      assert input == Gmylm.get_input_if_not_provided(input) 
    end
  end  

  # Figure out a way to silence STDOUT

  describe "game_loop/5" do
    test "it updates the game state" do
      {_, player, world} = Gmylm.initialize_game
      {updated_player, updated_world} = Gmylm.game_loop("west\n", nil, true, player, world)
      assert updated_player.location.name == player.location.west
    end 
  end

  # Hey this is to mock some process command calls
  describe "process_command/3" do
    defmodule CustomAdapter do
      def process_command(input, player, world) do
        [input, player, world]
      end
    end
  end

  describe "initialize_game/0" do
    test "it returns a %Player{} and a %World{}", %{game: game} do
      {status, player, world} = game
      assert status == :ok
      assert player.__struct__ == Gmylm.Player
      assert world.__struct__  == Gmylm.World
    end
  end

  # describe "start_game/0" do
  #    test "it displays welcome text on game start", %{world: world} do
  #     output = capture_io(fn -> Gmylm.start_game end)
  #     assert output |> String.length > 500
  #   end
  # end
end
