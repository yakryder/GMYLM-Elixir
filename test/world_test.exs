defmodule Gmylm.WorldTest do
  @moduledoc """
    Tests the World module
  """
  use ExUnit.Case, async: true
  alias Gmylm.World

  doctest World

  test "it has locations" do
    assert World.Locations.__info__(:functions)
  end

end
