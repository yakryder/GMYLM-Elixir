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
  def controls(input, %Player{} = player, %World{} = world) do
    %{
       "north" => {Player, :move, [:north, player, world]},
       "east"  => fn -> Player.move(:east, player, world)  end,
       "south" => fn -> Player.move(:south, player, world) end,
       "west"  => fn -> Player.move(:west, player, world)  end,
       "up"    => fn -> Player.move(:up, player, world)  end,
       "down"  => fn -> Player.move(:down, player, world)  end,
       "look"  => {Player, :look, [player, world]},
       "quit"  => {Gmylm, :game_loop, [player, world, "victory"]}
     } |> Map.get(input, {__MODULE__, :invalid_command, []})
  end

   #maybe?
  def invalid_command do
    "That's not something you can do"
  end

  # Example of how we might change Interface.controls/3 to make it 
  # more modularized and easier to test

  # "north\n" => {[Player, :move, [north, player, world)]}

  # Could test like this
  # assert controls("north") == {Player, :move, [north, player, world]}
  # Might work like this: {module, fun, args} = Kernel.apply(module, fun, args)


  def render_output({_look_status, description, player, world}) do
    IO.puts description
    {:ok, player, world}
  end

  def render_output({_move_status, player, world}) do
    Interface.render_output(Player.look(player, world))
    {:ok, player, world}
  end

  def render_event(%Event{} = event) do
    Enum.each(event.text, fn(event_text_section) -> IO.puts event_text_section end) 
  end
end
