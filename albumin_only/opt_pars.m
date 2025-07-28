%%% optimisation problem 

close all
clear all;

TopFolder = fileparts(pwd);
addpath(TopFolder+"/parameters/");

global_variables;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choice between human (1) or mouse (2) parameters
species =2;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solution of the system of ODE's
toll = 1e-4;
npts = 400;

pp = fmincon(@cost_fun,[betaa,Lp],[],[],[],[],[betaa/10,Lp/10],[betaa*10,Lp*10])

betaa=pp(1);
Lp=pp(2);

[x,p,dpdx,c2,dc2dx,IOP] = solve_model3(toll,npts); % solve the system
u=-dpdx; % note that the factor K_i/mu (i=c,s) has already been incorporated into dpdx



figure;
subplot(2,2,1)
plot(x*10^6,p/133,'Linewidth',2)
hold on 
%plot([Lc Lc]*10^6,[0 max(p)/133]*1.1,'k--')
xlim([0 Lc+Ls]*1e+6)
ylabel('pressure, mmHg')
xlabel('x, \mum')
set(gca,'FontSize',14);

subplot(2,2,2)
plot(x*10^6,c2,'Linewidth',2)
hold on 
xlim([0 Lc+Ls]*1e+6)
ylabel('Albumin, mM')
xlabel('x, \mum')
set(gca,'FontSize',14);

subplot(2,2,3)
plot(x*10^6,-dpdx,'Linewidth',2)
hold on 
%plot([Lc Lc]*10^6,[0 max(p)/133]*1.1,'k--')
%xlim([0 Lc+Ls]*1e+6)
ylabel('Velocity, m/s')
xlabel('x, \mum')
set(gca,'FontSize',14);

subplot(2,2,4)
plot(x*10^6,-dpdx.*c2,'Linewidth',2)
hold on 
plot(x*10^6,[-dc2dx(1:npts/2)*D2c,-dc2dx(npts/2+1:end)*D2s],'Linewidth',2)
ylabel('fluxes, m/s')
legend('advection','diffusion')
xlabel('x, \mum')
set(gca,'FontSize',14);
%% outputs
a = vessel_distribution(x);

pb=IOP+dP;

figure
plot(x*10^6,(Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2)).*a,'Linewidth',2)
hold on 
ylabel('water flux out of the vessels, 1/s')
xlabel('x, \mum')
set(gca,'FontSize',14);

Qleak = trapz(x,(Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2)).*a);
Alb_leak = trapz(x,betaa*(c2b-c2).*a)*Surf_A;
vel = u(end);
Qu = -((IOP-Pev)*C-Qprod);
c_alb = trapz(x,c2)/(Ls+Lc);

% Sample data
variable = {'IOP, mmHg', 'c_A/c_b', 'V_s, m/s','Q_leak, m/s','Q_u/Qprod, %','Alb_leak, mol/s'};
value = [IOP/133, c_alb/c2b, vel, Qleak, Qu/Qprod*100, Alb_leak];

% Create a table
Tt = table(variable', value', 'VariableNames', {'Variable', 'Value'});
% Display the table
disp(' ');
disp(Tt);
%save('opt_beta_lp.mat')