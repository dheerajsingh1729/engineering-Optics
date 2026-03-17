%Index_Eliiptical.m
clear
no=1.51; %no is the refractive index of the ordinary axis KDP
r63=10.6*10^-12; %Electro-optic coefficient (r63) of KDP
E=input('Applied electric field[V/m]=')%suggested value is 0.5*10^11
for n=1:2
    if n==1
        Ez=0;
    end
    if n==2
        Ez=E;
    end
    nx_p=no+(no^3)/2*r63*Ez;
    % Calculate the refractive index for the extraordinary axis
    ny_p = no - (no^3)/2 * r63 * Ez;

    %calculate the index ellipsed in the presence of applied electric field
    x_p=-nx_p:nx_p/1000:nx_p;%range of x'
    
    y1_P = ny_p * (ones(size(x_p)) - (x_p ./ nx_p).^2).^0.5; % Corrected closing parenthesis
    y2_P = -ny_p * (ones(size(x_p)) - (x_p ./ nx_p).^2).^0.5; % Corrected closing parenthesis
   %transform (x',y')to the (x,y) to the (x,y)
   x11=1/(2^0.5)*(x_p+y1_P);
   y11=-1/(2^0.5)*(x_p-y1_P);
   x12=1/(2^0.5)*(x_p+y2_P);
   y12=-1/(2^0.5)*(x_p-y2_P);
   if n==1
       figure(1)
       plot(x11,real(y11),'-')
       hold on
       plot(x12, real(y12), '-')
   end
   if n==2
       plot(x11, real(y11), '--')
       hold on
       plot(x12, real(y12), '--')
   end
end
text(-max(x11)*0.5,max(y11),['solid line: Ez=',num2str(0),'[V/m]']);
text(-max(x11)*0.5,max(y11)*0.9,['dotted line:Ez=',num2str(E),'[V/m]']);
axis square
hold off
xlabel('x')
ylabel('y')
title('Index Ellipses in KDP under Electric Field');