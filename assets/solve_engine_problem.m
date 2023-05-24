function solve_engine_problem(infA1,supA1,infb1,supb1,infA2,supA2,infb2,supb2, mode)
  [infA_1, supA_1, argmax_1] = solve2dctrproblem(infA1,supA1,infb1,supb1,10e-6,mode,'time (ms)','centered encoder value (a. u.)','Ctr engine task','Example_ws');
  [infA_2, supA_2, argmax_2] = solve2dctrproblem(infA2,supA2,infb2,supb2,10e-6,mode,'time (ms)','centered encoder value (a. u.)','Ctr engine task','Example_ws');

  [m_1, n_1] = size(infA_1);
  [m_2, n_2] = size(infA_2);

  midA1 = (supA1+infA1)/2;
  midA2 = (supA2+infA2)/2;
  midb1 = (supb1+infb1)/2;
  midb2 = (supb2+infb2)/2;

  figure;
  for i=1:m_1
      l_plot_1 = plot([infA_1(i, 1) supA_1(i, 1)], [infb1(i) supb1(i)], 'b-');
      hold on
      l_plot_2 = plot([midA1(i, 1) midA1(i, 1)], [midb1(i) midb1(i)], 'gs');
      hold on
  endfor

  for i=1:m_2
      l_plot_1 = plot([infA_2(i, 1) supA_2(i, 1)], [infb2(i) supb2(i)], 'b-');
      hold on
      l_plot_2 = plot([midA2(i, 1) midA2(i, 1)], [midb2(i) midb2(i)], 'gs');
      hold on
  endfor

  box off
  xlabel('x')
  ylabel('y');
  title('Ctr diploma task with 2 regression');
  grid on;
  if abs(argmax_1(1) - argmax_2(1)) <= 1e-6
    x1 = min([min(infA1(:, 1)) min(infA2(:, 1))]);
  else
    x1 = (argmax_2(2) - argmax_1(2)) / (argmax_1(1) - argmax_2(1));
  endif
  xm_1 = min(infA1(:, 1));
  l_plot_3 = plot([x1 xm_1], [(argmax_1(2) + argmax_1(1) * x1) (argmax_1(2) + argmax_1(1) * xm_1)], 'r');
  hold on;
  xm_2 = max(supA2(:, 1));
  l_plot_4 = plot([x1 xm_2], [(argmax_2(2) + argmax_2(1) * x1) (argmax_2(2) + argmax_2(1) * xm_2)], 'r');
  hold on;
  l_plot5 = plot([x1 x1], [(argmax_2(2) + argmax_2(1) * x1) max([max(supb1) max(supb2)])], 'r--');
  legend([l_plot_1, l_plot_2, l_plot_3, l_plot_4, l_plot5], {'Extended data', 'Initial data', 'Regression line straight running', 'Regression line reverse course', 'Symmetry axis'})
  ylim([min([min(infb1) min(infb2)]) - 1 max([max(supb1) max(supb2)]) + 1]);
endfunction
