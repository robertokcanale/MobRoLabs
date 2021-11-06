% EvolutionModel: use the generic evolution model to predict X at instant
% (k+1) given X and U at instant k (using hodometry)

function Xodom = EvolutionModel(Xodom,U)
%% Description
%U is the inpt linear and angular velocity [v, w]
%Xodom is the current position established by odomotry. The starting point
%(hence the starting Xodom) is established at the beginning of
%ShowOdometry.m 
%This function outputs the predicted odometry state at the next time
%instant.
%U1=deltaD U2=deltatheta

%% Current Values of the states
x = Xodom(1,:);
y = Xodom(2,:);
theta = Xodom(3,:);

%% Evolution Model
X_plus1 = x + cos(theta)*U(1); 
Y_plus1 = y + sin(theta)*U(1);

theta_plus1 = theta + U(2);

Xodom = [X_plus1, Y_plus1, theta_plus1].';

end

