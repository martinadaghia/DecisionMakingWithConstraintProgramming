% Combined alldifferent & symmetry breaking model

% alldiff model
include "alldifferent.mzn";

int: n; 
array [1..n] of var 1..n: q;

constraint alldifferent(q)::domain; 
constraint alldifferent([ q[i]+i | i in 1..n])::domain;
constraint alldifferent([ q[i]-i | i in 1..n])::domain;

% Integration of the Boolean model 
constraint symmetry_breaking_constraint(
let {
  array[1..n,1..n] of var bool: B;
} in
    forall (i,j in 1..n) ( B[i,j] <-> (q[i]=j) )
/\  lex_lesseq(array1d(B), [ B[j,i] | i,j in 1..n ])
/\  lex_lesseq(array1d(B), [ B[i,j] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[i,j] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(B), [ B[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i,j in reverse(1..n) ])
);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;

