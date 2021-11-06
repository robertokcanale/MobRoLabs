% Set the parameters which have the "Determined by student" comment to tune
% the Kalman filter. Do not modify anything else in this file.

% Uncertainty on initial position of the robot.

%i need to do the tuning at 20Hz
%Assume Gaussian Distribution
%Rembember rule of thumb:MAX ERROR = SIGMA*3
sigmaX     =  4 ;         % Determined by student max error of 1.2 cm (12mm)
sigmaY     = 4 ;         % Determined by student max error of 1.2 cm (12mm)
sigmaTheta = 4*pi/180 ;         % Determined by student max error of 12 degrees in degrees
Pinit = diag( [sigmaX^2 sigmaY^2 sigmaTheta^2] ) ;


% Measurement noise.
%Max Variance per .txt
%line2magnets = 21mm but often 20mm
%1line1magnet = 18mm
%for one crossing distribution is uniform -> we use uniform distribution,
%slightly overestimated but reasonable (maybe with more crossing it could
%be gaussian). Overall it is not uniformly distributed, but we could take
%the uniform distribution over the WORST CASE, maybe slighly overestimated
%but safe design and also avoid overstimations 

sigmaXmeasurement = 10*sqrt((20^2)/12) ;  % Determined by student
sigmaYmeasurement = 10*sqrt((10^2)/12) ;  % Determined by student
Qgamma = diag( [sigmaXmeasurement^2 sigmaYmeasurement^2] ) ;


% Input noise

sigmaTuning = 0.15; 
fprintf('SigmaTuning: %f %%\n',sigmaTuning);
Qwheels = sigmaTuning^2 * eye(2) ;
Qbeta   = jointToCartesian * Qwheels * jointToCartesian.' ; 

% State noise
 
Qalpha = zeros(3) ;

% Mahalanobis distance threshold

mahaThreshold = sqrt(chi2inv(0.95,2));  % Determined by student, enrico does  chi2inv( 0.95 , 2 ) ; Input = probabilità dei valori che voglio tenere, Output = i valori che tengo
 %I choose a 95% confidence interval
