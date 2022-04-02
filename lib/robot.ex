defmodule Robot do
  @moduledoc false

  @type orientation :: char()

  @type t :: %Robot{x: integer, y: integer, orientation: orientation}

  @enforce_keys [:x, :y, :orientation]
  defstruct [:x, :y, :orientation]

end
