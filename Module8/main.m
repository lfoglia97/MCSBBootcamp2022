%% EXPERIMENTAL DATA

global time_points
global OD_measure_37_degree

time_points = 0:8;
%time_points = time_points*20;
time_points = time_points';

OD_measure_room_temp = [0.07, 0.065, 0.067, 0.12, 0.075, 0.08, 0.082, 0.087, 0.1]';

OD_measure_37_degree = [0.068, 0.07, 0.121, 0.235, 0.279, 0.373, 0.504, 0.68, 0.802];

%% PARAMETERS

% lambda = 1.0;
% theta = 0.5;
% alpha = 0.5;

lambda = optimal_parameter(1);
theta = optimal_parameter(2);
alpha = optimal_parameter(3);

parameters = [lambda, theta, alpha];

%% MODEL

dNdt = @(t,N) lambda*N*(1-(N/theta)^alpha);

%% SIMULATE

% Ti = 0;
% Tf = 160;

N_0 = OD_measure_room_temp(1);  %initial condition

[t,x] = ode45(dNdt,time_points,N_0);

%% PLOT

figure
hold on
title('Bacterial Growth Curve Model')
plot(t,x,'LineWidth',2)
axis([time_points(1) time_points(end) 0 max(x)*1.1])
grid
xlabel('Time [min]')
ylabel('# Bacteria')
legend('Model')

figure
hold on
title('Experimental Data')
plot(time_points,OD_measure_room_temp,'LineWidth',2)
plot(time_points,OD_measure_37_degree,'LineWidth',2)
grid
xlabel('Time [min]')
ylabel('OD Measurements')
legend('room temp','37 °C')

figure
hold on
title('Comparison Experimental Data vs. Model')
plot(time_points,OD_measure_37_degree,'LineWidth',2)
plot(time_points,x,'-o','LineWidth',2)
grid
xlabel('Time [min]')
ylabel('OD Measurements')
legend('room temp','37 °C')


%% SUM OF SQUARED ERROR

SSE = 0;

for i=1:length(x)
    
    SSE = SSE + (x(i)-OD_measure_37_degree(i))^2;
    
    
end

disp(' ')
display(['The SSE is between model and Exp Data at 37 °C is: ', num2str(SSE)])
disp(' ')

%% CALCULATE SSE FUNCTION

SSE = Calculate_SSE(parameters);

disp(' ')
display(['The SSE is between model and Exp Data at 37 °C is: ', num2str(SSE)])
disp(' ')

%% MINIMIZATION ALGORITHM

optimal_parameter = fminsearch(@Calculate_SSE,parameters);

