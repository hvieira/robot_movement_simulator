defmodule RobotMovementSimulatorTest do
  use ExUnit.Case
  doctest RobotMovementSimulator

  test "greets the world" do
    assert RobotMovementSimulator.hello() == :world
  end
end
