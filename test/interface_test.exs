defmodule Gmylm.InterfaceTest do
  @moduledoc """
    Tests the interface for Gmylm
  """
  use ExUnit.Case, async: true
  doctest Gmylm

  test "it exists" do
    assert Gmylm.Interface.__info__(:functions)
  end

  test "it has a game loop" do

  end

  test "north calls Player.move" do

  end
end
