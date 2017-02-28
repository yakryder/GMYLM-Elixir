defmodule Gmylm.HelperTest do
  @moduledoc """
  For testing helper methods used by app
  """
  use ExUnit.Case, async: true
  alias Gmylm.Helper
  alias Gmylm.Player
  alias Gmylm.World.Location

  doctest Helper

  setup_all do
    world = Location.initialize_locations
    {:ok, world: world}
  end

  describe "all_elements_are?/2" do
    test "it returns true if all elements are instances of the passed struct name", %{world: world} do
      assert Gmylm.Helper.all_elements_are?(world, Gmylm.World.Location)
    end

    test "it returns false if not all elements are instances of the passed struct name", %{world: world} do
      broken_world = world ++ [%Player{}]
      refute Gmylm.Helper.all_elements_are?(broken_world, Gmylm.World.Location)
    end
  end

  describe "get_exits/1" do
    test "it returns only the exits from a %Location{}", %{world: world} do
      [location|_]    = world
      {status, exits} = Helper.get_exits(location)
      assert status == :ok
      assert exits  == [down: nil, east: nil, north: nil, south: "Laundry Room",
                        up: "Up in my favorite tree", west: nil]
    end
  end
end
