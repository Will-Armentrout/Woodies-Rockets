clear, clc, close all
%% Oxidizer
OF = 6.6;%Oxidizer Fuel Ratio -- by mass
rho_o = 105.51; %kg/m^3 Density of N2O at 293.15K and 4.1MPa
dP = 0.6 * 1000000; %MPa Pressure Drop
g = 9.81; %m/s^2 acceleration due to gravity
n_o = 8; %number of holes for the injector
Cd = 0.6; %coefficient of discharge (0.5-0.7 for liquids as close as possible to 1 for gases)
mdot_o = 0.3525;

A_o = (mdot_o/(Cd*sqrt(2*rho_o*dP)));
v_o = (mdot_o)/(A_o*rho_o);
A_o = (mdot_o/(Cd*sqrt(2*rho_o*dP)))*1e6;
d_o = sqrt(((4*A_o)/pi)/n_o);

disp("the injector velocity of the oxidizer is " + v_o + " m/s")
disp("the total area for oxidizer injectors is " + A_o + " mm^2")
disp("the diameter of EACH oxidizer hole is " + d_o + " mm")

%% Fuel
rho_f = 756;
n_f = 4;
mdot_f = 0.0534;
A_f = (mdot_f/(Cd*sqrt(2*rho_f*dP)));
v_f = (mdot_f)/(A_f*rho_f);
A_f = (mdot_f/(Cd*sqrt(2*rho_f*dP)))*1e6;
d_f = sqrt(((4*A_f)/pi)/n_f);

disp("the injector velocity of the fuel is " + v_f + " m/s")
disp("the total area for fuel injectors is " + A_f + " mm^2")
disp("the diameter of EACH fuel hole is " + d_f + " mm")

