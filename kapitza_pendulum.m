% Kapitza pendulum

clc, clearvars, close all

% initial conditions

g = 9.80665;            % [ms^-2], gravitational acceleration
l = 1;                  % [m], pendulum lenght
T = 0.02;               % [s], oscillation period
omega = 2*pi/T;         % [1/s], support point frequency 
A = 0.2;                % [m], amplitude 
tf = 1;                 % [s], simulation time
N = 1000;               % number of time moments
t = linspace(0,tf,N);   % temporal discretization
dt = t(2)-t(1);         % temporal step
theta = zeros(1,N);     % memory preallocation

x = zeros(1,N);
y = zeros(1,N);

thetai = 5;             % [degree]; intial angle of the pendulum
x(1) = l*sin(thetai*pi/180);                % [rad]
y(1) = l*cos(thetai*pi/180);                % [rad]
theta(1) = thetai*pi/180;                   % [rad]
theta(2) = thetai*pi/180;                   % [rad]

const = g/l;                                % constant
constNepatratic = omega*A/l;                % constant
constPatratic = constNepatratic*omega;      % constant

for i=2:N-1             % the first element is theta 3

    theta(i+1) = 2*theta(i)-theta(i-1)-const*dt*dt*sin(theta(i))+constPatratic*dt*dt*cos(omega*dt*(i-1))*sin(theta(i));
    
    x(i) = l*sin(theta(i));
    y(i) = A*sin(omega*dt*i) + l*cos(theta(i));

end


% plots
figure (1); hold on
plot (t,theta*180/pi,'-','Color',[0 0.5 0])    % [degree] -> [rad]
title('Angle variation as function of time') 
grid on
xlabel('t(s)')
ylabel('\theta(dgr)')
legend('\theta (t) numerical value')

figure (2); hold on
plot (x,y,'-b')
title ("Pendulum coordinates");
grid on;
xlabel('x(m)');
ylabel('y(m)');
legend('with oscillation')