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
    { _status, _player, world} = game
    %World{locations: locations, objects: objects, events: events} = world
    {:ok, game: game, locations: locations, objects: objects, events: events, world: world}
  end


  # Problem Description:
  # Game loop function is recursive
  # Need to be able to pass instructions from within game loop but my test code can't get there
  
  # One solution:
  # Pass a list of instructions to one definition of game_loop/3
  # When game_loop/3 receives a list of instructions, invoke the instruction then call itself with the invoked instruction removed
  # Maybe pass a list of tuples where first element is instruction and second is assertions

  describe "Acceptance Test" do
    # test "it plays through the game" do
    #    {_, player, world} = Gmylm.initialize_game
    #    Gmylm.game_loop(player, world)

    # end  
  end  

  # test "it exists" do
  #   assert Gmylm.__info__(:functions)
  # end

  # test "it has a World module" do
  #   assert Gmylm.World.__info__(:functions)
  # end

  # test "it has a Player module" do
  #   assert Gmylm.Player.__info__(:functions)
  # end

  # describe "game_loop/2" do
  #   test "it has a prompt", %{game: game, world: world} do
  #     assert capture_io(Gmylm.game_loop(%Player{}, world)) =~ "> "
  #     Gmylm.game_loop(%Player{}, world, "victory")
  #   end
  # end

    
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
