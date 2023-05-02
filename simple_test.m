%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2023-05-01
% SimpleTest
pkg load interval
pkg load optim
addpath(genpath('./tolsolvty'))
addpath(genpath('./ctrsolvty'))
infA = [ 0.5 1; 2.5 1; 2.5 1; 4.5 1 ]
supA = [ 1.5 1; 3.5 1; 3.5 1; 5.5 1 ]
infb = [5; 4; 2; 1]
supb = [5; 4; 2; 1]

midA = (supA+infA)/2
midb = (supb+infb)/2

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

[m, n] =size(Ac)
A = zeros(m, 2);
for i = 1:m
        A(i, 1) = Ar(i, 1) * abs(argmax(1)); # y_eps
    A(i, 2) = Ar(i, 2) * abs(argmax(2)); # y_eps
endfor

lb = zeros(1, 2);

ctype = "";
for i = 1:m
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

figure;
set(gca, 'fontsize', 14);
for i=1:m
  l_plot_1 = plot([infA_1(i, 1) supA_1(i, 1)], [infb(i) supb(i)], 'b-');
  hold on
%  l_plot_2 = plot([infA(i, 1) supA(i, 1)], [infb(i) supb(i)], 'go');
  l_plot_2 = plot([midA(i, 1) midA(i, 1)], [midb(i) midb(i)], 'gs');
  hold on
endfor
box off
xlabel('time (ms)')
ylabel('centered encoder value (a. u.)');
title('Ctr test task');
grid on;
% 2023-05-01
% x_1 -> x1
% xm -> xm
x1 = min(infA_1(:, 1))
xm = max(supA_1(:, 1))
l_plot_3 = plot([x1 xm], [(argmax(2) + argmax(1) * x1) (argmax(2) + argmax(1) * xm)], 'r');
legend([l_plot_1, l_plot_2, l_plot_3], {'Extended data', 'Initial data', 'Regression line'})
%
figure_name_out=strcat('Ctr optimization test','Example','.png')
print('-dpng', '-r300', figure_name_out), pwd
