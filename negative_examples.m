pkg load interval
addpath(genpath('./tolsolvty'))
addpath(genpath('./ctrsolvty'))

infA = [-1 5 3; -2 7 -10];
supA = [1 6 8; 0.5 8 15];
infb = [1; 10];
supb = [5; 15];

[ctrmax,argmax,envs,ccode] = ctrsolvty(infA,supA,infb,supb);
disp('ctrmax');
disp(ctrmax);
disp('argmax');
disp(argmax);
disp('envs');
disp(envs);
disp('ccode');
disp(ccode);


infA = [2 3; 7 10];
supA = [4 7; 13 20];
infb = [-10; 1];
supb = [10; 4];

[ctrmax,argmax,envs,ccode] = ctrsolvty(infA,supA,infb,supb);
disp('ctrmax');
disp(ctrmax);
disp('argmax');
disp(argmax);
disp('envs');
disp(envs);
disp('ccode');
disp(ccode);
