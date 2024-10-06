close all;clc;clear;

K1 = 107e3;
K2 = K1;
vaccination_rate = 3000;


p1_0 = 1;
p2_0 = 1;
p1_dot_0 = 0;
p2_dot_0 = 0;

P = [p1_0, p1_dot_0, p2_0, p2_dot_0];

r = 0.09;
dt = 0.01;
days = 300;
iterations = days/dt;
t = 0;
time = [t];

for i = [1:iterations]
    p = zeros(4,1);
    state = P(end, :);

%     First population is modelled as yp = r*y*(1 - y/K)
    p(2) = r*state(1)*(1 - state(1)/K1); % first derivative of pop 1
%     First population is modelled as yp = r*y*(1 - y/K), but here K is a linearly decreasing function
    p(4) = r*state(3)*(1 - state(3)/K2); % first derivative of pop 2
    if p(4) < 0
        p(4) = 0;
    end
    if K2 < 1
        p(4) = 0;
    end
    p(1) = state(1) + p(2)*dt;
    p(3) = state(3) + p(4)*dt;

%     disp("p1: "+ p(1));
%     disp("p1_dot: "+ p(2));
%     disp("p2: "+ p(3));
%     disp("p2_dot: "+ p(4));
%     disp(" ");
    P = [P; p'];

    K2 = K2 - vaccination_rate*dt/30;
    t = t + dt;
    time = [time; t];
end

hold on
plot(time,P(:,1),'Linewidth',3,'color','blue')
plot(time,P(:,3),'Linewidth',3,'color','red')
plot(time,P(:,2),'--','Linewidth',2,'color','blue')
plot(time,P(:,4),'--','Linewidth',2,'color','red')
grid on
title("Evolution of infections amongst a population")


xlabel("Time in days")
ylabel("Infected population")
legend("No vaccines", "0.5 vaccines per iterations", "Infection rate for no vaccines", "Infection rate for vaccinated pop")
