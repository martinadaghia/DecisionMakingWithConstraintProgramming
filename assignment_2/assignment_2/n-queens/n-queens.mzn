include "alldifferent.mzn";

int: n; % n° of queens
array [1..n] of var 1..n: q; % variables for queens on the rows or columns


% Decomposition of global constraints
constraint forall(i,j in 1..n where i<j) (q[i] != q[j]);  
constraint forall(i,j in 1..n where i<j) (q[i]+i != q[j]+j);
constraint forall(i,j in 1..n where i<j) (q[i]-i != q[j]-j); 


% Alldifferent GC 
%constraint alldifferent(q)::domain; 
%constraint alldifferent([ q[i]+i | i in 1..n])::domain;
%constraint alldifferent([ q[i]-i | i in 1..n])::domain; 


solve :: int_search(q, input_order, indomain_min) satisfy;

