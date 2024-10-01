%% Just Kinematic Equations
clc
clear

thrust = 900;
mass = 30;
g = 9.81;
burn_time = 8;

fs = 100;

t = 0;
altitude = 0;
time = 0;
velocity = 0;
weight = mass * g;
drag = 0;
cd = 0.75;
density = 1.225;
area = ((0.1524^2)/4)*3.14159;

net_force = [];
accel = [];
drag = 0;
while(true)
    
    %After burnout
    if(t(end) > burn_time)
        thrust = [thrust 0];
    else
        thrust = [thrust thrust(end)];
    end
    
    %Free Body Diagram Equations
    net_force = [net_force (thrust(end) - weight(end) - drag(end))];
    accel = [accel net_force(end) / mass(end)];
    altitude = [altitude altitude(end) + velocity(end)*(1/fs) + 0.5*accel(end)*(1/fs)^2];
    velocity = [velocity velocity(end) + accel(end)/fs];

    if(altitude(end) < 0)
        break;
    end
    
    if(t(end) <= burn_time)
        mass = [mass mass(end) - 0.4059/fs];
    else
        mass = [mass mass(end)];
    end

    weight = [weight mass(end)*g];

    drag_i = 0.5*density*(velocity(end-1)^2)*cd*area;
    if(velocity(end) < 0)
        drag_i = -drag_i;
    end
    
    drag = [drag drag_i];

    t = [t t(end) + 1/fs];
end

[max_alt, max_alt_idx] = max(altitude);
max_vel = max(velocity);

plot(t, altitude(2:end), '.-b')
hold on
title("Rocket Altitude vs Time")
xlabel("Time (s)")
ylabel("Altitude (m)")



time_steps = [0, burn_time, t(max_alt_idx), t(end)];
xregion(time_steps(1), time_steps(2), FaceColor = "red");
xregion(time_steps(2), time_steps(3), FaceColor = "green");
xregion(time_steps(3), time_steps(4), FaceColor = "yellow");

legend("Rocket Altitude", "Burn", "Coast", "Descent")

hold off

disp("Rocket Simulation Completed.")
disp("Thrust: " + thrust(1) + " N")
disp("Burn Time: " + burn_time + " s")
disp("Max Altitude: " + max_alt + " m")
disp("Max Velocity: " + max_vel + " m/s")

