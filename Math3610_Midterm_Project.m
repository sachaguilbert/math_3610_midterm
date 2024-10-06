% SIR Model
close all
clc
clear

% Define the system of ODEs in a separate file named myThreeODE.m
function dydt = myODE(t, y)
    S_1 = y(1)-2.5;
    S_2 = y(2)-2.5;
    S_3 = y(3)-2.5;
    S_4 = y(4)-2.5;
    I_1 = y(5);
    I_2 = y(6);
    I_3 = y(7);
    I_4 = y(8);
    R_1 = y(9)+2.5;
    R_2 = y(10)+2.5;
    R_3 = y(11)+2.5;
    R_4 = y(12)+2.5;
    D_1 = y(13);
    D_2 = y(14);
    D_3 = y(15);
    D_4 = y(16);
    beta_1 = 0.0002;
    beta_2 = 0.0002;
    beta_3 = 0.00008;
    beta_4 = 0.00001;
    gamma_1 = 0.995/5;
    gamma_2 = 0.99/5;
    gamma_3 = 0.96/5;
    gamma_4 = 0.9/5;
    nat_death_1 = 0.0015/365;
    nat_death_2 = 0.0016/365;
    nat_death_3 = 0.0076/365;
    nat_death_4 = 0.0755/365;
    I = I_1 + I_2 + I_3 + I_4;
    dydt = [-1*beta_1*S_1 *(I)-1*nat_death_1*(S_1);
        -1*beta_2*S_2 *(I)-1*nat_death_2*(S_2);
        -1*beta_3*S_3 *(I)-1*nat_death_3*(S_3);
        -1*beta_4*S_4 *(I)-1*nat_death_4*(S_4);
        beta_1*I*S_1 - gamma_1*I_1 - nat_death_1*I_1; 
        beta_2*I*S_2 - gamma_2*I_2 - nat_death_2*I_2;
        beta_3*I*S_3 - gamma_3*I_3 - nat_death_3*I_3;
        beta_4*I*S_4 - gamma_4*I_4 - nat_death_4*I_4;
        gamma_1*I_1 - nat_death_1*R_1;
        gamma_2*I_2 - nat_death_2*R_2;
        gamma_3*I_3 - nat_death_3*R_3;
        gamma_4*I_4 - nat_death_4*R_4;
        nat_death_1*(S_1+I_1+R_1)+(1-gamma_1*5)*I_1;
        nat_death_2*(S_2+I_2+R_2)+(1-gamma_2*5)*I_2;
        nat_death_3*(S_3+I_3+R_3)+(1-gamma_3*5)*I_3;
        nat_death_4*(S_4+I_4+R_4)+(1-gamma_4*5)*I_4];
end

% Main script
tspan = [0 100];     % Time span
y0 = [26500; 26500; 26500; 26500; 25; 25; 25; 25; 0; 0; 0; 0; 0; 0; 0; 0];     % Initial conditions

% Solve the system of ODEs
[t, y] = ode23(@myODE, tspan, y0);

% Plot the results
figure;
hold on;
plot(t, y(:, 1), 'b', 'DisplayName', 'S_1 (Susceptible 1)');
plot(t, y(:, 2), 'g', 'DisplayName', 'S_2 (Susceptible 2)');
plot(t, y(:, 3), 'r', 'DisplayName', 'S_3 (Susceptible 3)');
plot(t, y(:, 4), 'c', 'DisplayName', 'S_4 (Susceptible 4)');
plot(t, y(:, 5), 'b--', 'DisplayName', 'I_1 (Infected 1)');
plot(t, y(:, 6), 'g--', 'DisplayName', 'I_2 (Infected 2)');
plot(t, y(:, 7), 'r--', 'DisplayName', 'I_3 (Infected 3)');
plot(t, y(:, 8), 'c--', 'DisplayName', 'I_4 (Infected 4)');
plot(t, y(:, 9), 'b:', 'DisplayName', 'R_1 (Recovered 1)');
plot(t, y(:, 10), 'g:', 'DisplayName', 'R_2 (Recovered 2)');
plot(t, y(:, 11), 'r:', 'DisplayName', 'R_3 (Recovered 3)');
plot(t, y(:, 12), 'c:', 'DisplayName', 'R_4 (Recovered 4)');
plot(t, y(:, 13), 'b.-', 'DisplayName', 'R_1 (Dead 1)');
plot(t, y(:, 14), 'g.-', 'DisplayName', 'R_2 (Dead 2)');
plot(t, y(:, 15), 'r.-', 'DisplayName', 'R_3 (Dead 3)');
plot(t, y(:, 16), 'c.-', 'DisplayName', 'R_4 (Dead 4)');
hold off;

xlabel('Time');
ylabel('Population');
title('SIR Model Dynamics');
legend show;
grid on;

