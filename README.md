# RobotMovementSimulator

- The world is modelled as a grid with size m x n, where:
  - the grid is 0 based index
  - `m` is the maximum "in bounds" value for x axis
  - `n` is the maximum "in bounds" value for y axis
  - Going from x -> x + 1 is in the easterly direction, and y -> y + 1 is in the northerly
    direction. i.e. (0, 0) represents the south-west corner of the grid
- Program reads the input, updates the robots, and print out the final states
of the robots
- Each robot has a position (x, y), and an orientation (N, E, S, W)
- Each robot can move forward one space (F), rotate left by 90 degrees (L), or rotate
right by 90 degrees (R)
- If a robot moves off the grid, it is marked as ‘lost’ and its last valid grid position and
orientation is recorded



## Input format

```text
4 8
(2, 3, E) LFRFF
(0, 2, N) FFLFRFF
```
- The first line of the input `4 8` specifies the size of the grid. 
- The subsequent lines each represent the initial state and commands for a single robot: 
  - `(0, 2, N)` specifies the initial state in the form `(x, y, orientation)`
  - `FFLFRFF` represents the sequence of movement commands for the robot.

## Output format
```text
(4, 4, E)
(0, 4, W) LOST
```
Each line represents the final position and orientation of the robots of the form 
`(x, y, orientation)` and optionally whether the robot was lost.

## Running
Build the binary by running: 
```shell
mix escript.build
```
and then run
```shell
./robot_movement_simulator << EOF                                                                                                                              1 ↵
<input>
EOF
```

You can also pass a file as an input - see some examples under `input_examples`
```shell
./robot_movement_simulator < input_examples/example_1.txt
```

### Executing tests
`mix test`

## Further improvements
- Define enums with https://hexdocs.pm/enum_type/readme.html 
  for orientation and commands
- Run dialyzer - https://www.erlang.org/doc/man/dialyzer.html - to check correct
  types (and fix whatever is needed for a successful run)

