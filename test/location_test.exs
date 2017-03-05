defmodule Gmylm.World.LocationTest do
  @moduledoc """
    Tests the GMYLM location functions and data
  """
  use ExUnit.Case, async: true

  alias Gmylm.World.Location
  alias Gmylm.World.Object

  doctest Location

  setup_all do
    balloon            = %Object{ground_description: "A deflated balloon rests here, looking sad and unloved."}
    spoiled_milk_bomb  = %Object{name: "Spoiled Milk Bomb"}
    dart_gun           = %Object{name: "Dart Gun"}
    cayenne_pepper     = %Object{name: "Cayenne Pepper"}
    location_w_objects = %Location{on_ground: [spoiled_milk_bomb, dart_gun, cayenne_pepper]}
    basement           = %Location{description: "The basement's not scary, okay?  Some people say it is but I say it's only scary if there's a storm and the lights are out and something is not put away where you expect it to be and it looks like a person in the shadows.  Otherwise the basement is neat.  It's full of tools and stuff.\n\nThe only way out is back up the stairs."}
    basement_w_balloon = %Location{basement | on_ground: [balloon]}
    world              = Location.initialize_locations
    hallway            = Enum.find(world, nil, fn(location) -> location.down end)
    {:ok, balloon: balloon, location_w_objects: location_w_objects, basement: basement, basement_w_balloon: basement_w_balloon,
    spoiled_milk_bomb: spoiled_milk_bomb, dart_gun: dart_gun, cayenne_pepper: cayenne_pepper, world: world, hallway: hallway}
  end

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

    test "it adds the specified object to the specified location", %{balloon: balloon} do
      location = %Location{}
      added_to_location = Location.add_object(balloon, location)
      assert List.last(added_to_location.on_ground) == balloon
    end

    test "when adding an object it preserves other objects at the specified location and puts the newest object last",
    %{location_w_objects: location_w_objects, spoiled_milk_bomb: spoiled_milk_bomb,
      dart_gun: dart_gun, cayenne_pepper: cayenne_pepper, balloon: balloon} do
      assert location_w_objects.on_ground == [spoiled_milk_bomb, dart_gun, cayenne_pepper]
      added_to_location = Location.add_object(balloon, location_w_objects)
      assert added_to_location.on_ground == [spoiled_milk_bomb, dart_gun, cayenne_pepper, balloon]
    end

    test "when adding an object it preserves the unmodified data of the specified location", %{balloon: balloon, basement: basement} do
      added_to_basement = Location.add_object(balloon, basement)
      assert List.first(added_to_basement.on_ground) == balloon
      assert added_to_basement.description == basement.description
    end
  end

  describe "Location.remove_object/2" do
    test "it removes the specified object from the specified location", %{balloon: balloon, basement_w_balloon: basement_w_balloon} do
      {status, empty_basement} = Location.remove_object(balloon, basement_w_balloon)
      assert status == :ok
      assert empty_basement.on_ground == []
    end

    test "when removing an object it preserves other objects at the specified location",
      %{location_w_objects: location_w_objects, spoiled_milk_bomb: spoiled_milk_bomb,
        dart_gun: dart_gun, cayenne_pepper: cayenne_pepper} do
        assert location_w_objects.on_ground == [spoiled_milk_bomb, dart_gun, cayenne_pepper]
        {status, removed_from_location_w_objects} = Location.remove_object(dart_gun, location_w_objects)
        assert status == :ok
        assert removed_from_location_w_objects.on_ground == [spoiled_milk_bomb, cayenne_pepper]
    end

    test "when removing an object it preserves the unmodified data of the specified location", %{balloon: balloon, basement: basement, basement_w_balloon: basement_w_balloon} do
      {status, basement_w_balloon_removed} = Location.remove_object(balloon, basement_w_balloon)
      assert status == :ok
      assert basement_w_balloon_removed.description == basement.description
    end

    test "it returns 'there is nothing there' error if the location's on_ground is empty", %{balloon: balloon, basement: basement} do
      assert Location.remove_object(balloon, basement) == {:error, "there is nothing there"}
    end

    test "it returns an error if the object isn't there", %{basement_w_balloon: basement_w_balloon, dart_gun: dart_gun} do
      assert Location.remove_object(dart_gun, basement_w_balloon) == {:error, "there is no Dart Gun here"}
    end
  end

  describe "Location.formatted_exits/1" do
    test "it returns the available exits of a location", %{hallway: hallway} do
      exits = Location.formatted_exits(hallway)
      assert exits  == ["down: Basement, ", "east: Downstairs Bathroom, ",
             "north: Laundry Room, ", "south: Foyer, ",
             "up: Upstairs Hallway, ", "west: Kitchen, "]
    end
  end
end
