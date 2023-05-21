function solve2dctrproblem(infA,supA,infb,supb,eps,mode,xlabel_,ylabel_,title_, figure_name)
  midA = (supA+infA)/2;
  midb = (supb+infb)/2;

  [ctrmax,argmax,envs,ccode] = ctrsolvty(infA,supA,infb,supb);
  underline = '__________________________________';
  disp('Original task ctrmax:');
  disp(ctrmax);
  disp(underline);
  disp('Original task argmax:');
  disp(argmax);
  disp(underline);
  disp('Original task envs');
  disp(envs);
  disp(underline);
  disp('Original task ccode');
  disp(ccode);
  disp(underline);
  Ac = 0.5*(infA + supA);
  Ar = 0.5*(supA - infA);
  [m, n] = size(Ac);

  if ctrmax < -eps
    B = abs(supb - Ac * argmax) - Ar * abs(argmax);
    B = B';

    switch (mode)
      case 'SW' %same weight for identical variables
        A = zeros(m, 2);
        for i = 1:m
          A(i, 1) = Ar(i, 1) * abs(argmax(1)); # coeffs for w_1
          A(i, 2) = Ar(i, 2) * abs(argmax(2)); # coeffs for w_2
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
        disp('w');
        disp(w);
        disp(underline);
        Ar = Ar.*w';
    endswitch
  endif

  infA_1 = Ac - Ar;
  supA_1 = Ac + Ar;
  if ctrmax < -eps
    [ctrmax,argmax,envs,ccode] = ctrsolvty(infA_1,supA_1,infb,supb);
    disp('Optim task ctrmax:');
    disp(ctrmax);
    disp(underline);
    disp('Optim task argmax:');
    disp(argmax);
    disp(underline);
    disp('Optim task envs');
    disp(envs);
    disp(underline);
    disp('Optim task ccode');
    disp(ccode);
    disp(underline);
  endif
  figure;
  set(gca, 'fontsize', 14);
  for i=1:m
    l_plot_1 = plot([infA_1(i, 1) supA_1(i, 1)], [infb(i) supb(i)], 'b-');
    hold on
    l_plot_2 = plot([midA(i, 1) midA(i, 1)], [midb(i) midb(i)], 'gs');
    hold on
  endfor
  box off
  xlabel(xlabel_)
  ylabel(ylabel_);
  title(title_);
  grid on;
  x1 = min(infA_1(:, 1));
  xm = max(supA_1(:, 1));
  l_plot_3 = plot([x1 xm], [(argmax(2) + argmax(1) * x1) (argmax(2) + argmax(1) * xm)], 'r');
  legend([l_plot_1, l_plot_2, l_plot_3], {'Extended data', 'Initial data', 'Regression line'})
  figure_name_out=strcat(figure_name, '.png');
  print('-dpng', '-r300', figure_name_out), pwd
endfunction
