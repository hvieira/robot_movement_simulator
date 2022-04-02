defmodule RobotWorld do
  @moduledoc false

  @type t :: %RobotWorld{width: integer, height: integer, robots: [Robot.t()]}

  @enforce_keys [:width, :height]
  defstruct [:width, :height, robots: []]

end
