defmodule RobotMovementSimulator.CLI do
  def main(_args \\ []) do
    final_states = execute(:stdio)

    final_states
    |> Enum.each(fn s -> IO.puts(s) end)
  end

  def execute(input_device) do
    raw_world_input = IO.read(input_device, :line)

    world =
      raw_world_input
      |> world_from_raw_input()

    robot_and_commands = read_robot_input(input_device, [])

    robot_and_commands
    |> Enum.map(fn rc ->
      world_with_robot =
        world
        |> RobotWorld.place_robot(rc["robot"])

      final =
        rc["commands"]
        |> String.to_charlist()
        |> Enum.reduce(world_with_robot, fn c, w -> RobotWorld.move_robot(w, c) end)

      RobotWorld.as_output(final)
    end)
  end

  defp world_from_raw_input(raw_input) do
    [w, h] =
      raw_input
      |> String.trim()
      |> String.split()

    RobotWorld.create(String.to_integer(w), String.to_integer(h))
  end

  defp read_robot_input(input_device, acc) do
    case IO.read(input_device, :line) do
      :eof ->
        acc

      data ->
        read_robot_input(
          input_device,
          acc |> Enum.concat([robot_instructions(data |> String.trim())])
        )
    end
  end

  @robot_instructions_regex ~r/\((?<init>.*)\) (?<commands>[LRF]+)/
  defp robot_instructions(raw_instructions) do
    raw_instructions_map =
      @robot_instructions_regex
      |> Regex.named_captures(raw_instructions)

    robot = init_robot_from_instructions(raw_instructions_map["init"])
    commands = raw_instructions_map["commands"]

    %{"robot" => robot, "commands" => commands}
  end

  defp init_robot_from_instructions(instructions) do
    [x, y, o] =
      instructions
      |> String.replace(",", "")
      |> String.split()

    [orientation] = o |> String.to_charlist()

    %Robot{x: String.to_integer(x), y: String.to_integer(y), orientation: orientation}
  end
end
