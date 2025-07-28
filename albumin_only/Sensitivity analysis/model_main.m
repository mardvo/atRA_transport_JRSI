function [IOP,Qleak,Alb_leak,vel,Qu,c_alb] = model_main(X)
global_variables;

warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings



Ks = X(1);
Lp = X(2);
betaa = X(3);
qrpe = X(4);
dP = X(5);
Deltap = X(6);
dummy = X(7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solution of the system of ODE's
try 
    toll = 1e-4;
    npts = 400;
    warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings
    [x,p,dpdx,c2,dc2dx,IOP] = solve_model3(toll,npts); % solve the system

%% outputs 
a = vessel_distribution(x);
u=-dpdx; % water flux (note that the factor K_i/mu (i=c,s) has already been incorporated into dpdx)

pb=IOP+dP;

c_alb = trapz(x,c2)/(Lc+Ls);
Qleak = trapz(x,(Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2)).*a);
Alb_leak = trapz(x,betaa*(c2b-c2).*a)*Surf_A;
vel = u(end);
Qu = -((IOP-Pev)*C-Qprod);
catch 
    IOP = NaN; Qleak = NaN; Alb_leak = NaN; vel = NaN; c_alb = NaN; Qu = NaN;
end





