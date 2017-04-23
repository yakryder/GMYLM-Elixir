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
  defstruct name: nil, text: nil, callback: nil, triggered: false

  # Check for event in every game loop call

  # Game Start

  # The Bullies Arrive at the park
  # Trigger: 
    # Reenter the park from My Secret Stash with fishing line in your inventory

  # Should we have another key of 'trigger_state' or similar for the Event struct?
  # That defines the criteria for triggering the event?

  # The Bullies do <SOME HORRIBLE THING>

  # The Bullies arrive at the playground for the final showdown

  # The final showdown

    #) Event1
    #) Event2
    #) Event3

  # Game victory    

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
