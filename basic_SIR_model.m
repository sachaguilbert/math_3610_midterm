close all; clc; clear;

N = 107e3;

S0 = N;
I0 = 200;
R0 = 0;
X = [S0, 0, I0, 0, R0, 0];

beta = 0.0001; % infection rate
gamma = 0.02; % recovery rate

dt = 0.01;
days = 300;
d = 0;
iterations = days/dt;
t = 0;
time = [t];

% x(1) = S
% x(2) = dS
% x(3) = I
% x(4) = dI
% x(5) = R
% x(6) = dR

for i = [1:days]
    x = zeros(1,6);
    n = X(end, :);
    dS = -beta * n(3) *n(1);
    dI = beta * n(3) *n(1) - gamma * n(3);
    dR = gamma * n(3);

    S = n(1) + dS*dt;
    I = n(3) + dI*dt;
    R = n(5) + dR*dt;

    x(1) = S;
    x(2) = dS;
    x(3) = I;
    x(4) = dI;
    x(5) = R;
    x(6) = dR;
%     X
%     x
    X = [X ; x];

    t = t + dt;
    time = [time i];
end

hold on
plot(time, X(:, 1),'Linewidth',2);
plot(time, X(:, 3),'Linewidth',2);
plot(time, X(:, 5),'Linewidth',2);
plot(time, X(:, 1) + X(:, 3) + X(:, 5),'Linewidth',2);
yline(N,'Linewidth',2);
grid on;
xlabel("Time in days");
legend("S","I","R", "Sum of S, I and R");
