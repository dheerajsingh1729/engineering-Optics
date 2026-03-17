%helix.m
%plotting eq. (1.3-27)
clear
nxo= input('n(xo) = ');
n2= input('n2 = ');
alpha = input('alpha[radian] = ');
zin= input('start point of z in micrometer = ');
zfi = input('end point of z in micrometer= ');
beta = nxo*cos(alpha);
z = zin:(zfi-zin)/1000:zfi;
xo = beta*tan(alpha)/(n2^0.5);
x= xo*cos((n2^0.5)*z/beta);
y = xo*sin(n2^0.5)*z/beta;
plot3(z, y, x);
title('helix ray propagation');
xlabel(' z in micrometer');
ylabel('y in micrometer');
zlabel('x in micrometer');
grid on;
sprintf('%f [micrometer]' , xo)
view(-37.5+68,30)
%n(xo) = 1.5
%n2 = 0.001
%alpha [radian] = 0.5 
%start point of z in micrometer = 0
%end pont of z in micormeter = 1000
%ans= 22.741150[micrometer]
