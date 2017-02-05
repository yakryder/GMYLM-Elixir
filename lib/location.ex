defmodule Gmylm.World.Location do
  @moduledoc """
  Where we store Give Me Your Lunch Money's Locations!
  """
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  @doc """
  Struct for Locations.
  """
  defstruct on_ground: []

  @doc """
  Adds an item to a location.
  """

  def add_object(%Object{} = object, %Location{} = current_location) do
    # This will make you lose all the other associated data with location
    %Location{on_ground: current_location.on_ground ++ [object]}
  end

end
