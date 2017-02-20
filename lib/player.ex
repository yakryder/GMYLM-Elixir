defmodule Gmylm.Player do
  @moduledoc """
  Player data structure and Player functions
  """
  alias Gmylm.Player
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  defstruct location: %Location{description: "Hankin is my school.  The school is a pretty cool building.  Made of brick and really old with designs in the stone parts.  I like the carvings of gears, and the one of the people dancing.  There are lots of kids out in front of the school right now because the bell just rang.",
  down: nil, east: "Hankin School Playground",
  name: "Hankin Elementary School", north: nil,
  on_ground: ["Carvings of People Dancing",
   "Spoiled Milk", "Balloon"], south: nil, up: nil,
  west: "The Park"}, inventory: []

  @doc """
  Initializes a player.
  """
  @spec initialize_player :: %Player{}

  def initialize_player do
    %Player{}
  end

  @doc """
  Moves the player in the specified direction.
  """
  @spec move(atom, %Player{}, [%Location{}]) :: {atom, %Player{}, [%Location{}]}

  def move(direction, %Player{} = player, [%Location{}|_] = world) do
    {:ok, %Player{player | location: Enum.find(world, nil, fn(location) -> location.name == Map.get(player.location, direction) end)}, world}
  end

  @doc """
  Looks at the current location.
  """

  @spec look(%Player{}, [%Location{}]) :: {atom, String.t, %Player{}, [%Location{}]}

  def look(%Player{} = player, [%Location{}|_] = world) do
    {:ok, player.location.description, player, world}
  end

  @spec pick_up(%Player{}, %Object{}) :: {atom, %Player{}, %Object{}}

  def pick_up(%Player{} = player, %Object{} = object) do
    {:ok, %Player{player | inventory: player.inventory ++ [object]},
    Location.remove_object(object, player.location)}
  end
end
