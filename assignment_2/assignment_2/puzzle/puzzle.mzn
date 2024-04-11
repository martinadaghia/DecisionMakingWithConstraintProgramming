include "globals.mzn";

int: n; 
array[0..n-1] of var 0..n-1: x; 


constraint global_cardinality(x,0..n-1,[x[i] | i in 0..n-1]);

%constraint forall(i in 0..n-1)(x[i] = sum(j in 0..n-1)(x[j]=i)); % base

% implied constraints:
constraint n= sum(i in 0..n-1) (x[i]); % sum of all elements of array X is equal to the value of n
constraint n =sum(i in 0..n-1) (x[i]*i); % sum of the products between each element of the array X and its position in the array is equal to n 


solve satisfy;

