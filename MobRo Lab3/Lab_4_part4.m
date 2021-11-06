clear all, close all, clc

syms x y x_m y_m th v w
%% Observability study with 2 magnets Known in 00 and 01
%% 2 Measurements

%g1= cos(th) * (x_m - x) + sin(th)*(y_m - y);
%g2= cos(th) * (y_m - y) - sin(th)*(x_m - x);

%for the magnets in (x_m, y_m) = (0,0) and (0,1)

gx_00= cos(th) * (- x) + sin(th)*(- y);
gy_00= cos(th) * (- y) - sin(th)*(- x);
gx_10= cos(th) * (1-x) + sin(th)*(- y);
gy_10= cos(th) * (- y) - sin(th)*(1-x);

%find the gradient w.r.t. the state variables
dgx_00 = gradient(gx_00, [x, y, th]);
dgy_00 = gradient(gy_00, [x, y, th]);
dgx_10 = gradient(gx_10, [x, y, th]);
dgy_10 = gradient(gy_10, [x, y, th]);

f =  [v * cos(th);
      v * sin(th);
      w];
%% Case1
O1 = [dgx_00, dgy_00, dgx_10];

detO1 = simplify(det(O1))
%% Case 2
O2 = [ dgy_00, dgx_10,  dgy_10 ];

detO2 = simplify(det(O2))

O3 = [dgx_00, dgx_10, dgy_10];

detO3 = simplify(det(O3))
%Enough to look at the measurements, not the state, no dependence on U and
%X (our case is f).F is not used, only g is used!

%% Lie Derivatives

%% Consider only the Y measurements and not the x measurement. 
Lfgy_00 = dgy_00.'*f;
Lfgy_10 = dgy_10.'*f;

dLfgy_00 = gradient(Lfgy_00, [x, y, th]);
dLfgy_10 = gradient(Lfgy_10, [x, y, th]);

O3 = [ dgy_00, dgy_10,  dLfgy_00 ];

detO3 = simplify(det(O3))

O4 = [ dgy_00, dgy_10,  dLfgy_10 ];

detO4 = simplify(det(O4))

%Here it depends on w, there is a dependence on both g and f
%I make the cosine disappear
ddLfgy_00 = gradient(dLfgy_00.'*f, [x, y, th]);
ddLfgy_10 = gradient(dLfgy_10.'*f, [x, y, th]);

O5 = [ dLfgy_00, dLfgy_10,  ddLfgy_00 ];

detO5 = simplify(det(O5))