defmodule Robot do
  @moduledoc false

  @type orientation :: char()

  @type t :: %Robot{x: integer, y: integer, orientation: orientation, lost: boolean}

  @enforce_keys [:x, :y, :orientation]
  defstruct [:x, :y, :orientation, lost: false]

end
