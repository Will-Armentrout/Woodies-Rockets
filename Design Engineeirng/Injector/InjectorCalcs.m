clear, clc, close all
%Plug in values
Cd = 0.6;
g = 9.81;
rho = 786;
n = 4;
dP = 300000; %MPa
mdot = 0.0534;
wdot = mdot * g

v = Cd*sqrt(2*g*(dP/rho))
A = wdot/(Cd*sqrt(2*g*rho*dP))*1000000

D = sqrt(((4*A)/pi)/n)

