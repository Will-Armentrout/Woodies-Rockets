%% N2O Gas Phase Transition Calculation

%N2O's Boiling point is at 293.15K at 5.0525 MPa.
%I have a 4L (internal volume) tank.
clc
clear

% Liquid Density at 5.0525 MPa is 
liq_density = 785.10;
gas_density_5_0525 = 157.99;
gas_density_4_5 = 123.74;

%If tank is all liquid
n2o_max_mass = 4/1000 * liq_density;

%If tank is all gas
n2o_min_mass = 4/1000 * gas_density_5_0525;

disp((n2o_max_mass - n2o_min_mass)/0.3525)


disp("Tank can drain: " + (n2o_max_mass - n2o_min_mass) + " kg of N2O before losing pressure.")