defmodule Gmylm.PlayerTest do
  @moduledoc """
    Tests the GMYLM player functions and data
  """
  use ExUnit.Case
  alias Gmylm.Player
  alias Gmylm.World.Location

  doctest Player

  describe "%Player{}" do
    test "it has a location that defaults to nil" do
      assert %Player{}.location == nil
    end

    test "it has an inventory that defaults to an empty list" do
      assert %Player{}.inventory == []
    end
  end

  describe "move/2" do
    # test "it has a changeable location" do
    #   player = %Player{}
    #   assert player.location == nil
    #   player.location = %Location{}
    # end

    # test "player moves north when a traversable location exists to the north" do
    #   location1 = %Location{north: %Location{north: %Location{}}}
    #   player    = %Player{location: location1}
    #   Player.move(:north)
    #   assert player.location == %{Location}
    # end
  end
end
