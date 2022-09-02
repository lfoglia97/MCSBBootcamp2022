function SSE = Calculate_SSE(parameters)

global time_points
global OD_measure_37_degree

exp_Data = OD_measure_37_degree;

SSE = 0;

lambda = parameters(1);
theta = parameters(2);
alpha = parameters(3);

dNdt = @(t,N) lambda*N*(1-(N/theta)^alpha);

N_0 = exp_Data(1);  %initial condition

[~,x] = ode45(dNdt,time_points,N_0);

for i=1:length(x)
    
    SSE = SSE + (x(i)-exp_Data(i)).^2;
    
    
end 

end

