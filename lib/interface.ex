defmodule Gmylm.Interface do
  @moduledoc """
    Interface for GMYLM.
  """
alias Gmylm.Player
alias Gmylm.World.Location

  def controls(%Player{} = player, [%Location{}|_] = world) do
    %{
       "north" => fn -> Player.move(:north, player, world) end,
       "east"  => fn -> Player.move(:east, player, world)  end,
       "south" => fn -> Player.move(:south, player, world) end,
       "west"  => fn -> Player.move(:west, player, world)  end,
     }
  end

  def render_output({_look_status, description, _player, _world}) do
    IO.puts description
  end



end
