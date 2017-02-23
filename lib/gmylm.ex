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
    {:ok, Player.initialize_player, World.initialize_world}
  end

  def process_command(input, %Player{} = player, [%Location{}|_]= world) do
    Gmylm.Interface.controls
  end

  def game_loop(%Player{} = player, [%Location{}|_] = world, victory \\ nil) do
    cond do
      victory == nil ->
      input = IO.gets "> "
      process_command(input, player, world)
      game_loop(player, world, victory)
      true ->
      "You win!"
    end
  end

  def start_game do
    { _status, player, world } = Gmylm.initialize_game
    game_loop(player, world)
  end

  def console(%Player{} = player, [%Location{}|_] = world) do

  end
end
