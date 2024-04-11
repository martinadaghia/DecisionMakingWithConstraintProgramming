% Global model

include "diffn.mzn";
include "cumulative.mzn";
 
int: n; 
int: w; 
int: h; 

array[1..n] of int: ws; % widths of posters
array[1..n] of int: hs; % heights of posters

% left bottom corner of each poster
array[1..n] of var 0..w-1: W;
array[1..n] of var 0..h-1: H;

% to not exceed the paper roll limit
constraint forall(i in 1..n) (W[i] + ws[i] <= w);
constraint forall(i in 1..n) (H[i] + hs[i] <= h);

% implied constraints
%constraint cumulative(W, ws, hs, h);   
%constraint cumulative(H, hs, ws, w);

% to avoid posters overlapping
constraint diffn(W, H, ws, hs);


solve satisfy;