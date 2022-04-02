defmodule RobotWorldTest do
  use ExUnit.Case
  doctest RobotWorld

  describe "Place robot" do
    test "places a robot within world in its starting state" do
      assert RobotWorld.create(1, 1)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 0, orientation: 'N'}) ==
               %RobotWorld{
                 width: 1,
                 height: 1,
                 robot: %Robot{x: 0, y: 0, orientation: 'N', lost: false}
               }

      assert RobotWorld.create(10, 10)
             |> RobotWorld.place_robot(%Robot{x: 7, y: 5, orientation: 'S'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robot: %Robot{x: 7, y: 5, orientation: 'S', lost: false}
               }

      assert RobotWorld.create(7, 10)
             |> RobotWorld.place_robot(%Robot{x: 6, y: 0, orientation: 'E'}) ==
               %RobotWorld{
                 width: 7,
                 height: 10,
                 robot: %Robot{x: 6, y: 0, orientation: 'E', lost: false}
               }

      assert RobotWorld.create(10, 7)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 6, orientation: 'W'}) ==
               %RobotWorld{
                 width: 10,
                 height: 7,
                 robot: %Robot{x: 0, y: 6, orientation: 'W', lost: false}
               }
    end

    test "robot placed outside the world are deemed lost" do
      world = RobotWorld.create(10, 10)

      assert world
             |> RobotWorld.place_robot(%Robot{x: -1, y: 0, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robot: %Robot{x: -1, y: 0, orientation: 'N', lost: true}
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 0, y: -1, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robot: %Robot{x: 0, y: -1, orientation: 'N', lost: true}
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 500, y: 0, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robot: %Robot{x: 500, y: 0, orientation: 'N', lost: true}
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 0, y: 100, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robot: %Robot{x: 0, y: 100, orientation: 'N', lost: true}
               }

      assert world
             |> RobotWorld.place_robot(%Robot{x: 10, y: 10, orientation: 'N'}) ==
               %RobotWorld{
                 width: 10,
                 height: 10,
                 robot: %Robot{x: 10, y: 10, orientation: 'N', lost: true}
               }
    end
  end

  describe "move robots forward" do
    test "move robot forward when in N orientation" do
      world_final_state =
        RobotWorld.create(3, 3)
        |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'N'})
        |> RobotWorld.move_robot('F')

      assert world_final_state == %RobotWorld{
               width: 3,
               height: 3,
               robot: %Robot{
                 x: 1,
                 y: 2,
                 orientation: 'N',
                 lost: false
               }
             }
    end

    test "move robot forward when in E orientation" do
      world_final_state =
        RobotWorld.create(3, 3)
        |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'E'})
        |> RobotWorld.move_robot('F')

      assert world_final_state == %RobotWorld{
               width: 3,
               height: 3,
               robot: %Robot{
                 x: 2,
                 y: 1,
                 orientation: 'E',
                 lost: false
               }
             }
    end

    test "move robot forward when in S orientation" do
      world_final_state =
        RobotWorld.create(3, 3)
        |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'S'})
        |> RobotWorld.move_robot('F')

      assert world_final_state == %RobotWorld{
               width: 3,
               height: 3,
               robot: %Robot{
                 x: 1,
                 y: 0,
                 orientation: 'S',
                 lost: false
               }
             }
    end

    test "move robot forward when in W orientation" do
      world_final_state =
        RobotWorld.create(3, 3)
        |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'W'})
        |> RobotWorld.move_robot('F')

      assert world_final_state == %RobotWorld{
               width: 3,
               height: 3,
               robot: %Robot{
                 x: 0,
                 y: 1,
                 orientation: 'W',
                 lost: false
               }
             }
    end

    test "moving a robot forward to outside the world means the robot is lost" do
      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 2, orientation: 'N'})
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 2,
                   orientation: 'N',
                   lost: true
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 0, orientation: 'S'})
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 0,
                   orientation: 'S',
                   lost: true
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 2, y: 1, orientation: 'E'})
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 2,
                   y: 1,
                   orientation: 'E',
                   lost: true
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 1, orientation: 'W'})
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 0,
                   y: 1,
                   orientation: 'W',
                   lost: true
                 }
               }
    end

    test "moving a lost robot forward is a no-op" do
      world_final_state =
        RobotWorld.create(3, 3)
        |> RobotWorld.place_robot(%Robot{x: 1, y: 2, orientation: 'N', lost: true})
        |> RobotWorld.move_robot('F')

      assert world_final_state == %RobotWorld{
               width: 3,
               height: 3,
               robot: %Robot{
                 x: 1,
                 y: 2,
                 orientation: 'N',
                 lost: true
               }
             }
    end
  end

  describe "change robots direction" do
    test "left changes direction counter clock-wise" do
      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'N'})
             |> RobotWorld.move_robot('L') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'W'
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'W'})
             |> RobotWorld.move_robot('L') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'S'
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'S'})
             |> RobotWorld.move_robot('L') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'E'
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'E'})
             |> RobotWorld.move_robot('L') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'N'
                 }
               }
    end

    test "right changes direction clock-wise" do
      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'N'})
             |> RobotWorld.move_robot('R') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'E'
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'E'})
             |> RobotWorld.move_robot('R') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'S'
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'S'})
             |> RobotWorld.move_robot('R') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'W'
                 }
               }

      assert RobotWorld.create(3, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 1, orientation: 'W'})
             |> RobotWorld.move_robot('R') ==
               %RobotWorld{
                 width: 3,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'N'
                 }
               }
    end
  end

  describe "examples" do
    test "example 1" do
      assert RobotWorld.create(4, 8)
             |> RobotWorld.place_robot(%Robot{x: 2, y: 3, orientation: 'N'})
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('R') ==
               %RobotWorld{
                 width: 4,
                 height: 8,
                 robot: %Robot{
                   x: 2,
                   y: 3,
                   orientation: 'W'
                 }
               }
    end

    test "example 2" do
      assert RobotWorld.create(4, 8)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 0, orientation: 'S'})
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('R')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 4,
                 height: 8,
                 robot: %Robot{
                   x: 1,
                   y: 0,
                   orientation: 'S',
                   lost: true
                 }
               }
    end

    test "example 3" do
      assert RobotWorld.create(5, 3)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 0, orientation: 'S'})
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 5,
                 height: 3,
                 robot: %Robot{
                   x: 4,
                   y: 0,
                   orientation: 'E'
                 }
               }
    end

    test "example 4" do
      assert RobotWorld.create(5, 3)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 0, orientation: 'S'})
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('R')
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 5,
                 height: 3,
                 robot: %Robot{
                   x: 1,
                   y: 1,
                   orientation: 'W'
                 }
               }
    end

    test "example 5" do
      assert RobotWorld.create(5, 3)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 0, orientation: 'N'})
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 5,
                 height: 3,
                 robot: %Robot{
                   x: 0,
                   y: 1,
                   orientation: 'W',
                   lost: true
                 }
               }
    end

    test "example 6" do
      assert RobotWorld.create(5, 3)
             |> RobotWorld.place_robot(%Robot{x: 1, y: 0, orientation: 'N'})
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('R')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             ==
               %RobotWorld{
                 width: 5,
                 height: 3,
                 robot: %Robot{
                   x: 3,
                   y: 2,
                   orientation: 'N',
                   lost: true
                 }
               }
    end

    test "example 7" do
      assert RobotWorld.create(5, 3)
             |> RobotWorld.place_robot(%Robot{x: 0, y: 0, orientation: 'S'})
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('R')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('L')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F')
             |> RobotWorld.move_robot('F') ==
               %RobotWorld{
                 width: 5,
                 height: 3,
                 robot: %Robot{
                   x: 4,
                   y: 1,
                   orientation: 'E',
                   lost: true
                 }
               }
    end
  end
end
