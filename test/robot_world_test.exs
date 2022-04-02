defmodule RobotWorldTest do
  use ExUnit.Case
  doctest RobotWorld

  describe "Place robots" do
    test "places a robot within world in its starting state" do
      assert RobotWorld.create(1, 1)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 0, orientation: 'N'}) ==
               %RobotWorld{
                 width: 1,
                 height: 1,
                 robots: [%Robot{x: 0, y: 0, orientation: 'N', lost: false}]
               }

      assert RobotWorld.create(10, 10)
             |> RobotWorld.place_robot(%Robot{x: 7, y: 5, orientation: 'S'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robots: [%Robot{x: 7, y: 5, orientation: 'S', lost: false}]
               }

      assert RobotWorld.create(7, 10)
             |> RobotWorld.place_robot(%Robot{x: 6, y: 0, orientation: 'E'}) ==
               %RobotWorld{
                 width: 7,
                 height: 10,
                 robots: [%Robot{x: 6, y: 0, orientation: 'E', lost: false}]
               }

      assert RobotWorld.create(10, 7)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 6, orientation: 'W'}) ==
               %RobotWorld{
                 width: 10,
                 height: 7,
                 robots: [%Robot{x: 0, y: 6, orientation: 'W', lost: false}]
               }
    end

    test "robots placed outside the world are deemed lost" do
      world = RobotWorld.create(10, 10)

      assert world
             |> RobotWorld.place_robot(%Robot{x: -1, y: 0, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robots: [%Robot{x: -1, y: 0, orientation: 'N', lost: true}]
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 0, y: -1, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robots: [%Robot{x: 0, y: -1, orientation: 'N', lost: true}]
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 500, y: 0, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robots: [%Robot{x: 500, y: 0, orientation: 'N', lost: true}]
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 0, y: 100, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robots: [%Robot{x: 0, y: 100, orientation: 'N', lost: true}]
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 10, y: 10, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robots: [%Robot{x: 10, y: 10, orientation: 'N', lost: true}]
               }
    end
  end
end
