defmodule GmylmTest do
  @moduledoc """
    Tests that GMYLM has needed submodules
  """
  use ExUnit.Case, async: true
  doctest Gmylm

  test "it exists" do
    assert Gmylm.__info__(:functions)
  end

  test "it has a world" do
    assert Gmylm.World.__info__(:functions)
  end

  test "it has a player" do
    assert Gmylm.Player.__info__(:functions)
  end
end
