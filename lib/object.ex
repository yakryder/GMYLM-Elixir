defmodule Gmylm.World.Object do
  @moduledoc """
  Object data structure and Object functions
  """

  @doc """
  Struct for Objects.
  """
  defstruct name: nil, ground_description: nil

  @doc """
  Initializes the game objects as %Object{} structs.
  There is some number of objects, and everyone should be an %Object

  Examples:
    iex> Location.initialize_objects |> Enum.count |> is_integer
    true

    iex> Location.initialize_objects |> Enum.all?(fn(element) -> element.__struct__ == Gmylm.World.Object end )
    true
  """

  @spec initialize_objects :: [%Object{}]

  def initialize_locations do
    "lib/object_data.yml"     |>
    YamlElixir.read_from_file |>
    Enum.map(fn(object_map) -> Map.merge(%Object{}, object_map) end)
  end
end
