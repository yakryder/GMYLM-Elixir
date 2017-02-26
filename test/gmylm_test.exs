defmodule GmylmTest do
  @moduledoc """
    Tests that GMYLM has needed submodules
  """
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Gmylm.World.Location
  alias Gmylm.Player
  doctest Gmylm

  setup_all do
    world = Location.initialize_locations
    {:ok, world: world}
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
    # test "it has a prompt", %{world: world} do
    #   assert capture_io(Gmylm.game_loop(%Player{}, world, true)) =~ "> "
    # end
  end

  describe "all_elements_are?/2" do
    test "it returns true if all elements are instances of the passed struct name", %{world: world} do
      assert Gmylm.all_elements_are?(world, Gmylm.World.Location)
    end

    test "it returns false if not all elements are instances of the passed struct name", %{world: world} do
      broken_world = world ++ [%Player{}]
      refute Gmylm.all_elements_are?(broken_world, Gmylm.World.Location)
    end
  end


end
