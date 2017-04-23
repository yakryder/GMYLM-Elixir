defmodule Gmylm do
  @moduledoc """
  Documentation for GMYLM.
  """

  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.World.Event
  alias Gmylm.Interface

  @doc """
  Returns a player and a world struct in their initial state
  """

  def initialize_game do
    {:ok, Player.initialize_player, World.initialize_world}
  end

  def process_command(input, %Player{} = player, %World{} = world) do
    # IO.puts "DEBUG: Input was #{input}"
    Interface.controls(input, player, world).()
  end

  def game_loop(%Player{} = player, %World{} = world) do
    Interface.render_output({:ok, player, world})
    input = IO.gets "> "
    {_, new_player, new_world} = process_command(input, player, world)
    game_loop(new_player, new_world)
  end

  def game_loop(%Player{} = player, %World{} = world, %Event{} = event) do
    Interface.render_event(world)
    input = IO.gets "> "
    {_, new_player, new_world} = process_command(input, player, world)
    game_loop(new_player, new_world)
  end  

  # need to pass game loop an event to run if relevant
  # how do we know when events are to be run?
  # Certain commands run events in certain contexts?
  # Run event when player arrives at location 1st time?
  # 'Visited' flag for locations?

  def start_game do
    {_status, player, world} = Gmylm.initialize_game
    Enum.find(world.events, nil, fn(event) -> event.name == "Start Game" end) |>
    Gmylm.Interface.render_event
    game_loop(player, world)
  end

  def console(%Player{} = player, %World{} = world) do

  end
end