include "gecode.mzn";
include "alldifferent.mzn";

int: n; % number of queens
array [1..n] of var 1..n: q;  % variables for queens on the rows (or columns)

% total distance objective function
var int: tot_distance = sum([abs(i-q[i])|i in 1..n]);

% constraint: all queens must be in different rows
constraint alldifferent(q)::domain;

% constraint: all queens must be in different diagonals  (right)
constraint alldifferent([q[i]+i | i in 1..n])::domain;

% constraint: all queens must be in different diagonals  (left)
constraint alldifferent([q[i]-i | i in 1..n])::domain;

% solve with default search
% solve minimize tot_distance;

% solve with dom_w_deg and random value
% solve :: int_search(q, dom_w_deg, indomain_random) minimize tot_distance;

% solve with dom_w_deg and random value + restart
 solve :: int_search(q, dom_w_deg, indomain_random)
       :: restart_luby(250) minimize tot_distance;

% solve with dom_w_deg and random value + restart + LNS
% solve :: int_search(q, dom_w_deg, indomain_random)
%      :: restart_luby(250) 
 %     :: relax_and_reconstruct(q, 85) minimize tot_distance;

output[show(tot_distance)];
