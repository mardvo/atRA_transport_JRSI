function [IOP,Qleak,Alb_leak,vel,Qu,c_alb,tot_atra, atra_S,tot_atra_S] = model(X)
global_variables;
warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings

Ks = X(1);
Lp = X(2);
betaa = X(3);
qrpe = X(4);
dP = X(5);
Deltap = X(6);
k2 = X(7);
atra_prod = X(8);
Ind_C50 = X(9);
c3b = X(10);
dummy = X(11);

c2b = c2b_fixed-c3b; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solution of the system of ODE's
try 
    toll = 1e-4;
    npts = 400;
    warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings
    [x,p,dpdx,c2,dc2dx,c3,dc3dx,IOP] = solve_model3(toll,npts); % solve the system


%% outputs 
a = vessel_distribution(x);
u=-dpdx; % water flux (note that the factor K_i/mu (i=c,s) has already been incorporated into dpdx)


% c4 = trapz(x,k2*c3)/Ls;

pb=IOP+dP;

c_alb = trapz(x(1:npts/2),c2(1:npts/2))/Lc;
Qleak = trapz(x,(Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2)- Lp*sigma*R*T*(c3b-c3)).*a);
Alb_leak = trapz(x,betaa*(c2b+c3b-c2-c3).*a)*Surf_A;
vel = u(end);
Qu = -((IOP-Pev)*C-Qprod);
tot_atra = trapz(x,c3)/(Ls+Lc);
atra_S = c3(end);
tot_atra_S = trapz(x(npts/2+1:end),c3(npts/2+1:end))/(Ls);
catch 
    IOP = NaN; Qleak = NaN; Alb_leak = NaN; vel = NaN; c_alb = NaN; tot_atra = NaN; Qu = NaN; atra_S = NaN; tot_atra_S  = NaN; 
end



