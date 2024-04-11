% Global model

include "diffn.mzn";
 
int: n; % n° posters
int: w; % paper width 
int: h; % paper height

array[1..n] of int: ws; % poster width
array[1..n] of int: hs; % poster height 


% indicates the bottom left corner of each poster
array[1..n] of var 0..w-1: W;
array[1..n] of var 0..h-1: H;


% check that the piece can fit within the space still available and that it does not exceed the height or width of the reel
constraint forall(i in 1..n) (W[i] + ws[i] <= w);
constraint forall(i in 1..n) (H[i] + hs[i] <= h);


% prevents posters from overlapping each other
constraint diffn(W, H, ws, hs);


solve satisfy;

