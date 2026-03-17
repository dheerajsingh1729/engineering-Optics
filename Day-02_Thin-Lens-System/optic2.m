function [detS, ri] = optic2(ro, do, f, z)
%this function is for output ray vector of 
%a single lens system
To= [1, do ;0,1];
Sf=[1,0;-(1/f), 1];
Ti= [1,z;0,1];
% Calculate the overall transformation matrix
S = Ti * Sf * To;
%checking determinant for overall matrix 
detS=det(S);
%"image" ray coordinate is ri
ri=S*ro;
