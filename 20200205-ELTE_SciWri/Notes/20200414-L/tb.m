% This is a MatLab program to draw the graph of second stage explicit Runge-Kutta method in combined with the Richardson extrapolation method.with

% Stability regions of multiple Richardson extrapolation method incombied
% with second stage explicit Runge-Kutta method
close all
clear all
width = 3; 	% Width in inches
height = 3;	% Height in inches
alw = 0.75;	% AxesLineWidth
fsz = 10;  	% Fontsize
lw = 1.5;  	% LineWidth
x = -30:0.05:30;
y = -30:0.05:30;
[X,Y] = meshgrid(x,y);

theta = 1;  %theta = 0.5: trapezoidal rule, theta = 1: implicit Euler, theta=0: explicit Euler
if theta ~= 0.5
	p = 1;
end
cw = 2^p/(2^p-1);  %the weight of w when the method has order p
cz = -1/(2^p-1);   %the weight of z when the method has order p
Z_2RK=-abs(1+(X+i*Y)+((X+i*Y).^2)/2);
Z_2RK_RE=-abs(1+(X+i*Y)+((X+i*Y).^2)/2+((X+i*Y).^3)/6+((X+i*Y).^4)/48);
Z_2RK_MRE=-abs(8/7*(1+1/2*(X+i*Y)+1/8*(X+i*Y).^2+1/48*(X+i*Y).^3+1/768*(X+i*Y).^4).^2-1/7*(1+(X+i*Y)+1/2*(X+i*Y).^2+1/6*(X+i*Y).^3+1/48*(X+i*Y).^4 ));  
v=[-1,-1];

figure(1)
contourf(X,Y,Z_2RK,v);
clr = [221 221 221]/255;
colormap(clr)  
LW = 'LineWidth'; lw = 1;
hold on
plot([min(x) max(x)],[0 0],'k--',LW,lw)
plot([0 0],[min(y) max(y)],'k--',LW,lw)  
axis equal
axis([-8 8 -6 6])
title('Stability region for 2RK')
xlabel('Re(\mu)', 'FontName', 'AvantGarde','FontSize'   , 10)
ylabel('Im(\mu)','FontName', 'AvantGarde','FontSize'   , 10)
set(gcf,'color','white')

figure(2)
contourf(X,Y,Z_2RK_RE,v);
clr = [221 221 221]/255;
colormap(clr)
LW = 'LineWidth'; lw = 1;
hold on
plot([min(x) max(x)],[0 0],'k--',LW,lw)  
plot([0 0],[min(y) max(y)],'k--',LW,lw)
axis equal
axis([-8 8 -6 6])
title('Stability region for 2RK+RE')
xlabel('Re(\mu)', 'FontName', 'AvantGarde','FontSize'   , 10)
ylabel('Im(\mu)','FontName', 'AvantGarde','FontSize'   , 10)

figure(3)
contourf(X,Y,Z_2RK_MRE,v);
clr = [221 221 221]/255;
colormap(clr)  
LW = 'LineWidth'; lw = 1;
hold on
plot([min(x) max(x)],[0 0],'k--',LW,lw)
plot([0 0],[min(y) max(y)],'k--',LW,lw)  
axis equal
axis([-12 12 -10 10])
title('Stability region for 2RK+MRE')
xlabel('Re(\mu)', 'FontName', 'AvantGarde','FontSize'   , 10)
ylabel('Im(\mu)','FontName', 'AvantGarde','FontSize'   , 10)
set(gcf,'color','white')

figure(4)
contour(X,Y,Z_2RK_MRE,v);
hold on
contour(X,Y,Z_2RK_RE,v);
contourf(X,Y,Z_2RK,v);
plot([min(x) max(x)],[0 0],'k--',LW,lw)
plot([0 0],[min(y) max(y)],'k--',LW,lw)  
axis([-12 12 -10 10])
title('Stability regions for MRE in combined with 2RK method')
xlabel('Re(z)', 'FontName', 'AvantGarde','FontSize'   , 10)
ylabel('Im(z)','FontName', 'AvantGarde','FontSize'   , 10)
