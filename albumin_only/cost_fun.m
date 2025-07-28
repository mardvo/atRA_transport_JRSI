function cost = cost_fun(pars)

global R T D2 c2b mu Kc Lc Ls qrpe p0 Ks pb Lp D2s sigma betaa c2o dP Pev Qprod Qu C R_eye Surf_A IOP_e c_alb_e alb_prod_e Deltap

toll = 1e-4;
npts = 400;

warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings


betaa = pars(1)
Lp = pars(2)


[x,p,dpdx,c2,dc2dx,IOP] = solve_model3(toll,npts); % solve the system


a = vessel_distribution(x);

c_alb = trapz(x(npts/2+1:end),c2(npts/2+1:end))/(Ls); % albumin in the sclera
alb_prod = trapz(x,betaa*(c2b-c2).*a)*Surf_A;
Qu = -((IOP-Pev)*C-Qprod);

%cost = abs(IOP-IOP_e)^2/IOP_e^2+10*abs(c_alb-c_alb_e)^2/c_alb_e^2+abs(alb_prod-alb_prod_e)^2/alb_prod_e^2 + abs(Qu-Qprod*0.2)^2/(Qprod*0.2)^2
cost = abs(IOP-IOP_e)^2/IOP_e^2*2+abs(c_alb-c_alb_e)^2/c_alb_e^2+ abs(Qu-Qprod*0.2)^2/(Qprod*0.2)^2+max((dP+Deltap-R*T*(c2b-c2(1))),0)
