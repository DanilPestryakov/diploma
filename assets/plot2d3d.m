%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2023-05-01
% SimpleTest
function plot2d3d(infA,supA,infb,supb,x_ranges,y_ranges,z_ranges,varargin)
  [xx, yy] = meshgrid(x_ranges, y_ranges);
  radA = (supA - infA) / 2;
  midA = (supA + infA) / 2;
  z = zeros(size(xx));
  [s1, s2] = size(z);
  [s3, s4] = size(infA);
  for i=1:s1
    for j=1:s2
      sums = zeros(1, s3);
      for k=1:s3
        sum_mid = midA(k, 1) * xx(i, j) +  midA(k, 2) * yy(i, j);
        mid_abs = max([abs(infb(k) - sum_mid) abs(supb(k) - sum_mid)]);
        sums(k) = radA(k, 1) * abs(xx(i, j)) +  radA(k, 2) * abs(yy(i, j)) - mid_abs;
      endfor
      z(i, j) = min(sums);
    endfor
  endfor
  l_plot_1 = surf(xx,yy,z);
  xlabel('x')
  ylabel('y');
  zlabel('z');
  title('2D problem vizauliaztion');
  colorbar;
  hold on;
  l_plot_4 = surf(xx,yy,zeros(size(xx)));
  hold on;
  max_val = max(max(z));
  [maxi,maxj] = find(z==max_val);
  [m_s1, m_s2] = size(maxi);
  for k = 1:m_s1
    l_plot_2 = plot3(xx(maxi(k), maxj(k)), yy(maxi(k), maxj(k)), z(maxi(k), maxj(k)), 'ro');
    hold on;
  endfor
  if length(varargin) == 2
    l_plot_3 = plot3(varargin{1}(1), varargin{1}(2), varargin{2}, 'gv');
    legend([l_plot_1, l_plot_2, l_plot_3, l_plot_4], {'Ctr graphic', 'Ctr max dots', sprintf('ctrmax: (%0.4e; %0.4e; %0.4e)', varargin{1}(1), varargin{1}(2), varargin{2}), 'z=0'})
  else
    legend([l_plot_1, l_plot_2, l_plot_4], {'Ctr graphic', 'Ctr max dots', 'z = 0'})
  endif
  hold off;
  zlim(z_ranges);
endfunction
