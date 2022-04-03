defmodule RobotMovementSimulator.CLITest do
  use ExUnit.Case
  doctest RobotMovementSimulator.CLI

  test "executes the program by reading the input - example 1" do
    input = """
    4 8
    (2, 3, N) FLLFR
    (1, 0, S) FFRLF
    """

    {:ok, pid} = StringIO.open(input |> String.trim())

    assert RobotMovementSimulator.CLI.execute(pid) == [
             "(2, 3, W)",
             "(1, 0, S) LOST"
           ]
  end

  test "executes the program by reading the input - example 2" do
    input = """
    4 8
    (2, 3, E) LFRFF
    (0, 2, N) FFLFRFF
    """

    {:ok, pid} = StringIO.open(input |> String.trim())

    assert RobotMovementSimulator.CLI.execute(pid) == [
             "(4, 4, E)",
             "(0, 4, W) LOST"
           ]
  end
end
