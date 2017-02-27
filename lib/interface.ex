defmodule Gmylm.Interface do
  @moduledoc """
    Interface for GMYLM.
  """
alias Gmylm.Player
alias Gmylm.World.Location
alias Gmylm.Interface

  def controls(input, %Player{} = player, [%Location{}|_] = world) do
    %{
       "north\n" => fn -> Player.move(:north, player, world) end,
       "east\n"  => fn -> Player.move(:east, player, world)  end,
       "south\n" => fn -> Player.move(:south, player, world) end,
       "west\n"  => fn -> Player.move(:west, player, world)  end,
       "look\n"  => fn -> Player.look(player, world) end,
     } |> Map.get(input)
  end

  def render_output({_look_status, description, player, world}) do
    IO.puts description
    {:ok, player, world}
  end

  def render_output({_move_status, player, world}) do
    Interface.render_output(Player.look(player, world))
    {:ok, player, world}
  end





end
