close all; clc; clear;

N = 107000;

S1 = N*0.20; % First group of suseptible poeple
S2 = N*0.35; % Second group
S3 = N*0.30; % Third group
S4 = N*0.15; % Fourth group

I1 = 50; % Infected people in group 1
I2 = 25; % group 2
I3 = 25; % group 3
I4 = 25; % group 4

R1 = 0;
R2 = 0;
R3 = 0;
R4 = 0;

D1 = 0; % Deaths for group 1
D2 = 0; % group 2
D3 = 0; % group 3
D4 = 0; % group 4

X = [S1,S2,S3,S4, I1,I2,I3,I4, R1,R2,R3,R4, D1, D2, D3, D4];

% infection rates
beta1 = 0.0002;
beta2 = 0.00008;
beta3 = 0.00008;
beta4 = 0.00004;
% recovery rates
gamma1 = 0.4;
gamma2 = 0.2;
gamma3 = 0.1;
gamma4 = 0.05;

% death rates
alpha1 = 0.001;
alpha2 = 0.002;
alpha3 = 0.005;
alpha4 = 0.010;

V = 3000; % Vaccines per month

dt = 0.01;
days = 300;
d = 0;
iterations = days/dt;
t = 0;
time = [t];

for i = [1:days]
    x = zeros(1,6);
    n = X(end, :);
%     dS = -beta * n(3) *n(1);
%     dI = beta * n(3) *n(1) - gamma * n(3);
%     dR = gamma * n(3);
    I_sum = n(5) + n(6) + n(7) + n(8);
    dS1 = -beta1 * I_sum * n(1);
    dS2 = -beta2 * I_sum * n(2);
    dS3 = -beta3 * I_sum * n(3);
    dS4 = -beta4 * I_sum * n(4);

    dI1 = beta1 * I_sum * n(1) - gamma1 * n(5);
    dI2 = beta2 * I_sum * n(2) - gamma2 * n(6);
    dI3 = beta3 * I_sum * n(3) - gamma3 * n(7);
    dI4 = beta4 * I_sum * n(4) - gamma4 * n(8);

    dR1 = gamma1 * n(5);
    dR2 = gamma2 * n(6);
    dR3 = gamma3 * n(7);
    dR4 = gamma4 * n(8);

    S1 = n(1) + dS1 * dt;
    S2 = n(2) + dS2 * dt;
    S3 = n(3) + dS3 * dt;
    S4 = n(4) + dS4 * dt;

    I1 = n(5) + dI1 * dt - alpha1*n(5);
    I2 = n(6) + dI2 * dt - alpha1*n(6);
    I3 = n(7) + dI3 * dt - alpha1*n(7);
    I4 = n(8) + dI4 * dt - alpha1*n(8);

    R1 = n(9) + dR1 * dt;
    R2 = n(10) + dR2 * dt;
    R3 = n(11) + dR3 * dt;
    R4 = n(12) + dR4 * dt;

    D1 = D1 + alpha1*n(5);
    D2 = D2 + alpha1*n(6);
    D3 = D3 + alpha1*n(7);
    D4 = D4 + alpha1*n(8);

    x(1) = S1;
    x(2) = S2;
    x(3) = S3;
    x(4) = S4;

    x(5) = I1;
    x(6) = I2;
    x(7) = I3;
    x(8) = I4;

    x(9) = R1;
    x(10) = R2;
    x(11) = R3;
    x(12) = R4;

    x(13) = D1;
    x(14) = D2;
    x(15) = D3;
    x(16) = D4;
    X = [X ; x];

    t = t + dt;
    time = [time i];
end

hold on
plot(time, X(:, 1),'Linewidth',2,'color','blue');
plot(time, X(:, 2),'Linewidth',2,'color','red');
plot(time, X(:, 3),'Linewidth',2,'color','yellow');
plot(time, X(:, 4),'Linewidth',2,'color','green');

plot(time, X(:, 5),'--','Linewidth',2,'color','blue');
plot(time, X(:, 6),'--','Linewidth',2,'color','red');
plot(time, X(:, 7),'--','Linewidth',2,'color','yellow');
plot(time, X(:, 8),'--','Linewidth',2,'color','green');

plot(time, X(:, 9),'-.','Linewidth',2,'color','blue');
plot(time, X(:, 10),'-.','Linewidth',2,'color','red');
plot(time, X(:, 11),'-.','Linewidth',2,'color','yellow');
plot(time, X(:, 12),'-.','Linewidth',2,'color','green');

plot(time, X(:, 13),':','Linewidth',2,'color','blue');
plot(time, X(:, 14),':','Linewidth',2,'color','red');
plot(time, X(:, 15),':','Linewidth',2,'color','yellow');
plot(time, X(:, 16),':','Linewidth',2,'color','green');

legend("S1","S2","S3","S4","I1","I2","I3","I4","R1","R2","R3","R4","D1","D2","D3","D4")
grid on

% plot(time, X(:, 1) + X(:, 3) + X(:, 5),'Linewidth',2);
% yline(N,'Linewidth',2);
% grid on;
% xlabel("Time in days");
% legend("S","I","R", "Sum of S, I and R");
