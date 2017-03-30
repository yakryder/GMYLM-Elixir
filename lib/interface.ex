defmodule Gmylm.Interface do
  @moduledoc """
    Interface for GMYLM.
  """
alias Gmylm.Player
alias Gmylm.World
alias Gmylm.World.Event
alias Gmylm.Interface

  # GenServer this potentially
  # ?? Optional parameter to controls to pass in module
  # defaulting to player
  # pass in module
  # More details from Ben or Mock as noun not verb
  def controls(input, %Player{} = player, %World{} = world) do
    %{
       "north\n" => fn -> Player.move(:north, player, world) end,
       "east\n"  => fn -> Player.move(:east, player, world)  end,
       "south\n" => fn -> Player.move(:south, player, world) end,
       "west\n"  => fn -> Player.move(:west, player, world)  end,
       "up\n"    => fn -> Player.move(:up, player, world)  end,
       "down\n"  => fn -> Player.move(:down, player, world)  end,
       "look\n"  => fn -> Player.look(player, world) end,
       "quit\n"  => fn -> Gmylm.game_loop(player, world, "victory") end
     } |> Map.get(input, fn() -> {:ok, "That's not something you can do", player, world} end)
  end

  def render_output({_look_status, description, player, world}) do
    IO.puts description
    {:ok, player, world}
  end

  def render_output({_move_status, player, world}) do
    Interface.render_output(Player.look(player, world))
    {:ok, player, world}
  end

  def render_event(%Event{} = event) do
    IO.puts event.text
  end

end
