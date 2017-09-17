defmodule Gmylm.WorldTest do
  @moduledoc """
    Tests the World module
  """
  use ExUnit.Case, async: true
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Event
  alias Gmylm.Player
  alias Gmylm.Helper

  doctest World

  test "it has a Location module" do
    assert World.Location.__info__(:functions)
  end

  test "it has an Object module" do
    assert World.Object.__info__(:functions)
  end

  describe "initialize_world/0" do
    test "it returns a world struct with a full list of locations, objects, and events" do
      world = World.initialize_world
      assert world.locations |> Helper.all_elements_are?(Gmylm.World.Location)
      assert world.objects   |> Helper.all_elements_are?(Gmylm.World.Object)
      assert world.events    |> Helper.all_elements_are?(Gmylm.World.Event)
    end
  end

end
