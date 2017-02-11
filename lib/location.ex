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
# I want to only try to remove objects if that location has objects.
# or raise the dang error
  def remove_object(%Object{} = object, %Location{} = current_location) do
    cond do
      Enum.empty?(current_location.on_ground) -> {:error, "there is nothing there"}
      Enum.member?(current_location.on_ground, object) ->
        {:ok, %Location{current_location | on_ground: List.delete(current_location.on_ground, object)}}
      true -> {:error, "there is no #{object.name} here"}
    end
  end
end
