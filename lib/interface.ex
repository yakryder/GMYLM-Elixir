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
     } |> Map.get(input, {__MODULE__, :invalid_command, []})
  end

  def input_to_command_map(%Player{} = player, %World{} = world) do
    %{
      ~r/north/         => {Player, :move, [:north, player, world]},
      ~r/east/          => {Player, :move, [:east, player, world]},
      ~r/south/         => {Player, :move, [:south, player, world]},
      ~r/west/          => {Player, :move, [:west, player, world]},
      ~r/up/            => {Player, :move, [:up, player, world]},
      ~r/down/          => {Player, :move, [:down, player, world]},
      ~r/look/          => {Player, :look, [player, world]},
      ~r/look \w+/      => {Player, :look, [player, world]},
      ~r/quit/          => {Gmylm, :game_loop, [player, world, "victory"]},
    }
  end  

  # maybe?
  def invalid_command do
    {:error, "That's not something you can do"}
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
