% Specifies the cost function for the codes that optimise parameter values
% The 4 target values used are specified in the parameter files
function cost = cost_fun_atra1(pars)

global_variables;

toll = 1e-6;
npts = 400;

warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings

%% feeding

atra_prod = pars(1) % uncomment for non-feeding
%k2 = pars(1); % uncomnnet for feeding

[x,p,dpdx,c2,dc2dx,c3,dc3dx,IOP] = solve_model3(toll,npts); % solve the system

atra_tot = trapz(x,c3)/(Lc+Ls);

cost2 = (atra_tot-c3_exp_nf).^2./c3_exp_nf.^2; % uncomment for feeding
%cost2 = (atra_tot-c3_exp_f).^2./c3_exp_f.^2; % uncomment for feeding
w2 = 1;
cost = w2*cost2 

disp(['Value of the cost function: ' num2str(cost)]);
disp([' ']);
end