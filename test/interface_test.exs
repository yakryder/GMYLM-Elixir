defmodule Gmylm.InterfaceTest do
  @moduledoc """
    Tests the interface for Gmylm
  """
  use ExUnit.Case, async: true
  doctest Gmylm

  test "it exists" do
    assert Gmylm.Interface.__info__(:functions)
  end
end
