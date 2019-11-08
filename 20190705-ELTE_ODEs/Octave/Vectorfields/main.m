function main

  xx = linspace(-1, 1, 11);
  yy = linspace(-1, 1, 11);
  [X, Y] = meshgrid(xx, yy);
 
  AA = reshape(unique(round(randn(20, 4)), 'rows'), 2, 2, []);
  
  for n = (1 : size(AA, 3))
    A = AA(:, :, n);
    
    UV = reshape(A * [X(:)'; Y(:)'], [2, length(yy), length(xx),]);
    
    U = UV(1, :, :);
    V = UV(2, :, :);
    
    clf;
    hold('on');
    plot([min(xx), max(xx)], [0, 0], 'k', 'LineWidth', 2);
    plot([0, 0], [min(yy), max(yy)], 'k', 'LineWidth', 2);
    h(1) = plot(X(:), Y(:), 'bo', 'MarkerSize', 5);
    h(2) = plot(0, 0, 'r-', 'LineWidth', 3);
    quiver(X, Y, U, V, 'r', 'LineWidth', 3);
    xlabel('x_1');
    ylabel('x_2');
    legend(h, "x", "x'");
    grid;
    
    copied_legend = findobj(gcf(), "type", "axes", "Tag", "legend");
    set(copied_legend, "FontSize", 30);
    
    axis([min(xx), max(xx), min(yy), max(yy)]);
    
    csvwrite(['A/' num2str(n) '.txt'], A);
    saveas(gcf, ['A/' num2str(n) '.png']);
    
    close;
  end  
end

