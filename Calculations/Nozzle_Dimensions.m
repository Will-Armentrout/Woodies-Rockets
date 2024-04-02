%% Code for solve for Nozzle Dimensions
clc
clear
% Initial Parameters
Isp = [1.7891e+03,1.9663e+03,2.0791e+03,2.1604e+03,2.2231e+03,2.2737e+03];
Isp = Isp./9.81;
T = 889.644;

%Flow Rates
wdot = T./Isp;
mdot = wdot./9.81;

%Set Parameters

%These are for NO2 and IPA at P_Chamber=15 bar and O/F=6
P_Chamber = [6 9 12 15 18 21];
Pt = [3.469,5.1991,6.9279,8.6557,10.383,12.109].*10^5;
Cp = [4.9345 4.7070 4.5533 4.4384 4.2471 4.2718].*10^3;
gamma = [1.1316,1.134,1.1357,1.1371,1.1382,1.1391];
R = ((gamma-1)./gamma).*Cp;
Tt =[2928.5,2962.4,2986.2,3004.6,3019.5,3032];
mach_Num = [1.876,2.1,2.25,2.361,2.449,2.522];
sonic_Vel = [1.0248e+03,1.0303e+03,1034,1037,1.0393e+03,1.0413e+03];
exit_Vel = mach_Num.*sonic_Vel;
thrust = mdot.*exit_Vel;

A_Ratio = [1.7208,2.2415,2.7277,3.1859,3.6205,4.0348];

At = (mdot./Pt).*(R.*Tt./gamma).^0.5;
Ae = A_Ratio.*At;

Dt = (At/pi).^0.5;
De = (Ae/pi).^0.5;

Ac = 7.*At;
Dc = (Ac/pi).^0.5;
L_star = 1;
Vc = L_star.*At;
Lc = Vc./(1.1.*Ac);

