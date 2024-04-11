int: n;
array[0..n-1] of var 0..n-1: x;
 
 
% meta constraint
% sommatoria = quante volte è vera la condizione 
constraint forall(i in 0..n-1) (x[i] = (sum(j in 0..n-1) (x[j]=i))); 


% the first implied constraint
constraint n = sum(i in 0..n-1)(x[i]);
% the second implied constraint
constraint n = sum(i in 0..n-1)(x[i]*i);


solve satisfy;

output [ "x = \(x);\n" ] ;