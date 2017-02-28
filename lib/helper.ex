defmodule Gmylm.Helper do
  @moduledoc """
  Helper methods for GMYLM
  """
  alias Gmylm.World.Location


  @doc """
  Returns a boolean that indicates whether every element in the list is one of
  the indicated structs.
  """

  @spec all_elements_are?(list, struct) :: boolean

  def all_elements_are?([_head|_tail] = list, struct_name) do
    Enum.all?(list, fn(element) -> element.__struct__ == struct_name end)
  end

  @doc """
  Returns only the exit key value pairs associated to a location struct
  """

  @spec get_exits(%Location{}) :: map

  def get_exits(%Location{} = location) do
    location        |>
    Map.from_struct |>
    Enum.filter(fn {k, _} -> k == :north || k == :south || k == :west || k == :east || k == :up || k == :down end)
  end
end
