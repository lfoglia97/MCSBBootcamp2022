% Parameters
c = -0.8;
d = 0.156;
low_limit = -2;
high_limit = 2;

nMax = 22; % max number of days to simulate

x = zeros(1,nMax); % first array
y = zeros(1,nMax); % second array
x(1) = 0.1; % initial condition for x
y(1) = 0.1; % initial condition for y

for n=2:nMax
    
    x(n) = x(n-1)^2 - y(n-1)^2 + c;
    y(n) = 2*x(n-1)*y(n-1) + d;
    
end % finished loop until nMax

% random number array generator

NStartingPoints = 1e5;

xStart = low_limit + (high_limit-low_limit).*rand(1,NStartingPoints);
yStart = low_limit + (high_limit-low_limit).*rand(1,NStartingPoints);

% test random number pairs

outside_box_array = zeros(1,NStartingPoints);

for j=1:length(xStart)
    
    x_rand = zeros(1,nMax);
    y_rand = zeros(1,nMax);
    
    x_rand(1) = xStart(j); % initial condition for x
    y_rand(1) = yStart(j); % initial condition for y
    
    outside_box_flag = 0;

    for n=2:nMax

        x_rand(n) = x_rand(n-1)^2 - y_rand(n-1)^2 + c;
        y_rand(n) = 2*x_rand(n-1)*y_rand(n-1) + d;

    end % finished loop until nMax
    
    if x_rand(nMax) < low_limit
        outside_box_flag = 1;
    elseif y_rand(nMax) < low_limit
        outside_box_flag = 1;
    elseif x_rand(nMax) > high_limit
        outside_box_flag = 1;
    elseif y_rand(nMax) > high_limit
        outside_box_flag = 1;
    elseif isnan(x_rand(nMax))
        outside_box_flag = 1;
    elseif isnan(y_rand(nMax))
        outside_box_flag = 1;
    end
    
    outside_box_array(j) = outside_box_flag;
    
    
end % finished loop for every pair (xStart,yStart)


% THE MODEL ^
% ------------------------------------------
% THE BEHAVIOR / THE OUTPUT ? 

% figure(1); 
% plot(x,'-ok');
% ylabel('x-array values')
% xlabel('Points')
% 
% figure(2)
% plot(x,y,'db')
% 
% figure(3)
% plot(xStart,yStart,'*')

% figure(4)
% for j=1:length(outside_box_array)
%     
%     if outside_box_array(j) == 0
%         plot(xStart(j),yStart(j),'ob','MarkerSize',2)
%     else
%         plot(xStart(j),yStart(j),'or','MarkerSize',2)
%     end
%     
%     hold on
%     
% end

figure(5)
for j=1:length(outside_box_array)
    
    if outside_box_array(j) == 0
        scatter(xStart(j),yStart(j),1,j)
    else
        scatter(xStart(j),yStart(j),1,[0 0 1])
    end
    
    hold on
    
end

