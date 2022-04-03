defmodule RobotWorld do
  @moduledoc false

  @type t :: %RobotWorld{width: integer, height: integer, robot: Robot.t() | nil}

  @enforce_keys [:width, :height]
  defstruct [:width, :height, robot: nil]

  @spec create(integer, integer) :: RobotWorld.t()
  def create(w, h), do: %RobotWorld{width: w + 1, height: h + 1}

  @doc """
  Adds a robot to the world. If the robot initial coordinates are outside of the
  world dimensions (0-based index) then it will be added as lost
  """
  @spec place_robot(RobotWorld.t(), Robot.t()) :: RobotWorld.t()
  def place_robot(world, %Robot{x: x, y: y} = robot)
      when x < 0 or x >= world.width or (y < 0 or y >= world.height) do
    %{world | robot: %{robot | lost: true}}
  end

  def place_robot(world, robot) do
    %{world | robot: robot}
  end

  @doc """
  Moves the Robot
  """
  @spec move_robot(RobotWorld.t(), Robot.command()) :: RobotWorld.t()
  def move_robot(world, ?F) do
    %{world | robot: world.robot |> Robot.forward(world)}
  end

  def move_robot(world, ?L) do
    %{world | robot: world.robot |> Robot.turn_left()}
  end

  def move_robot(world, ?R) do
    %{world | robot: world.robot |> Robot.turn_right()}
  end

  def as_output(world) do
    "(#{world.robot.x}, #{world.robot.y}, #{List.to_string([world.robot.orientation])})#{unless world.robot.lost, do: "", else: " LOST"}"
  end
end
