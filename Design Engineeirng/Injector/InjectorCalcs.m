clear, clc, close all
%Plug in values
rho = 49.01; % lb/ft^3 density 
g = 32.2; %ft/s^2 accel. due to gravity
dP = 350 * 144; %psf pressure drop across injector plate
n = 7; %number of holes
w = 0.1177; %lb/s flowrate
v = 100; %ft/s
Cd = v / sqrt(2*g*(dP/rho)); %should be between 0.5 and 0.7
A = ((w/(Cd*sqrt(2*g*dP*rho)))*144)*6.4516; %cm^2
D = sqrt((4*A*pi)/n);
disp("The coefficient of discharge is " + Cd)
disp("The diameter of each hole is " + D + " cm")
