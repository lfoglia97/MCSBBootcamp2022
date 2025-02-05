function [dxdt] = ODE_Model(~, x, parameters)

x1 = x(1);   % x1 is [A]
x2 = x(2);   % x2 is [AP]
x3 = x(3);   % x3 is [I]
x4 = x(4);   % x4 is [IK]

k_A_on = parameters(1);
k_A_off = parameters(2);
k_I_on = parameters(3);
k_I_off = parameters(4);
k_A_cat = parameters(5);
k_I_cat = parameters(6);
P_tot = parameters(7);
K_tot = parameters(8);


dx1dt = -k_A_on*(P_tot - x2)*x1 + k_A_off*x2 + k_A_cat*x4;

dx2dt = k_A_on*(P_tot - x2)*x1 - k_A_off*x2 - k_I_cat*x2;

dx3dt = -k_I_on*(K_tot - x4)*x3 + k_I_off*x4 + k_I_cat*x2;

dx4dt = k_I_on*(K_tot - x4)*x3 - k_I_off*x4 - k_A_cat*x4;

dxdt = [dx1dt; dx2dt; dx3dt; dx4dt];


end

