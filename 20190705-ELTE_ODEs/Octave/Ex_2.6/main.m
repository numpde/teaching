
% RA, 2019-10-25

function main

  % Solve x' = F(x)
  function [R] = F(x)
    R = [log(1 - x(2)), log(x(1))];
  endfunction
  
  % Default timestep size
  dt = 1e-2;

  % Stable state
  xs = [1, 0];
  assert(all(F(xs) == 0))

  % Perturbation
  epsilon = randn(size(xs));
  epsilon = 1e-2 * epsilon / norm(epsilon);
  
  % Initial condition: perturbation of the stable state
  x0 = xs + epsilon;
  
  % Temporal interval
  T = 1e2;
  J = [0, T];  

  % Explicit Euler
  function [tt, xx] = EE(F, J, x0)
    tt = linspace(J(1), J(2), ceil(diff(J) / dt) + 1);
    xx = zeros(length(tt), length(x0));
    xx(1, :) = x0;
    for n = (2 : length(tt))
      dt = tt(n) - tt(n - 1);
      xx(n, :) = xx(n - 1, :) + dt * F(tt(n - 1), xx(n - 1, :));
    endfor
  endfunction
  
  % Implicit Euler
  function [tt, xx] = IE(F, J, x0)
    tt = linspace(J(1), J(2), ceil(diff(J) / dt) + 1);
    xx = zeros(length(tt), length(x0));
    xx(1, :) = x0;
    for n = (2 : length(tt))
      dt = tt(n) - tt(n - 1);
      xx(n, :) = fsolve(@(x)((x - xx(n - 1, :)) - dt * F(tt(n), x)), xx(n - 1, :));
    end
  end
  
  function plot_trajectory(tt, xx)
    hold on; 
    grid on;
    hh(1) = plot(xx(:, 1), xx(:, 2), '-');
    hh(2) = plot(xx(0 == tt, 1), xx(0 == tt, 2), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
    hh(3) = plot(xx(T == tt, 1), xx(T == tt, 2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    
    axis('square');
    legend(hh(2:3), strcat('t = ', num2str(0)), strcat('t = ', num2str(T)));
    pause(0.1);
  end
  
  % Implicit solver
  [tt, xx] = IE(@(t, x)(F(x)), J, x0);
  % Plot solution
  ax2 = subplot(1, 2, 1);
  title('Implicit Euler');
  plot_trajectory(tt, xx);
  
  % Explicit solver
  [tt, xx] = EE(@(t, x)(F(x)), J, x0);
  % Plot solution
  ax1 = subplot(1, 2, 2);
  title('Explicit Euler');
  plot_trajectory(tt, xx);
  
  % Sync axes
  linkaxes([ax1, ax2]);
  
  saveas(gcf, "IE-EE.png");
end
