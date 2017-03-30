defmodule Gmylm.World.Event do
  @moduledoc """
  Event data structure and Event functions
  """
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.World.Player
  alias Gmylm.World.Event

  @doc """
  Struct for Events.
  """
  defstruct name: nil, text: nil, code: nil

  @doc """
  Initializes the game events as %Event{} structs.
  There are x events, and every one should be an %Event{}

  Examples:
    iex> Event.initialize_events |> Enum.count
    1

    iex> Event.initialize_events |> Gmylm.Helper.all_elements_are?(Gmylm.World.Event)
    true
  """

  @spec initialize_events :: [%Event{}]

  def initialize_events do
    "lib/data/event_data.yml"              |>
    YamlElixir.read_from_file(atoms: true) |>
    Enum.map(&convert_to_event/1)
  end

  def convert_to_event(%{} = map) do
    Map.merge(%Event{}, map)
  end

  # A singular for this would be nice -- if only for testing purposes for now -- that loads just a single Event
  def initialize_event do

  end

  # display text method
  # do I need to take in everything or not?
end
