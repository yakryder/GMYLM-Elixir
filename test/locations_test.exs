defmodule Gmylm.LocationsTest do
  @moduledoc """
    Tests the GMYLM locations functions and data
  """
  use ExUnit.Case, async: true
  alias Gmylm.World.Locations

  doctest Locations

  test "it exists" do
    assert Gmylm.__info__(:functions)
  end
end
