defmodule Gmylm.PlayerTest do
  @moduledoc """
    Tests the GMYLM player functions and data
  """
  use ExUnit.Case, async: true
  alias Gmylm.Player

  doctest Player

  test "it exists" do
    assert Gmylm.__info__(:functions)
  end
end
