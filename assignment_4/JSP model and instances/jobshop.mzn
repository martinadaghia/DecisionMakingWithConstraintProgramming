include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks (machine[j,i] required by task i of job j)
array[JOB,MACH] of int: duration;     % task durations on machines (duration[j,k] is the duration of task k of job j)



int: totalduration = sum(duration);
array[JOB,TASK] of var 0..totalduration: start;
var 0..totalduration: makespan;

% precedence constraint
constraint forall(j in JOB) 
    ((forall(k in 1..M-1)
        ( start[j,k] + duration[j,machine[j,k]] <= start[j,k+1])) /\ start[j,M] + duration[j,machine[j,M]]<=makespan);

% disjointed constraint for each machine       
constraint forall(m in MACH) (
        disjunctive( [start[j,k] | j in JOB, k in TASK where machine[j,k]=m], [ duration[j,m] | j in JOB ]));
                                                       
%default search   
%solve minimize  makespan;

%search on the smallest start times
solve::int_search(start, smallest, indomain_min) minimize  makespan;
