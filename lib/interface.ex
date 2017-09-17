defmodule Gmylm.Interface do
  @moduledoc """
    Interface for GMYLM.
  """
  alias Gmylm.Player
  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Event
  alias Gmylm.Interface

  # GenServer this potentially
  # ?? Optional parameter to controls to pass in module
  # defaulting to player
  # pass in module
  # More details from Ben or Mock as noun not verb

  # Responsibilities
  # - receive a command
  # - returns a tuple of module, function name, and list of arguments

  # Controls should be a bare map
  # process_input/map_input_to_command/get_command_from_input should pipe that map to the Map.get
  # run_command should be a seperate function that actually executes the code altering the world state
  # bring back status codes?
  def controls(input, %Player{} = player, %World{} = world) do
    %{
       "north\n" => {Player, :move, [:north, player, world]},
       "east\n"  => {Player, :move, [:east, player, world]},
       "south\n" => {Player, :move, [:south, player, world]},
       "west\n"  => {Player, :move, [:west, player, world]},
       "up\n"    => {Player, :move, [:up, player, world]},
       "down\n"  => {Player, :move, [:down, player, world]},
       "look\n"  => {Player, :look, [player, world]},
       "quit\n"  => {Gmylm, :game_loop, [player, world, "victory"]},
     } |> Map.get(input, {__MODULE__, :invalid_command, []})
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
