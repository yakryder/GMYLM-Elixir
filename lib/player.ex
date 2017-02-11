defmodule Gmylm.Player do
  @moduledoc """
  Player data structure and Player functions
  """
  alias Gmylm.Player
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  defstruct location: nil, inventory: []

  def move(%Player{} = player, 'north') do
    %Player{player | location: player.location.north}
  end

  def move(%Player{} = player, 'east') do
    %Player{player | location: player.location.east}
  end

  def move(%Player{} = player, 'west') do
    %Player{player | location: player.location.west}
  end

  def move(%Player{} = player, 'south') do
    %Player{player | location: player.location.south}
  end

  def pick_up(%Player{} = player, %Object{} = object) do
    {:ok, %Player{player | inventory: player.inventory ++ [object]},
    Location.remove_object(object, player.location)}
  end
end
