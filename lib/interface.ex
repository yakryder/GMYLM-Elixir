defmodule Gmylm.Interface do
  @moduledoc """
    Interface for GMYLM.
  """
  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Event
  alias Gmylm.Interface

  def controls(input, %Player{} = player, %World{} = world) do
    %{
       "north\n"         => {Player, :move, [:north, player, world]},
       "east\n"          => {Player, :move, [:east, player, world]},
       "south\n"         => {Player, :move, [:south, player, world]},
       "west\n"          => {Player, :move, [:west, player, world]},
       "up\n"            => {Player, :move, [:up, player, world]},
       "down\n"          => {Player, :move, [:down, player, world]},
       "look\n"          => {Player, :look, [player, world]},
       "look lunchbox\n" => {Player, :look, [player, world]},
       "quit\n"          => {Gmylm, :game_loop, [player, world, "victory"]},
     } |> Map.get(input, {:error})
  end

  # There's some funk down here

  def render_output({_look_status, description, player, world}) do
    IO.puts description
    {:ok, player, world}
  end

  # THIS IS GROSS!

  def render_output({_move_status, player, world}) do
    Interface.render_output(Player.look(player, world))
    {:ok, player, world}
  end

  def render_event(%Event{} = event) do
    Enum.each(event.text, fn(event_text_section) -> IO.puts event_text_section end) 
  end
end
