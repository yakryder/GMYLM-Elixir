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


  # Problem Description:
  # Game loop function is recursive
  # Need to be able to pass instructions from within game loop but my test code can't get there
  
  # One solution:
  # Pass a list of instructions to one definition of game_loop/3
  # When game_loop/3 receives a list of instructions, invoke the instruction then call itself with the invoked instruction removed
  # Maybe pass a list of tuples where first element is instruction and second is assertions

  # describe "acceptance test" do
  #   test "it plays through the game" do
  #      {_, player, world} = Gmylm.initialize_game
  #      {_, player, world} = Gmylm.game_loop(player, world)

  #   end  
  # end  

  # Maybe player should be part of world (like as a player key of the world struct)

  describe "game_loop/3" do
  #   test "it has a prompt", %{world: world} do
  #           Gmylm.game_loop(%Player{}, world, "victory")

  #     assert capture_io(Gmylm.game_loop(%Player{}, world)) =~ "> "
  #     Gmylm.game_loop(%Player{}, world, "victory")
  #   end
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
