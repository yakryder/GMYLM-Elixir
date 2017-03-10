defmodule Gmylm.World do
  @moduledoc """
  World data structure and World functions
  """

  alias Gmylm.World
  alias Gmylm.World.Location
  alias Gmylm.World.Object

  defstruct locations: [], events: []

  def initialize_world do
    %World{locations: Location.initialize_locations}
  end

end
