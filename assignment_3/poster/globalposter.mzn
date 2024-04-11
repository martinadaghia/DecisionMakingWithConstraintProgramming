% Global model

include "diffn.mzn";
 
int: n; % n° posters
int: w; % paper width 
int: h; % paper height

array[1..n] of int: ws; % poster width
array[1..n] of int: hs; % poster height 


% indicates the bottom left corner of each poster
array[1..n] of var 0..w-1: X;
array[1..n] of var 0..h-1: Y;
array[1..2*n] of var int: all_vars;


% to concatenate X and Y arrays
constraint forall(i in 1..n)((all_vars[2*i-1] = X[i]) /\ (all_vars[2*i] = Y[i]));

% Constraint:
% 1. Each rectangle must fit inside the paper

constraint forall(i in 1..n) (X[i] + ws[i] <= w);
constraint forall(i in 1..n) (Y[i] + hs[i] <= h);

% 2. No rectangle can overlap
constraint diffn(X, Y, ws, hs);


% Solve the problem using different variable-value ordering heuristics

% Solve with input order and min value
% solve :: int_search(all_vars, input_order, indomain_min) satisfy;

% Solve with input order and random value
 solve :: int_search(all_vars, input_order, indomain_random) satisfy;

% Solve with min domain size and min value
% solve :: int_search(all_vars, first_fail, indomain_min) satisfy;

% Solve with min domain size and random value
% solve :: int_search(all_vars, first_fail, indomain_random) satisfy;

% Solve with dom_w_deg and min value
% solve :: int_search(all_vars, dom_w_deg, indomain_min) satisfy;

% Solve with dom_w_deg and random value
% solve :: int_search(all_vars, dom_w_deg, indomain_random) satisfy;


output["x = \(X)\ny = \(Y)|nw = \(w)|nh = \(h)|n"];

