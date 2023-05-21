%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2023-05-01
% SimpleTest
function plot2d3d(infA,supA,infb,supb,x_ranges,y_ranges,z_ranges)
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
  surf(xx,yy,z);
  xlabel('x')
  ylabel('y');
  title('2D problem vizauliaztion');
  colorbar;
  hold on;
  surf(xx,yy,zeros(size(xx)));
  hold off;
  zlim([-10 10])
endfunction
