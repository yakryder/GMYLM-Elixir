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
  Initializes the game locations as %Location{} structs.
  There should be 22 locations, and everyone should be a %Location

  Examples:
    iex> Location.initialize_locations |> Enum.count
    22

    iex> Location.initialize_locations |> Gmylm.all_elements_are?(Gmylm.World.Location)
    true
  """

  @spec initialize_locations :: [%Location{}]

  def initialize_locations do
    "lib/location_data.yml"                |>
    YamlElixir.read_from_file(atoms: true) |>
    Enum.map(fn(location_map) -> Map.merge(%Location{}, location_map) end)
  end

  @doc """
  Adds an object to a location.
  """

  @spec add_object(%Object{}, %Location{}) :: %Location{}

  def add_object(%Object{} = object, %Location{} = current_location) do
    %Location{current_location | on_ground: current_location.on_ground ++ [object]}
  end

  @doc """
  Removes an object from a location.
  """
# I want to only try to remove objects if that location has objects.
# or raise the dang error

  @spec remove_object(%Object{}, %Location{}) :: {atom, any}

  def remove_object(%Object{} = object, %Location{} = current_location) do
    cond do
      Enum.empty?(current_location.on_ground) -> {:error, "there is nothing there"}
      Enum.member?(current_location.on_ground, object) ->
        {:ok, %Location{current_location | on_ground: List.delete(current_location.on_ground, object)}}
      true -> {:error, "there is no #{object.name} here"}
    end
  end


end
