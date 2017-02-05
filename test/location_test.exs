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

  describe "%Location{}" do
    test "it has an on ground attribute that defaults to an empty List" do
      assert %Location{}.on_ground == []
    end

    test "it has a name that defaults to nil" do
      assert %Location{}.name == nil
    end

    test "it has a description that defaults to nil" do
      assert %Location{}.description == nil
    end

    test "it has a north attribute that defaults to nil" do
      assert %Location{}.north == nil
    end

    test "it has an east attribute that defaults to nil" do
      assert %Location{}.east == nil
    end

    test "it has a south attribute that defaults to nil" do
      assert %Location{}.south == nil
    end

    test "it has a west attribute that defaults to nil" do
      assert %Location{}.west == nil
    end

    test "it has an up attribute that defaults to nil" do
      assert %Location{}.up == nil
    end

    test "it has a down attribute that defaults to nil" do
      assert %Location{}.down == nil
    end
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

    test "when adding an object it preserves all the unmodified data of the specified location" do
      basement_description = "The basement's not scary, okay?  Some people say it is but I say it's only scary if there's a storm and the lights are out and something is not put away where you expect it to be and it looks like a person in the shadows.  Otherwise the basement is neat.  It's full of tools and stuff.\n\nThe only way out is back up the stairs."
      balloon              = %Object{ground_description: "A deflated balloon rests here, looking sad and unloved."}
      basement             = %Location{description: basement_description}
      updated_basement     = Location.add_object(balloon, basement)
      assert List.first(updated_basement.on_ground) == balloon
      assert updated_basement.description           == basement_description
    end
  end

  describe "Location.remove_object/2" do
    test "it removes the specified object from the specified location" do
      balloon          = %Object{ground_description: "A deflated balloon rests here, looking sad and unloved."}
      basement         = %Location{}
      updated_basement = Location.add_object(balloon, basement)
      assert List.first(updated_basement.on_ground) == balloon
      updated_basement = Location.remove_object(balloon, basement)
      assert updated_basement.on_ground == []
    end

    test "when removing an object it preserves all the unmodified data of the specified location" do
      basement_description = "The basement's not scary, okay?  Some people say it is but I say it's only scary if there's a storm and the lights are out and something is not put away where you expect it to be and it looks like a person in the shadows.  Otherwise the basement is neat.  It's full of tools and stuff.\n\nThe only way out is back up the stairs."
      balloon              = %Object{ground_description: "A deflated balloon rests here, looking sad and unloved."}
      basement             = %Location{description: basement_description}
      added_basement       = Location.add_object(balloon, basement)
      assert List.first(added_basement.on_ground) == balloon
      assert added_basement.description           == basement_description
      removed_basement     = Location.remove_object(balloon, added_basement)
      assert removed_basement.description         == basement_description
    end
  end
end
