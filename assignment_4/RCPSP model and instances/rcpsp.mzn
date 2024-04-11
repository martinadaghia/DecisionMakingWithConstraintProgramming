include "globals.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  % Set of tasks
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; % Set of resources
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;       % Number of precedence relations
set of int: PREC = 1..p; % Set of precedence relations
array[PREC,1..2] of TASKS: pre; % Precedence relations
  
% Calculate the total duration of all tasks
int: total_duration = sum(duration);

% Define decision variables for start times of tasks within the total duration
array[TASKS] of var 0..total_duration: start;

% Precedence constraints: Ensure that the end time of a preceding task is before the start time of its succeeding task
constraint forall(i in PREC) 
  (start[pre[i,1]] + duration[pre[i,1]] <= start[pre[i,2]]);

% Cumulative resource constraints: Ensure that resource usage remains within capacity for each resource
constraint forall(i in RESOURCES) 
  (cumulative(start, duration, [req[i,j] | j in TASKS], L[i]));

% Default search
% solve minimize max([start[i]+ duration[i] | i in TASKS]);

% Search on the smallest start times
 solve::int_search(start, smallest, indomain_min) 
 minimize max([start[i]+ duration[i] | i in TASKS]);

output [
    "Start = ", show(start), "\n",
    "Makespan = ", show(max([start[i]+ duration[i] | i in TASKS])), "\n"
];