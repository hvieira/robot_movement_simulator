defmodule Robot do
  @moduledoc false

  @type command :: char()
  @type orientation :: char()

  @type t :: %Robot{x: integer, y: integer, orientation: orientation, lost: boolean}

  @enforce_keys [:x, :y, :orientation]
  defstruct [:x, :y, :orientation, lost: false]

  @doc """
  Moves the Robot forward according to its orientation.
  """
  @spec forward(Robot.t()) :: Robot.t()
  def forward(%Robot{lost: true} = robot), do: robot
  def forward(%Robot{y: y, orientation: ?N} = robot), do: %{robot | y: y + 1}
  def forward(%Robot{x: x, orientation: ?E} = robot), do: %{robot | x: x + 1}
  def forward(%Robot{y: y, orientation: ?S} = robot), do: %{robot | y: y - 1}
  def forward(%Robot{x: x, orientation: ?W} = robot), do: %{robot | x: x - 1}

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
