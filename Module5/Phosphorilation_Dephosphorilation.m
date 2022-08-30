%% PARAMETERS

k_A_on = 10;
k_A_off = 10;
k_I_on = 10;
k_I_off = 10;
k_A_cat = 100;
k_I_cat = 10;
P_tot = 1;
K_tot = 1;

parameters = [k_A_on, k_A_off, k_I_on, k_I_off, k_A_cat, k_I_cat, P_tot, K_tot];

%% SIMULATION

% x1 is [A]
% x2 is [AP]
% x3 is [I]
% x4 is [IK]

Ti = 0;
Tf = 1;

x1_0 = 0;
x2_0 = 0;
x3_0 = 1;
x4_0 = 0;

x0 = [x1_0; x2_0; x3_0; x4_0];

[t,x] = ode45(@(t,x)ODE_Model(t,x,parameters), [Ti Tf], x0);

%% PLOT

figure
title('Plot of concentrations vs. time')
hold on
plot(t,x,'LineWidth',2)
legend('[A]','[AP]','[I]','[IK]')
xlabel('Time [s]')
ylabel('Concentration [uM]')
grid


%% SWEEP IN PARAMETER K_tot

K_tot_inital = -3;  % = 10^(-3)
K_tot_final = 2;    % = 10^2

N_points = 100;

K_tot_vector = logspace(K_tot_inital, K_tot_final, N_points);

Ti = 0;
Tf = 1;

Activated_Protein_Tot_vector = [];

for i = 1:length(K_tot_vector)
    
    x1_0 = 0;
    x2_0 = 0;
    x3_0 = 100;
    x4_0 = 0;
    
    x0 = [x1_0; x2_0; x3_0; x4_0];
    
    K_tot = K_tot_vector(i);
    parameters = [k_A_on, k_A_off, k_I_on, k_I_off, k_A_cat, k_I_cat, P_tot, K_tot];
    
    [t,x] = ode45(@(t,x)ODE_Model(t,x,parameters), [Ti Tf], x0);

    Activated_Protein_Tot = x(end,1) + x(end,2);
    
    Activated_Protein_Tot_vector(i) = Activated_Protein_Tot;
    
end

figure
title('Sweep in parameter K_{tot}')
hold on
plot(K_tot_vector,Activated_Protein_Tot_vector,'LineWidth',2)
set(gca, 'XScale', 'log')
grid
xlabel('K_{tot}')
ylabel('[A] + [AP] at steady state')


