defmodule Gmylm.Player do
  @moduledoc """
  Player data structure and Player functions
  """
  alias Gmylm.Player
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  defstruct location: "Hankin Elementary School", inventory: []

  @doc """
  Initializes a player.

  Examples:
    iex> Player.initialize_player
    %Player{location: "Hankin Elementary School", inventory: []}
  """
  @spec initialize_player :: %Player{}

  def initialize_player do
    %Player{}
  end

  @spec move(%Player{}, list) :: %Player{}

  def move(%Player{} = player, "north") do
    %Player{player | location: player.location.north}
  end

  def move(%Player{} = player, "east") do
    %Player{player | location: player.location.east}
  end

  def move(%Player{} = player, "west") do
    %Player{player | location: player.location.west}
  end

  def move(%Player{} = player, "south") do
    %Player{player | location: player.location.south}
  end

  @spec pick_up(%Player{}, %Object{}) :: {atom, %Player{}, %Object{}}

  def pick_up(%Player{} = player, %Object{} = object) do
    {:ok, %Player{player | inventory: player.inventory ++ [object]},
    Location.remove_object(object, player.location)}
  end
end
