include "alldifferent.mzn";

par int: n;
set of int: PuzzleRange = 1..n;

array[1..n,1..n] of 0..n: start; 
array[1..n,1..n] of var PuzzleRange: puzzle;

% fill initial board
constraint forall(i,j in PuzzleRange)(
    if start[i,j] > 0 then puzzle[i,j] = start[i,j] else true endif );

% all different in rows 
constraint forall (i in PuzzleRange) (
                   alldifferent([ puzzle[i,j] | j in PuzzleRange ])::domain); 

% all different in columns
constraint forall (j in PuzzleRange) (
                   alldifferent([ puzzle[i,j] | i in PuzzleRange ])::domain); 

solve satisfy;

%solve :: int_search(puzzle, dom_w_deg, indomain_random) satisfy;

%solve::int_search(puzzle,dom_w_deg,indomain_random)::restart_luby(250)satisfy;

