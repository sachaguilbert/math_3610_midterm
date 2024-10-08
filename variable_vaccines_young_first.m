% SIR Model
close all
% clc
clear

% Define the system of ODEs in a separate file named myThreeODE.m
function dydt = myODE(t, y)
    S_1 = y(1);
    S_2 = y(2);
    S_3 = y(3);
    S_4 = y(4);
    I_1 = y(5);
    I_2 = y(6);
    I_3 = y(7);
    I_4 = y(8);
    R_1 = y(9);
    R_2 = y(10);
    R_3 = y(11);
    R_4 = y(12);
    D_1 = y(13);
    D_2 = y(14);
    D_3 = y(15);
    D_4 = y(16);

    beta_1 = 2.5e-6*2.5;
    beta_2 = 5e-6*2.5;
    beta_3 = 3e-6*2.5;
    beta_4 = 5e-7*2.5;
    gamma_1 = 0.9987/5; % recovery rate from Omega
    gamma_2 = 0.997/5;
    gamma_3 = 0.957/5;
    gamma_4 = 0.886/5;
    nat_death_1 = 0; %0.0015/365; % natural death rate
    nat_death_2 = 0; %0.0016/365;
    nat_death_3 = 0; %0.0076/365;
    nat_death_4 = 0; %0.0755/365;
    I = I_1 + I_2 + I_3 + I_4;
    V = 2000/30;
    V_1 = 0;
    V_2 = 0;
    V_3 = 0;
    V_4 = 0;
    if S_1 > V
        V_1 = V;
    elseif S_2 > V
        V_2 = V;
    elseif S_3 > V
        V_3 = V;
    elseif S_4 > V
        V_4 = V;
    end
    dydt = [-1*beta_1*S_1 * I-1*nat_death_1*(S_1)-V_1;
        -1*beta_2*S_2 * I-1*nat_death_2*(S_2)-V_2;
        -1*beta_3*S_3 * I-1*nat_death_3*(S_3)-V_3;
        -1*beta_4*S_4 * I-1*nat_death_4*(S_4)-V_4;
        beta_1*I*S_1 - gamma_1*I_1 - nat_death_1*I_1 - ((1-gamma_1*5)/5)*I_1;
        beta_2*I*S_2 - gamma_2*I_2 - nat_death_2*I_2 - ((1-gamma_2*5)/5)*I_2;
        beta_3*I*S_3 - gamma_3*I_3 - nat_death_3*I_3 - ((1-gamma_3*5)/5)*I_3;
        beta_4*I*S_4 - gamma_4*I_4 - nat_death_4*I_4 - ((1-gamma_4*5)/5)*I_4;
        gamma_1*I_1 - nat_death_1*R_1+V_1;
        gamma_2*I_2 - nat_death_2*R_2+V_2;
        gamma_3*I_3 - nat_death_3*R_3+V_3;
        gamma_4*I_4 - nat_death_4*R_4+V_4;
        nat_death_1*(S_1+I_1+R_1)+((1-gamma_1*5)/5)*I_1;
        nat_death_2*(S_2+I_2+R_2)+((1-gamma_2*5)/5)*I_2;
        nat_death_3*(S_3+I_3+R_3)+((1-gamma_3*5)/5)*I_3;
        nat_death_4*(S_4+I_4+R_4)+((1-gamma_4*5)/5)*I_4;];
end

% % Main script
% tspan = [0 300]; % Time span
% I_0 = 100;
% N_total = 107000;
% N_0 = N_total - I_0;
% y0 = [N_0*0.20; N_0*0.15; N_0*0.40; N_0*0.25; I_0*0.25; I_0*0.25; I_0*0.25; I_0*0.25; 0; 0; 0; 0; 0; 0; 0; 0]; % Initial conditions
% 
% % Solve the system of ODEs
% [t, y] = ode23(@myODE, tspan, y0);

total_s = 0;
total_i = 0;
total_r = 0;
total_d = 0;
v = 0;

