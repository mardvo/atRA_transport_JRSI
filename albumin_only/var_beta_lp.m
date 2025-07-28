% parameter variationclose all
close all;
clear all;

TopFolder = fileparts(pwd);
addpath(TopFolder+"/parameters/");

global_variables;
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

toll = 1e-4;
npts =400;

warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings

betas = linspace(0.5,2,30)*betaa;
Lps = linspace(0.5,2,30)*Lp;



for i=1:length(betas)
    for j=1:length(Lps)
        i
        j
    betaa=betas(i);
    Lp = Lps(j);
    [x,p,dpdx,c2,dc2dx,IOP] = solve_model3(toll,npts); % solve the system
    a = (1-1./(1+exp(-50*(x-Lc/5)/Lc)))*5;
    
    vel(i,j) = -dpdx(end);
    IOPs(i,j)=IOP;
    c_alb(i,j) = c2(end);
    pb=IOP+dP;
    alb_prod(i,j) = trapz(x,betaa*(c2b-c2).*a)*Surf_A;
    Qu(i,j) = -((IOP-Pev)*C-Qprod);
    end
end

[BETA,LP]=meshgrid(betas,Lps);
save('beta_lp_mouse.mat')
cost = abs(IOPs-IOP_e).^2/IOP_e^2+abs(c_alb-c_alb_e).^2/c_alb_e^2+0*abs(alb_prod-alb_prod_e).^2/alb_prod_e^2 + abs(Qu-Qprod*0.2).^2/(Qprod*0.2)^2;

figure
contourf(BETA,LP,cost,100)
colorbar
ylabel('Lp, 1/s/Pa')
xlabel('beta, 1/s')
set(gca,'FontSize',14);


figure;
subplot(2,2,1)
contourf(BETA,LP,IOPs,50)
hold on 
colorbar
%plot([Lc Lc]*10^6,[0 max(p)/133]*1.1,'k--')
ylabel('Lp, 1/s/Pa')
xlabel('beta, 1/s')
title('IOP, mmHg')
set(gca,'FontSize',14);

subplot(2,2,2)
contourf(BETA,LP,c_alb/c2b)
hold on 
colorbar
ylabel('Lp, 1/s/Pa')
xlabel('beta, 1/s')
title('c_alb/c2b')
set(gca,'FontSize',14);

subplot(2,2,3)
contourf(BETA,LP,alb_prod/alb_prod_e)
hold on 
colorbar
ylabel('Lp, 1/s/Pa')
xlabel('beta, 1/s')
title('alb_prod')
set(gca,'FontSize',14);

subplot(2,2,4)
contourf(BETA,LP,Qu/Qprod)
hold on 
colorbar
ylabel('Lp, 1/s/Pa')
xlabel('beta, 1/s')
title('Qu/Qprod')
set(gca,'FontSize',14);

