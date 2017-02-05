defmodule Gmylm.World.Location do
  @moduledoc """
  Location data structure and Location functions
  """
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  @doc """
  Struct for Locations.
  """
  defstruct name: nil, description: nil, on_ground: [], north: nil, east: nil, south: nil, west: nil, up: nil, down: nil

  @doc """
  Adds an object to a location.
  """

  def add_object(%Object{} = object, %Location{} = current_location) do
    %Location{current_location | on_ground: current_location.on_ground ++ [object]}
  end

  @doc """
  Removes an object from a location.
  """

  def remove_object(%Object{} = object, %Location{} = current_location) do
    %Location{current_location | on_ground: List.delete(current_location.on_ground, object)}
  end
end