for index = 1:10
    % Main script
    tspan = [0 300]; % Time span
    I_0 = 100;
    N_total = 107000;
    N_0 = N_total - I_0;
    y0 = [N_0*0.20; N_0*0.15; N_0*0.40; N_0*0.25; I_0*0.25; I_0*0.25; I_0*0.25; I_0*0.25; 0; 0; 0; 0; 0; 0; 0; 0]; % Initial conditions
    
    % Solve the system of ODEs
    [t, y] = ode23(@myODE, tspan, y0);
    S_sum = y(:, 1) + y(:, 2) + y(:, 3) + y(:, 4);
    disp(size(S_sum))
    size(total_s)
    total_s = total_s + S_sum(end);
    I_sum = y(:, 5) + y(:, 6) + y(:, 7) + y(:, 8);
    total_i = total_i + sum(I_sum)/5;
    R_sum = y(:, 9) + y(:, 10) + y(:, 11) + y(:, 12);
    total_r = total_r + R_sum(end);
    D_sum = y(:, 13) + y(:, 14) + y(:, 15) + y(:, 16);
    total_d = total_d + D_sum(end);
    sum_of_sums = S_sum + I_sum + R_sum + D_sum;
    v = sum(v);
end
    %disp(total_d)
    %disp(total_i)
    disp("Deaths: " + total_d(end)/10)
    disp("Max I: " + max(total_i)/10)
   % total_infected = total_r(end) + total_i(end) + total_d(end) - 3000*(300/30);
   % disp("Total I: " + total_infected)
% Plot the results
% figure;
% hold on;
% plot(t, y(:, 1), 'b','Linewidth',2, 'DisplayName', 'S_1 (Susceptible 1)');
% plot(t, y(:, 2), 'g', 'Linewidth', 2, 'DisplayName', 'S_2 (Susceptible 2)');
% plot(t, y(:, 3), 'r', 'Linewidth', 2, 'DisplayName', 'S_3 (Susceptible 3)');
% plot(t, y(:, 4), 'c', 'Linewidth', 2, 'DisplayName', 'S_4 (Susceptible 4)');
% plot(t, y(:, 5), 'b--', 'Linewidth', 2, 'DisplayName', 'I_1 (Infected 1)');
% plot(t, y(:, 6), 'g--', 'Linewidth', 2, 'DisplayName', 'I_2 (Infected 2)');
% plot(t, y(:, 7), 'r--', 'Linewidth', 2, 'DisplayName', 'I_3 (Infected 3)');
% plot(t, y(:, 8), 'c--', 'Linewidth', 2, 'DisplayName', 'I_4 (Infected 4)');
% plot(t, y(:, 9), 'b:', 'Linewidth', 2, 'DisplayName', 'R_1 (Recovered 1)');
% plot(t, y(:, 10), 'g:', 'Linewidth', 2, 'DisplayName', 'R_2 (Recovered 2)');
% plot(t, y(:, 11), 'r:', 'Linewidth', 2, 'DisplayName', 'R_3 (Recovered 3)');
% plot(t, y(:, 12), 'c:', 'Linewidth', 2, 'DisplayName', 'R_4 (Recovered 4)');
% plot(t, y(:, 13), 'b-.', 'Linewidth', 2, 'DisplayName', 'D_1 (Dead 1)');
% plot(t, y(:, 14), 'g-.', 'Linewidth', 2, 'DisplayName', 'D_2 (Dead 2)');
% plot(t, y(:, 15), 'r-.', 'Linewidth', 2, 'DisplayName', 'D_3 (Dead 3)');
% plot(t, y(:, 16), 'c-.', 'Linewidth', 2, 'DisplayName', 'D_4 (Dead 4)');
% Validation


% % plot(t,sum_of_sums, 'Linewidth', 2, 'DisplayName', 'Sum of all graphs')
% plot(t,S_sum, 'Linewidth', 2, 'DisplayName', 'Sum of all S')
% plot(t,I_sum, 'Linewidth', 2, 'DisplayName', 'Sum of all I')
% plot(t,R_sum, 'Linewidth', 2, 'DisplayName', 'Sum of all R')
% plot(t,D_sum, 'Linewidth', 2, 'DisplayName', 'Sum of all D')
% % plot(t, y(:, 16), 'c-.', 'Linewidth', 2, 'DisplayName', 'D_4 (Dead 4)');
% sum(round(sum_of_sums - N_total)) % This sum should be equal to 0
% % plot(t, sum_of_sums, 'c-.', 'Linewidth', 2, 'Sum of sums');
% hold off;
% 
% xlabel('Time');
% ylabel('Population');
% title('SIR Model Dynamics');
% legend show;
% grid on;

