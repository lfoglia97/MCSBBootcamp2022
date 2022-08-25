%%%%% DISCRETE LOGISTIC GROWTH %%%%%

% 'x' is the number of rabbits measured in thousands

%% Parameters
r = 2.5; % per-capita growth rate
K = 0.6; % carrying capacity

nMax = 1000; % maximum time point [months]

%% Simulation from one initial condition 

x = zeros(1,nMax); % vector for rabbit population for each time point
x(1) = 0.2; % initial condition

for n=2:nMax
    
    x(n) = x(n-1) + r*(1 - x(n-1)/K)*x(n-1);
    
end


%% Simulation from 'N' random initial condition
N = 1;
xStart = 0.8*rand(1,N); % N random initial conditions

figure
for j=1:length(xStart)
    x = zeros(1,nMax);
    x(1) = xStart(j);
    
    for n=2:nMax
    
        x(n) = x(n-1) + r*(1 - x(n-1)/K)*x(n-1);
    
    end
    
    plot(x,'-*')
    hold on
    
end

%% Sweep in parameter 'r'
low_limit = 0;
high_limit = 3;
resolution = 0.1;

figure
hold on

for j=low_limit:resolution:high_limit
    
    r = j;
    x = zeros(1,nMax);
    x(1) = 0.2;
    
    for n=2:nMax
        
        x(n) = x(n-1) + r*(1 - x(n-1)/K)*x(n-1);
    
    end
    
    for i=1:nMax/2
        plot(j,x(i+nMax/2),'*')
    end
        
end



