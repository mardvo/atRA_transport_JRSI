% Parameter variation
% Computes the cost function in the plane Lp-betaa

close all
clear all;


TopFolder = fileparts(pwd);
addpath(TopFolder+"/parameters/");


global_variables;

feeding = 1; % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choice between human (1) or mouse (2) parameters
species = 2;
if species == 1
    disp('Parameters set for human')
    disp(' ');
    parameters_h; % call the parameter file for human
elseif species == 2
    disp('Parameters set for mouse')
    disp(' ');
    parameters_m; % call the parameter file for mouse
else
    disp('No parameters set')
    return;
end
parameters_atra;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings

k_prods = 10.^linspace(-1,1,70)*atra_prod;
%k_prods = 10.^linspace(-1,1,70)*c3b;
k2s = 10.^linspace(-1,1,71)*k2;
[Par1,Par2]=meshgrid(k_prods,k2s);
toll = 1e-6;
npts = 400;
for i=1:length(k_prods)
    for j=1:length(k2s)
        disp(['i = ' num2str(i) '/' num2str(length(k_prods)) '  j = ' num2str(j) '/' num2str(length(k2s))]);
        
        atra_prod= Par1(j,i);
        %c3b= Par1(j,i);
        k2 = Par2(j,i);
        [x,p,dpdx,c2,dc2dx,c3,dc3dx,IOP] = solve_model3(toll,npts); % solve the system
        tot_atra_S(j,i) = trapz(x(npts/2+1:end),c3(npts/2+1:end))/(Ls);

    end
end

save('k1_k2_mouse.mat'),
