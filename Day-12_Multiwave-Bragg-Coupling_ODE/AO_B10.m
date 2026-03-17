%AO_B10.m
function dy=AO_B10(nz,y,options,d,a,Q)
dy = zeros(10, 1);
%-4<=m<=5
%d=delta
%nz=normalized z

%m=5 ->y(1)
%m=4 ->y(2)
%m=3 ->y(3)
%m=2 ->y(4)
%m=1 ->y(5)
%m=0 ->y(6)
%m=-1 ->y(7)
%m=-2 ->y(8)
%m=-3 ->y(9)
%m=-4 ->y(10)
dy(1) = -j*a/2*y(2)*exp(-j*Q/2*nz*(-(1+d)+9))+0;
dy(2) = -j*a/2*y(3)*exp(-j*Q/2*nz*(-(1+d)+7)) + -j*a/2*y(1)*exp(j*Q/2*nz*(-(1+d)+9));
dy(3) = -j*a/2*y(4)*exp(-j*Q/2*nz*(-(1+d)+5)) + -j*a/2*y(2)*exp(j*Q/2*nz*(-(1+d)+7));
dy(4) = -j*a/2*y(5)*exp(-j*Q/2*nz*(-(1+d)+3)) + -j*a/2*y(3)*exp(j*Q/2*nz*(-(1+d)+5));
dy(5) = -j*a/2*y(6)*exp(-j*Q/2*nz*(-(1+d)+1)) + -j*a/2*y(4)*exp(j*Q/2*nz*(-(1+d)+3));
dy(6) = -j*a/2*y(7)*exp(-j*Q/2*nz*(-(1+d)-1)) + -j*a/2*y(5)*exp(j*Q/2*nz*(-(1+d)+1));
dy(7) = -j*a/2*y(8)*exp(-j*Q/2*nz*(-(1+d)-3)) + -j*a/2*y(6)*exp(j*Q/2*nz*(-(1+d)-1));
dy(8) = -j*a/2*y(9)*exp(-j*Q/2*nz*(-(1+d)-5)) + -j*a/2*y(7)*exp(j*Q/2*nz*(-(1+d)-3));
dy(9) = -j*a/2*y(10)*exp(-j*Q/2*nz*(-(1+d)-7)) + -j*a/2*y(8)*exp(j*Q/2*nz*(-(1+d)-5));
dy(10) = 0 + -j*a/2*y(9)*exp(j*Q/2*nz*(-(1+d)-7));
return
% The function is complete; no additional steps are needed.