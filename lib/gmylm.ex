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

  # Responsibilities
  # - receive input from user
  # - delegate to Interface.controls
  # - invoke the returned function
  def process_command(input, %Player{} = player, %World{} = world) do
    # do you want to check if valid first here?
    # IO.puts "DEBUG: Input was #{input}"
    Interface.controls(input, player, world).()

    # Maybe?
    case Interface.controls(input, player, world) do
      {:ok, {module, func_name, args}} -> Kernel.apply(module, func_name, args)
      {:error, message} -> nil # render message
    end
  end

  # Ultimately we want to invoke function that does a thing based on input
  # Ultimately we want to do this Kernel.apply thing

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