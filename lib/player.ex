defmodule Gmylm.Player do
  @moduledoc """
  Player data structure and Player functions
  """
  alias Gmylm.Player

  defstruct location: nil, inventory: []

  def move(%Player{} = player, 'north' = direction) do
    %Player{player | location: player.location.north}
  end

  def move(%Player{} = player, 'east' = direction) do
    %Player{player | location: player.location.east}
  end

  def move(%Player{} = player, 'west' = direction) do
    %Player{player | location: player.location.west}
  end

  def move(%Player{} = player, 'south' = direction) do
    %Player{player | location: player.location.south}
  end
end
