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
  # doctest Gmylm

  setup_all do
    game = Gmylm.initialize_game
    {:ok, game: game}
  end

  test "it exists" do
    assert Gmylm.__info__(:functions)
  end

  test "it has a World module" do
    assert Gmylm.World.__info__(:functions)
  end

  test "it has a Player module" do
    assert Gmylm.Player.__info__(:functions)
  end

  describe "game_loop/2" do
    # test "it has a prompt", %{game: game} do
    #   assert capture_io(Gmylm.game_loop(%Player{}, world, true)) =~ "> "
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
end
