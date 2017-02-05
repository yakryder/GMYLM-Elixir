defmodule Gmylm.World.LocationTest do
  @moduledoc """
    Tests the GMYLM location functions and data
  """
  use ExUnit.Case

  alias Gmylm.World.Location
  alias Gmylm.World.Object

  doctest Location

  test "it exists" do
    assert Location.__info__(:functions)
  end

  test "it has an associated Struct" do
    assert %Location{}
  end

  test "it has an on ground attribute that defaults to an empty List" do
    location = %Location{}
    assert location.on_ground == []
  end

  describe "Location.add_object/2" do
    test "it exists" do
      assert_raise FunctionClauseError, fn -> Location.add_object("I am", "defined") end
    end

    test "it adds the specified object to the specified location" do
      balloon          = %Object{ground_description: "A deflated balloon rests here, looking sad and unloved."}
      location         = %Location{}
      updated_location = Location.add_object(balloon, location)
      assert List.first(updated_location.on_ground) == balloon
    end
  end
end
