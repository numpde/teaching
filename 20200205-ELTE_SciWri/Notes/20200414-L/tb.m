% ..., 2020-04-19  
% This is a script file used to draw the stability regions of Richardson extrapolation method in %combination with the two-stage explicit Runge-Kutta method.
%RE: Richardson extrapolation
%MRE: multiple Richardson extrapolation
%Input:    
% y’ = λy (complex function) , λ- complex no. 
%  X, Y: real number
% h - stepsize
% Stability functions:
% S_2RK : two-stage Runge-Kutta method
% S_2RK_RE : the combination of Richardson extrapolation and 2-stage RK method
% S_2RK_MRE : the combination of multiple Richardson extrapolation and 2-stage RK method
%output
figure(1): stability region of 2-stage RK method
figure(2): the stability region of RE + 2-RK method 
figure(3): the stability region of MRE + 2-RK method 
figure(4): stability regions of all the three method together

%====================================================================
close all
clear all

%Parameters for plotting
fsz = 10;  	% Font Size 
LW = 'LineWidth';
lw = 1.5;  	% LineWidth 
%Region on the complex plane:
x = -30:0.05:30;
y = -30:0.05:30;
[X,Y] = meshgrid(x,y);

S_2RK=-abs(1+(X+i*Y)+((X+i*Y).^2)/2); S_2RK_RE=-abs(1+(X+i*Y)+((X+i*Y).^2)/2+((X+i*Y).^3)/6+((X+i*Y).^4)/48); 
S_2RK_MRE=-abs(8/7*(1+1/2*(X+i*Y)+1/8*(X+i*Y).^2+1/48*(X+i*Y).^3+1/768*(X+i*Y).^4).^2-1/7*(1+(X+i*Y)+1/2*(X+i*Y).^2+1/6*(X+i*Y).^3+1/48*(X+i*Y).^4 ));  
v=[-1,-1];  %contour line -1 is needed so that the stable part be filled
%=====================================================================
%Plotting the stability regions   
%=====================================================================

figure(1)
% 2RK method
contourf(X,Y,S_2RK,v);
clr = [221 221 221]/255; 
colormap(clr)  
hold on
plot([min(x) max(x)],[0 0],'k--',LW,lw)
plot([0 0],[min(y) max(y)],'k--',LW,lw)  
axis equal
axis([-8 8 -6 6])
title('Stability region for 2RK')
xlabel('Re(\mu)', 'FontName', 'AvantGarde','FontSize'   , fsz)
ylabel('Im(\mu)','FontName', 'AvantGarde','FontSize'   , fsz)
set(gcf,'color','white')

figure(2)
% 2RK + RE method
contourf(X,Y,S_2RK_RE,v);
clr = [221 221 221]/255;
colormap(clr)
hold on
plot([min(x) max(x)],[0 0],'k--',LW,lw)  
plot([0 0],[min(y) max(y)],'k--',LW,lw)
axis equal
axis([-8 8 -6 6])
title('Stability region for 2RK+RE')
xlabel('Re(\mu)', 'FontName', 'AvantGarde','FontSize'   , fsz)
ylabel('Im(\mu)','FontName', 'AvantGarde','FontSize'   , fsz)

figure(3)
% 2RK + MRE method
contourf(X,Y,S_2RK_MRE,v);
clr = [221 221 221]/255;
colormap(clr)  
hold on
plot([min(x) max(x)],[0 0],'k--',LW,lw)
plot([0 0],[min(y) max(y)],'k--',LW,lw)  
axis equal
axis([-12 12 -10 10])
title('Stability region for 2RK+MRE')
xlabel('Re(\mu)', 'FontName', 'AvantGarde','FontSize'   , fsz)
ylabel('Im(\mu)','FontName', 'AvantGarde','FontSize'   , fsz)
set(gcf,'color','white')

figure(4)
% All methods together
contour(X,Y,S_2RK_MRE,v); 
hold on
contour(X,Y,S_2RK_RE,v);
contourf(X,Y,S_2RK,v);
plot([min(x) max(x)],[0 0],'k--',LW,lw)
plot([0 0],[min(y) max(y)],'k--',LW,lw)  
axis([-12 12 -10 10])
title('Stability regions for all the three methods')
xlabel('Re(z)', 'FontName', 'AvantGarde','FontSize', fsz)
ylabel('Im(z)','FontName', 'AvantGarde','FontSize', fsz)


