defmodule Gmylm do
  @moduledoc """
  Documentation for GMYLM.
  """

  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Object
  alias Gmylm.Interface

  def initialize_game do
    {:ok, Player.initialize_player, Location.initialize_locations}
  end

  def process_command(input, %Player{} = player, [%Location{}|_]= world) do
    # IO.puts "DEBUG: Input was #{input}"
    Gmylm.Interface.controls(input, player, world).()
  end

  def game_loop(%Player{} = player, [%Location{}|_] = world, victory \\ nil) do
    cond do
      victory == nil ->
      input = IO.gets "> "
      {_, new_player, new_world} = process_command(input, player, world) |>
      Interface.render_output
      game_loop(new_player, new_world, victory)
      true ->
      "You win!"
    end
  end

  def start_game do
    {_status, player, world} = Gmylm.initialize_game
    game_loop(player, world, nil)
  end

  def console(%Player{} = player, [%Location{}|_] = world) do

  end
end
