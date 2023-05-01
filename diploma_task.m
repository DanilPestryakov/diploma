pkg load interval
pkg load optim
addpath(genpath('./tolsolvty'))
addpath(genpath('./ctrsolvty'))

infA = [59240 1; 23820 1; 41800 1; 59110 1; 35500 1; 17660 1; 63970 1; 34520 1; 16770 1; 16110 1; 34080 1; 49860 1; 51300 1; 42580 1];
supA = [59348 1; 23924 1; 41912 1; 59228 1; 35618 1; 17772 1; 64086 1; 34630 1; 16880 1; 16228 1; 34196 1; 49978 1; 51412 1; 42696 1];
infb = [399; 416; 408; 397; 406; 417; 390; 405; 418; 420; 414; 401; 398; 407];
supb = [399; 416; 408; 397; 406; 417; 390; 405; 418; 420; 414; 401; 398; 407];


[ctrmax,argmax,envs,ccode] = ctrsolvty(infA,supA,infb,supb);
disp('ctrmax');
disp(ctrmax);
disp('argmax');
disp(argmax);
disp('envs');
disp(envs);
disp('ccode');
disp(ccode);

Ac = 0.5*(infA + supA);
Ar = 0.5*(supA - infA);

B = abs(supb - Ac * argmax) - Ar * abs(argmax);
B = B';

A = zeros(14, 2);
for i = 1:14
		A(i, 1) = Ar(i, 1) * abs(argmax(1)); # y_eps
    A(i, 2) = Ar(i, 2) * abs(argmax(2)); # y_eps
endfor

lb = zeros(1, 2);

ctype = "";
for i = 1:14
  ctype(i) = 'L';
endfor

vartype = "";
for i = 1:2
  vartype(i) = 'C';
endfor

sense = 1e-4;

C = ones(1,2);

[w, w_min] = glpk(C,A,B,lb,[],ctype,vartype,sense);
for i=1:length(w)
  w(i) = w(i) + 1;
endfor
display('w');
display(w);


Ar = Ar.*w';
infA_1 = Ac - Ar;
supA_1 = Ac + Ar;
[ctrmax,argmax,envs,ccode] = ctrsolvty(infA_1,supA_1,infb,supb);
disp('ctrmax');
disp(ctrmax);
disp('argmax');
disp(argmax);
disp('envs');
disp(envs);
disp('ccode');
disp(ccode);

figure('position', [0, 0, 800, 600]);
set(gca, 'fontsize', 12);
for i=1:14
  l_plot_1 = plot([infA_1(i, 1) supA_1(i, 1)], [infb(i) supb(i)], 'b-');
  hold on
  l_plot_2 = plot([infA(i, 1) supA(i, 1)], [infb(i) supb(i)], 'go');
  hold on
endfor
xlabel('time (ms)')
ylabel('centered encoder value (a. u.)');
title('Ctr test task');
grid on;
x_l = min(infA_1(:, 1))
x_m = max(supA_1(:, 1))
l_plot_3 = plot([x_1 x_m], [(argmax(2) + argmax(1) * x_1) (argmax(2) + argmax(1) * x_m)], 'r');
legend([l_plot_1, l_plot_2, l_plot_3], {'Extended data', 'Initial data', 'Regression line'})

