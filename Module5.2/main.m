%% model parameters
eps = 0.08;
a = 1.0;
b = 0.2;

%% model definition
I_0 = 1.0;          % injected current
T_start = 40;
T_stop = 47;
I = @(t) I_0 * (sign((t-T_start)) - sign(t-T_stop))/2;

D = 0.9;    % electrical connectivity

f = @(t,v,w,k,l) v - 1/3*v.^3 - w + D*(k - 2*v + l);
g = @(v,w) eps*(v + a -b*w);


%% simulation
dxdt =@ (t,x) [f(t,x(1),x(2),x(11),x(3)); g(x(1),x(2));
               f(t,x(3),x(4),x(1),x(5)); g(x(3),x(4));
               f(t,x(5),x(6),x(3),x(7)); g(x(5),x(6));
               f(t,x(7),x(8),x(5),x(9)) + I(t); g(x(7),x(8));
               f(t,x(9),x(10),x(7),x(11)); g(x(9),x(10));
               f(t,x(11),x(12),x(9),x(13)); g(x(11),x(12));
               f(t,x(13),x(14),x(11),x(15)); g(x(13),x(14));
               f(t,x(15),x(16),x(13),x(17)); g(x(15),x(16));
               f(t,x(17),x(18),x(15),x(19)); g(x(17),x(18));
               f(t,x(19),x(20),x(17),x(1)); g(x(19),x(20))]; 

v_initial = -1.1298;
w_initial = -0.6491;

% solve!
% [T,X] = ode45(dxdt,[0, 100], [v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial ...
%                               v_initial, w_initial]);

[T,X] = ode45(dxdt,[0, 100], rand(20,1));

% plot
figure
title('Electrical Potential (v) and Ion Pumps Activity (w)')
hold on
plot(T,X,'LineWidth',2)
grid
xlabel('Time [non dimensional]')
ylabel('Non-dimensional')
figure
hold on
title('Current Injected')
plot(T,I(T),'LineWidth',2)
grid
xlabel('Time [non dimensional]')
ylabel('Non-dimensional')

%% movie
for nt=1:numel(T)
figure(5); clf; hold on; box on;
plot(X(nt,1:2:19));
set(gca,'ylim', [-2.5,2.5])
xlabel('Cell');
ylabel('Voltage')
drawnow;
end



