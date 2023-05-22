pkg load interval
pkg load optim
addpath(genpath('./tolsolvty'))
addpath(genpath('./ctrsolvty'))
addpath(genpath('./assets'))

infA = [ 0.5 1; 2.5 1; 2.5 1; 4.5 1 ]
supA = [ 1.5 1; 3.5 1; 3.5 1; 5.5 1 ]
infb = [5; 4; 2; 1]
supb = [5; 4; 2; 1]
solve2dctrproblem(infA,supA,infb,supb,10e-6,'DW','x','y','Ctr test task','Example_ws');
