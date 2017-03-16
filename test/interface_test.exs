defmodule Gmylm.InterfaceTest do
  @moduledoc """
    Tests the interface for Gmylm
  """
  use ExUnit.Case, async: true
  doctest Gmylm.Interface
  alias Gmylm.Player
  alias Gmylm.World

  test "it exists" do
    assert Gmylm.Interface.__info__(:functions)
  end

  test "it has a game loop" do

  end

  test "north calls Player.move" do
    assert is_function Gmylm.Interface.controls("north\n", %Player{}, %World{})
  end
end
