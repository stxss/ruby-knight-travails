# Knight Travails


## I chose not to create a binary tree. Instead, I opted to navigate the board's indexes.

This README serves only to show some insight to specific lines of code that explain the process if it is not so clear at first.
<br>


```
    # line 52

    max_acceptable = if visited.length < 4
        proximity.select { |num| num > 3 }.min
    else
```
<br>

If "reaching" the furthest position from the starting point, for the first 3 moves, the difference of indexes is pretty significant, so if we take for example a start at [0, 0] and finish at [7, 7], the first 3 moves, the difference of indexes is basically guaranteed to be bigger than 17 (if we take the current position of a knight, the longest jump it can make is located at exactly 17 'indexes' away)
<br>

The condition for `|num| num > 3 ` is set because of the following:

Imagine the starting position of [3, 2] and target [3, 7]. From [3, 2] one can jump to [4, 0] and [4, 2]. The difference between the index of the target and these positions is 1 and 5. But if the knight jumps to [4, 0], which has a smaller difference, it will be actually further away from the target, because the board overlaps. So for that not to happen, a minimum of 2 indexes between the positions is required.
<br>
<br>

```
    # line 55
    proximity.select { |num| num <= 17 && num > 6 || num == 2 }.max

```

Here, when the knight already made at least 3 jumps, it is guaranteed to be in the vicinity of the target square. when we take into consideration all the possible jumps a knight can make, they are located at exactly these differences between the position of a knight and its available jumping positions (in absolute values):

- 17, 15, 10, 6

So the minimal difference is 6 and max is 17. Or in corner cases where a knight has to jump to a spot 2 indexes away from the target, it has to choose that place, otherwise an infinite loop of jumps is generated, so for example when the target is [7,7] and the knight is currently at [6, 3], it has to jump to [7,5] to jump from there to [5,6] to finally reach the target.
