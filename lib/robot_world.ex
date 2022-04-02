defmodule RobotWorld do
  @moduledoc false

  @type t :: %RobotWorld{width: integer, height: integer, robots: [Robot.t()]}

  @enforce_keys [:width, :height]
  defstruct [:width, :height, robots: []]

  @spec create(integer, integer) :: RobotWorld.t()
  def create(w, h), do: %RobotWorld{width: w, height: h}

  """
  Adds a robot to the world
  """
  @spec place_robot(RobotWorld.t(), Robot.t()) :: RobotWorld.t()
  def place_robot(world, robot) do
    %{world | robots: Enum.concat(world.robots, [robot])}
  end

end
