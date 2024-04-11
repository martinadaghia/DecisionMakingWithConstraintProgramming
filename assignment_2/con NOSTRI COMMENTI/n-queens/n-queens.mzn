
include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.  

% Decomposition of global constraints
constraint forall(i,j in 1..n where i<j) (q[i] != q[j]);  %NO stesso valore delle 2 regine sulla riga o colonna
constraint forall(i,j in 1..n where i<j) (q[i]+i != q[j]+j); %NO stesso valore delle 2 regine sulla diagonale ascendente
constraint forall(i,j in 1..n where i<j) (q[i]-i != q[j]-j); %NO stesso valore delle 2 regine sulla diagonale discendente


% Alldifferent GC 
%constraint alldifferent(q)::domain; %different rows
%constraint alldifferent([ q[i]+i | i in 1..n])::domain; %NO stesso valore delle 2 regine sulla diagonale ascendente
%constraint alldifferent([ q[i]-i | i in 1..n])::domain; %NO stesso valore delle 2 regine sulla diagonale discendente


solve :: int_search(q, input_order, indomain_min) satisfy;

