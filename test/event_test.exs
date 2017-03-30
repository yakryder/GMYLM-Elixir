defmodule Gmylm.World.EventTest do
  @moduledoc """
    Tests the GMYLM Event functions and data
  """
  use ExUnit.Case, async: true
  alias Gmylm.Player
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.World.Event

  doctest Event

  setup_all do
    event_map = %{name: "Example Event", text: "Just an example event", code: nil} 
    {:ok, event_map: event_map}
  end  

  describe "intialize_events/2" do
    # Do I need player and world to output?
  end

  describe "convert_to_event/1" do
    test "it converts a map to an event", %{event_map: event_map} do
      event = event_map |> Event.convert_to_event
      assert event.__struct__ == Gmylm.World.Event
    end  
  end
end
