% Alldifferent model
include "alldifferent.mzn";

int: n; % n° of queens
array [1..n] of var 1..n: q; % variables for queens on the rows (or columns)

constraint alldifferent(q)::domain; % different rows
constraint alldifferent([ q[i]+i | i in 1..n])::domain;
constraint alldifferent([ q[i]-i | i in 1..n])::domain;

% Solve the problem using different variable-value ordering heuristics

% Solve with input order and min value
% solve :: int_search(q, input_order, indomain_min) satisfy;

% Solve with input order and random value
% solve :: int_search(q, input_order, indomain_random) satisfy;

% Solve with min domain size and min value
% solve :: int_search(q, first_fail, indomain_min) satisfy;

% Solve with min domain size and random value
% solve :: int_search(q, first_fail, indomain_random) satisfy;

% Solve with dom_w_deg and min value
% solve :: int_search(q, dom_w_deg, indomain_min) satisfy;

% Solve with dom_w_deg and random value
% solve :: int_search(q, dom_w_deg, indomain_random) satisfy;
