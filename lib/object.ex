defmodule Gmylm.World.Object do
  @moduledoc """
  Object data structure and Object functions
  """
  alias Gmylm.World.Object

  @doc """
  Struct for Objects.
  """
  defstruct name: nil, ground_description: nil

  @doc """
  Initializes the game objects as %Object{} structs.
  There are 47 objects, and every one should be an %Object

  Examples:
    iex> Object.initialize_objects |> Enum.count
    47

    iex> Object.initialize_objects |> Gmylm.Helper.all_elements_are?(Gmylm.World.Object)
    true
  """

  @spec initialize_objects :: [%Object{}]

  def initialize_objects do
    "lib/data/object_data.yml"             |>
    YamlElixir.read_from_file(atoms: true) |>
    Enum.map(fn(object_map) -> Map.merge(%Object{}, object_map) end)
  end
end
