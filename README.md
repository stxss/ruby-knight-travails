# Knight Travails


## I chose not to create a binary tree. Instead, I opted to navigate the board's indexes.

This README serves only to show some insight to specific lines of code that explain the process if it is not so clear at first.
<br>

```
  MINIMUM_JUMPS_TO_VICINITY = 3
  MIN_JUMP_SIZE = 6
  MAX_JUMP_SIZE = 17
  MIN_TO_PREVENT_OVERLAP = 3
```
In the above code, I specify 3 constants.
-   The first constant is used to represent the least number of jumps a knight has to make to enter the 'vicinity' of the target position. As demonstrated in the picture below, the vicinity ranges from c6 up to e2. Basically the inside of the black dots denote the vicinity of the knight piece.
<br>
<p align="center">
  <img src="https://github.com/stxss/ruby-knight-travails/blob/main/board_with_knight.png" alt="Knight Possibilities"/>
</p>

-   Then, the minimum jump size (counting from left to right) for a piece is of 6 squares and the maximum is 17 in either direction. If we take the above example, the shortest jump is from `[4, 3]` to `[5, 1]/[3, 5]` and the longest is from `[4, 3]` to `[2, 2]/[6, 4]`.
-   Finally, a variable used to represent the minimum distance that has to be between an edge square and a possible jump
    -   Imagine the starting position of `[3, 2]` and target `[3, 7]`. From `[3, 2]` one can jump to `[4, 0]` and `[4, 2]`. The difference between the index of the target and these positions is 1 and 5, respectively. But if the knight jumps to `[4, 0]`, which has a smaller numerical difference, it will be actually further away from the target, because the board overlaps. So for that not to happen, a minimum of 3 indexes between the positions is required.
<br>
<br>

Next creating an array to populate with the proximities (distances) of the squares that are considered valid jumps to our target square. The hash will contain the square's position as key and the proximity value as value.

```
      proximity = []
      proximity_hash = {}
```
<br>

Next up is where the "juice" of the program is contained.

```
      max_acceptable = if visited.length <= MINIMUM_JUMPS_TO_VICINITY
        proximity.select { |distance| distance > MIN_TO_PREVENT_OVERLAP }.min
      else
        proximity.select { |distance| distance <= MAX_JUMP_SIZE && distance > MIN_JUMP_SIZE || distance == 2 }.max
      end
```
<br>

If we still haven't visited enough squares, meaning if the visited array doesn't contain at least 3 squares, it means we are still too far from our target vicinity.

So if we take for example a start at `[0, 0]` and finish at `[7, 7]`, for the first 3 moves, the difference of indexes is basically guaranteed to be bigger than 17 (the longest jump from/to our target square). In that case, from the array of proximities, select the smallest proximity to our target, meaning the closest distance. This allows us to close in on the distance in the shortest amount of steps possible.
<br>

Then, if/when the knight already made at least 3 jumps, it is guaranteed to be in the vicinity of the target square. If it took less than 3 steps, it means it is already in the vicinity and by that point, the target and shortest path were picked up already.
If we are in the vicinity, and the path hasn't been picked up yet the goal is to select the biggest jump possible from the available ones. Here, selecting the biggest proximity allows us to close in on the distance better, although these words might seem counterintuitive, this happens because of the nature of the L shaped jump.

In corner cases where a knight has to jump to a spot exactly 2 indexes away from the target, it has to choose that place, otherwise an infinite loop of jumps is generated, so for example when the target square is `[7, 7]` and the knight is currently at `[6, 3]`, it has to jump to `[7, 5]` to jump from there to `[5, 6]` to finally reach the target.
