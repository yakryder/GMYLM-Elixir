defmodule Gmylm.World do
  @moduledoc """
  World data structure and World functions
  """

  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.World.Event

  # Player initializes to the same as Gmylm.Player.initialize_player/0, but World initializes to empty.
  # They should behave the same 

  defstruct locations: [], objects: [], events: []

  def initialize_world do
    %World{
              locations: Location.initialize_locations,
              objects:   Object.initialize_objects,
              events:    Event.initialize_events
          }
  end
end
