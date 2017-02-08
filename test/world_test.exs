defmodule Gmylm.WorldTest do
  @moduledoc """
    Tests the World module
  """
  use ExUnit.Case, async: true
  alias Gmylm.World

  doctest World

  test "it has a Location module" do
    assert World.Location.__info__(:functions)
  end

  test "it has an Object module" do
    assert World.Object.__info__(:functions)
  end

end
