%Bragg_regime_10.m
%Bragg regime involing 10 diffarcted orders
clear
d=input('delta=-incident angle/Bragg angle -1(enter 0 for exact Bragg angle incidence)=?')
Q=input('Q=(K^2*L)/ko(enter a large number,say 100,to get close to ideal bragg diffraction)=')
n=0;

for al=0:0.01*pi:8
    n=n+1;
    AL(n)=al;
    [nz,y]=ode45('AO_B10',[0 1],[0 0 0 0 0 1 0 0 0 0],[],d,al,Q);
    [M1 N1]=size(y(:,1));
    [M2 N2]=size(y(:,2));
    [M3 N3]=size(y(:,3));
    [M4 N4]=size(y(:,4));
    [M5 N5]=size(y(:,5));
    [M6 N6]=size(y(:,6));
    [M7 N7]=size(y(:,7));
    [M8 N8]=size(y(:,8));
    [M9 N9]=size(y(:,9));
    [M10 N10]=size(y(:,10));
    psn2(n)=y(M8,8);
    psn1(n)=y(M7,7);
    ps0(n)=y(M6,6);
    ps1(n)=y(M5,5);
    ps2(n)=y(M4,4);
    I(n)=y(M1,1).*conj(y(M1,1))+y(M2,2).*conj(y(M2,2))+y(M3,3)*conj(y(M3,3))+y(M4,4)*conj(y(M4,4))+y(M5,5)*conj(y(M5,5))+y(M6,6)*conj(y(M6,6))+y(M7,7)*conj(y(M7,7))
    +y(M8,8)*conj(y(M8,8))+y(M9,9)*conj(y(M9,9))+y(M10,10)*conj(y(M10,10));
end
figure(1)
plot(AL,ps0.*conj(ps0),'-',AL,ps1.*conj(ps1),'-',...
    AL,psn1.*conj(psn1),'-',AL,ps2.*conj(ps2),'--')
title('Bragg regime')
xlabel('alpha')
axis([0 8 -0.1 1.1])
legend('0 order','1 order','-1 order','2 order')
grid on

    
    
    
    
    