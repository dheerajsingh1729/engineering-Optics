function [detS, ri] = optics3(ro, do, z, f1, f2, d);
%this function is for output ray vector of a double lens 
%system
To = [1, do; 0,1];
Sf1=[1,0;(-1/f1) ,1];
Td = [1,d;0,1];
Sf2 = [1, 0; (-1/f2), 1];
Ti= [1,z;0,1];
S= Ti*Sf2*Td*Sf1*To;

%checking determinant for overall matrix
detS=det(S);
%"image " ray coordinates is ri
ri = S *ro;
