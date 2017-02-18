defmodule Gmylm.Interface do
  @moduledoc """
    Interface for GMYLM.
  """
alias Gmylm.Player

def controls do
  %{
    :north => fn -> Player.move(:north) end,
    :east  => fn -> Player.move(:east)  end,
    :south => fn -> Player.move(:south) end,
    :west  => fn -> Player.move(:west)  end,
  }
end

end
