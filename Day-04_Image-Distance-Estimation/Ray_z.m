function [z_est, M] = Ray_z(do, f, Zs, Zf, dz);
%this function is for searching image distance of the single
%lens system
To =[1,do;0,1];
Sf=[1, 0; -(1/f),1];

ro=[0;1];
n=0;
for z=Zs:dz:Zf
    n=n+1;
    Z1(n)=z
    Ti=[1,z;0,1];
    S=Ti*Sf*To;
    %"image" ray coordinates is ri
    ri = S * ro; % Calculate the image ray coordinates
    Ri(n)= ri(1,1);
end
[M, N]=min(abs(Ri));
z_est = Z1(N); % Estimate the image distance based on the minimum index