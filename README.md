# RobotMovementSimulator

- The world is modelled as a grid with size m x n
- Program reads the input, updates the robots, and print out the final states
of the robots
- Each robot has a position (x, y), and an orientation (N, E, S, W)
- Each robot can move forward one space (F), rotate left by 90 degrees (L), or rotate
right by 90 degrees (R)
- If a robot moves off the grid, it is marked as ‘lost’ and its last valid grid position and
orientation is recorded
- Going from x -> x + 1 is in the easterly direction, and y -> y + 1 is in the northerly
direction. i.e. (0, 0) represents the south-west corner of the grid

## To be decided
- Changing a robot direction when it's lost should be a no-op? 
  For now, will consider that the robot can still change directions
- Can a robot be recovered from lost state? 
  For now, will not consider such scenarios

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
TBD

## Tests
TBD

