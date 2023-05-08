clear; close all;
%read in coordinates
a = readmatrix("a.csv"); %Noisy x
b = readmatrix("b.csv"); %Noisy y
x = readmatrix("x.csv"); %Real x
y = readmatrix("y.csv"); %Real y

z=[a; b]
z(:,1)
[px,py] = kalmanTracking(z);

%real coordinates
plot(x, y, 'xb');
hold on;
%noisy coordinates
plot(a, b, '+r');
hold on;
%predicted coordinates
plot(px,py, 'og')

legend("Real", "Noisy", "Predicted");
%%Predicted Error
error = calculateError(x,y,px,py);
rmse = sqrt(mean(error.^2));
disp ("Predicted Mean: "+mean(error));
disp ("Predicted Standard Deviation: "+std(error));
disp ("Predicted RMSE: "+rmse);

%%Noisy Error
error = calculateError(x,y,a,b);
rmse = sqrt(mean(error.^2));
disp ("Noisy Mean: "+mean(error));
disp ("Noisy Standard Deviation: "+std(error));
disp ("Noisy RMSE: "+rmse);