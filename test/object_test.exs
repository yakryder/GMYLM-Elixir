defmodule Gmylm.World.ObjectTest do
  @moduledoc """
    Tests the GMYLM Object functions and data
  """
  use ExUnit.Case
  alias Gmylm.World.Object

  doctest Object

  test "it exists" do
    assert Object.__info__(:functions)
  end

  describe "%Object{}" do
    test "it has a ground description that defaults to nil" do
      assert %Object{}.ground_description == nil
    end
  end
end
