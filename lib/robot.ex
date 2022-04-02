defmodule Robot do
  @moduledoc false

  @type command :: char()
  @type orientation :: char()

  @type t :: %Robot{x: integer, y: integer, orientation: orientation, lost: boolean}

  @enforce_keys [:x, :y, :orientation]
  defstruct [:x, :y, :orientation, lost: false]

  @doc """
  Moves the Robot forward according to its orientation.
  If the Robot moves outside the given world, then it is deemed lost and its coordinates are not updated
  """
  @spec forward(Robot.t(), RobotWorld.t()) :: Robot.t()
  def forward(%Robot{lost: true} = robot, _world), do: robot

  def forward(%Robot{y: y, orientation: ?N} = robot, %RobotWorld{height: h})
      when y == h - 1,
      do: %{robot | lost: true}

  def forward(%Robot{y: 0, orientation: ?S} = robot, _world),
    do: %{robot | lost: true}

  def forward(%Robot{x: x, orientation: ?E} = robot, %RobotWorld{width: w})
      when x == w - 1,
      do: %{robot | lost: true}

  def forward(%Robot{x: 0, orientation: ?W} = robot, _world),
    do: %{robot | lost: true}

  def forward(%Robot{y: y, orientation: ?N} = robot, _world), do: %{robot | y: y + 1}
  def forward(%Robot{x: x, orientation: ?E} = robot, _world), do: %{robot | x: x + 1}
  def forward(%Robot{y: y, orientation: ?S} = robot, _world), do: %{robot | y: y - 1}
  def forward(%Robot{x: x, orientation: ?W} = robot, _world), do: %{robot | x: x - 1}

  @doc """
  Changes the Robot orientation to the left.
  """
  @spec turn_left(Robot.t()) :: Robot.t()
  def turn_left(%Robot{lost: true} = robot), do: robot
  def turn_left(%Robot{orientation: ?N} = robot), do: %{robot | orientation: ?W}
  def turn_left(%Robot{orientation: ?W} = robot), do: %{robot | orientation: ?S}
  def turn_left(%Robot{orientation: ?S} = robot), do: %{robot | orientation: ?E}
  def turn_left(%Robot{orientation: ?E} = robot), do: %{robot | orientation: ?N}

  @doc """
  Changes the Robot orientation to the right.
  """
  @spec turn_right(Robot.t()) :: Robot.t()
  def turn_right(%Robot{lost: true} = robot), do: robot
  def turn_right(%Robot{orientation: ?N} = robot), do: %{robot | orientation: ?E}
  def turn_right(%Robot{orientation: ?E} = robot), do: %{robot | orientation: ?S}
  def turn_right(%Robot{orientation: ?S} = robot), do: %{robot | orientation: ?W}
  def turn_right(%Robot{orientation: ?W} = robot), do: %{robot | orientation: ?N}
end
