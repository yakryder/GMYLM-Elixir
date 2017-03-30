defmodule Gmylm do
  @moduledoc """
  Documentation for GMYLM.
  """

  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.Interface

  @doc """
  Returns a player and a world struct in their initial state
  """

  def initialize_game do
    {:ok, Player.initialize_player, World.initialize_world}
  end

  def process_command(input, %Player{} = player, %World{} = world) do
    # IO.puts "DEBUG: Input was #{input}"
    Gmylm.Interface.controls(input, player, world).()
  end

  def game_loop(%Player{} = player, %World{} = world, victory \\ nil) do
    cond do
      # how am I gonna trigger the event?
      victory == nil ->

        # 1. display event if any
        Interface.render_event(world)
        # 2. display world
        Interface.render_output({:ok, player, world})
        # 3. display prompt and block for user input
        input = IO.gets "> "
        # 4. handle user input
        {_, new_player, new_world} = process_command(input, player, world)
        # 5. go again
        game_loop(new_player, new_world, victory)

      # input = IO.gets "> "
      # {_, new_player, new_world} = process_command(input, player, world) |>
      # Interface.render_output
      # game_loop(new_player, new_world, victory)
      true ->
      "You win!"
    end
  end

  # need to pass game loop an event to run if relevant
  # how do we know when events are to be run?
  # Certain commands run events in certain contexts?
  # Run event when player arrives at location 1st time?
  # 'Visited' flag for locations?

  def start_game do
    {_status, player, world} = Gmylm.initialize_game
    Gmylm.Interface.render_event(Enum.find(world.events, nil, fn(event) -> event.name == "Start Game" end))
    game_loop(player, world)
  end

  def console(%Player{} = player, [%Location{}|_] = world) do

  end
end
