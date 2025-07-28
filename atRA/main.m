% main 
close all
clear all;

TopFolder = fileparts(pwd);
addpath(TopFolder+"/parameters/");


global_variables;

feeding = 0; % 1 for 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choice between human (1) or mouse (2) parameters
species = 1;
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
% solution of the system of ODE's
toll = 1e-6;
npts = 400;
warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings
[x,p,dpdx,c2,dc2dx,c3,dc3dx,IOP] = solve_model3(toll,npts); % solve the system

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% outputs

a = vessel_distribution(x);
u=-dpdx; % water flux (note that the factor K_i/mu (i=c,s) has already been incorporated into dpdx)
q_SA=[(u(1:npts/2+1).*c2(1:npts/2+1)-dc2dx(1:npts/2+1)*D2c),(u(npts/2+2:end).*c2(npts/2+2:end)-dc2dx(npts/2+2:end)*D2s)];
q_atRASA=[(u(1:npts/2+1).*c3(1:npts/2+1)-dc3dx(1:npts/2+1)*D3c),(u(npts/2+2:end).*c3(npts/2+2:end)-dc3dx(npts/2+2:end)*D3s)];

pb=IOP+dP;

Qleak = trapz(x,(Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2)- Lp*sigma*R*T*(c3b-c3)).*a);
Alb_leak = trapz(x,betaa*(c2b+c3b-c2-c3).*a)*Surf_A;
vel = u(end);
Qu = -((IOP-Pev)*C-Qprod);
c2_mean = trapz(x(1:npts/2),c2(1:npts/2))/Lc;

tot_atra = trapz(x,c3)/(Ls+Lc);
tot_atra_S = trapz(x(npts/2+1:end),c3(npts/2+1:end))/(Ls);

c3_f = tot_atra;

cost2 = (c3_f-c3_exp_f).^2./c3_exp_f.^2;

atra_prod_tot = trapz(x,a.*atra_prod);
atra_ves = trapz(x,a.*betaa.*(c3b-c3));
atra_cons = trapz(x,[zeros(1,npts/2),k2*c3(npts/2+1:end).*(Ind_max*(c3(npts/2+1:end)/fu_inc)./((c3(npts/2+1:end)/fu_inc)+Ind_C50))]);
% Sample data
variable = {'IOP, mmHg', 'c_A/c_b', 'V_s, m/s','Q_leak, m/s','Q_u/Qprod, %','Alb_leak, mol/s','Mean atRA, mM','Mean atRA sclera, mM', 'atRA prod mol/s', 'atRA blood mol/s', 'atRA cons mol/s'};
value = [IOP/133, c2_mean/c2b, vel, Qleak, Qu/Qprod*100, Alb_leak, tot_atra*1e+6, tot_atra_S*1e+6,atra_prod_tot*Surf_A,atra_ves*Surf_A,atra_cons*Surf_A];

% Create a table
Tt = table(variable', value', 'VariableNames', {'Variable', 'Value'});

% Display the table
disp(' ');
disp(Tt);
tot_atra_s = trapz(x(npts/2+1:end),c3(npts/2+1:end))/(Ls);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% figures for the paper

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);

axis normal
yyaxis left 
plot(x*10^6,c2,'Color',[0.4660 0.6740 0.1880],'Linewidth',2)
hold on 
xline(Lc*1e6,'Linewidth',1,'color','k');
set(gca,'FontSize',20);
ylabel('SA, mM')
xlabel('$x, \mu$m','Interpreter','latex')
xlim([0 (Lc+Ls)*1e6])
%rr =rectangle('Position',[0 0.074*0.998 cf*Lc*10^6 (0.0772-0.074)*1.3],'FaceColor','r','EdgeColor','none');
%ylim([0.0745,0.0775])

% Create rechtangle
pos = [0, min(c2)*0.998, cf*Lc*10^6, (max(c2)-min(c2))*2];

% Extract the corner points
xx = [pos(1), pos(1) + pos(3), pos(1) + pos(3), pos(1)];
yy = [pos(2), pos(2), pos(2) + pos(4), pos(2) + pos(4)];

% Create the patch
rr = patch(xx, yy, 'r', 'EdgeColor', 'none');

ylim([min(c2)*0.998,max(c2)*1.0017])
ax=gca;
ax.YAxis(1).Color = [0.4660 0.6740 0.1880];

rr.FaceAlpha = 0.2;

hold off;

yyaxis right 

plot(x*10^6,c3*1e6,'Color',[0.4940 0.1840 0.5560]	,'Linewidth',2)
ylim([0,max(c3*1e+6)*1.1])
hold on 
ylabel('atRA:SA, nM')
ax.YAxis(2).Color = [0.4940 0.1840 0.5560];



if species ==1 
    save('human.mat')
elseif species ==2&& feeding==0
    save('mouse_nf.mat')
elseif species ==2&& feeding==1
    save('mouse_f.mat')
end
