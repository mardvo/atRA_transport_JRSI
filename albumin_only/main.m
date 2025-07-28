% main 
close all
clear all;

TopFolder = fileparts(pwd);
addpath(TopFolder+"/parameters/");

global_variables;

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solution of the system of ODE's
toll = 1e-6;
npts = 400;
warning('off','MATLAB:deval:NonuniqueSolution'); % switch off the non-continuity warnings

[x,p,dpdx,c2,dc2dx,IOP] = solve_model3(toll,npts); % solve the system
u=-dpdx; % note that the factor K_i/mu (i=c,s) has already been incorporated into dpdx

%% outputs
a = vessel_distribution(x);

pb=IOP+dP;

Qleak = trapz(x,(Lp*(pb-p) - Lp*sigma*R*T*(c2b-c2)).*a);
Alb_leak = trapz(x,betaa*(c2b-c2).*a)*Surf_A;
vel = u(end);
Qu = -((IOP-Pev)*C-Qprod);
alb_conc = trapz(x,c2)/(Lc+Ls);
c2_mean = trapz(x(npts/2+1:end),c2(npts/2+1:end))/Ls;
% Sample data
variable = {'IOP, mmHg', '<c_2s>/c_b', 'V_s, m/s','Q_leak, m/s','Q_u/Qprod, %','Alb_leak, mol/s'};
value = [IOP/133, c2_mean/c2b, vel, Qleak, Qu/Qprod*100, Alb_leak];

% Create a table
Tt = table(variable', value', 'VariableNames', {'Variable', 'Value'});
% Display the table
disp(' ');
disp(Tt);

%% figures for the paper

figure;
yyaxis left 
plot(x*10^6,p/133,'k','Linewidth',2)
hold on 
%plot([Lc Lc]*10^6,[0 max(p)/133]*1.1,'k--')
xlim([0 Lc+Ls]*1e+6)

% Define the position
pos = [0 0 cf*Lc*10^6 max(p/133)*1.1];
xx = [pos(1), pos(1) + pos(3), pos(1) + pos(3), pos(1)];
yy = [pos(2), pos(2), pos(2) + pos(4), pos(2) + pos(4)];

% Create the patch
rr = patch(xx, yy, 'r', 'EdgeColor', 'none','HandleVisibility', 'off');
rr.FaceAlpha = 0.2;
ylim([0,max(p/133)*1.05])
ylabel('pressure, mmHg')
xlabel('$x, \mu$m','Interpreter','Latex')

set(gca,'FontSize',20);

xline(Lc*1e6,'Linewidth',1,'color','k');

if species==1
    text(0.1*Lc*10^6,max(p/133)*0.9,'Choroid','FontSize',20)
    text(Lc*10^6+Ls*0.2*10^6,max(p/133)*0.9,'Sclera','FontSize',20)
else
    text(0.15*Lc*10^6,max(p/133)*0.5,'Choroid','FontSize',20)
    text(Lc*10^6+Ls*0.2*10^6,max(p/133)*0.5,'Sclera','FontSize',20)
end
ax=gca; 
ax.YAxis(1).Color = [0 0 0];
yyaxis right
plot(x*10^6,c2,'Color',[0.4660 0.6740 0.1880],'Linewidth',2)
ylabel('SA, mM')

set(gca,'FontSize',20);

ax.YAxis(2).Color = [0.4660 0.6740 0.1880];

figure
yyaxis left 
plot(x*10^6,u,'blue','Linewidth',2)
hold on 
ylabel('velocity, m/s')
xlabel('$x, \mu$m','Interpreter','Latex')
set(gca,'FontSize',20);
xlim([0 Lc+Ls]*1e+6)

% Define the position
pos = [0 min(min(u)*0.95,min(u)*1.5) cf*Lc*10^6 (max(c2)-min(c2))*1.2];
xx = [pos(1), pos(1) + pos(3), pos(1) + pos(3), pos(1)];
yy = [pos(2), pos(2), pos(2) + pos(4), pos(2) + pos(4)];

% Create the patch
rr = patch(xx, yy, 'r', 'EdgeColor', 'none','HandleVisibility', 'off');
rr.FaceAlpha = 0.2;
ylim([min(min(u)*0.95,min(u)*1.5),max(u)*1.02])

ax= gca;
ax.YAxis(1).Color ='blue';

yyaxis right 
ax2 = gca; 
plot(x*10^6,[u(1:npts/2).*c2(1:npts/2)-dc2dx(1:npts/2)*D2c,u(npts/2+1:end).*c2(npts/2+1:end)-dc2dx(npts/2+1:end)*D2s],'Linewidth',2)
hold on 
plot(x*10^6,u.*c2,'Linewidth',2)
plot(x*10^6,[-dc2dx(1:npts/2)*D2c,-dc2dx(npts/2+1:end)*D2s],'Linewidth',2)


ylabel('fluxes, mol/s/m^2')
xline(Lc*1e6,'Linewidth',1,'color','k');
yyaxis left 
yline(0,'k-','HandleVisibility','off')
legend('velocity','solute flux','advection','diffusion')

%% a zoom in

figure('Position',[10 10 800 500]);
yyaxis left 
plot(x*10^6,u,'blue','Linewidth',6)
hold on 
xlabel('$x, \mu$m','Interpreter','Latex')
set(gca,'FontSize',50);
xlim([0,cf*Lc*1.3]*1e+6)

% Define the position
pos = [0 min(min(u)*0.95,min(u)*1.5) cf*Lc*10^6 (max(c2)-min(c2))*1.2];
% Extract the corner points
xx = [pos(1), pos(1) + pos(3), pos(1) + pos(3), pos(1)];
yy = [pos(2), pos(2), pos(2) + pos(4), pos(2) + pos(4)];
% Create the patch
rr = patch(xx, yy, 'r', 'EdgeColor', 'none');
rr.FaceAlpha = 0.2;
ylim([min(min(u)*0.95,min(u)*1.5),max(u)*1.02])

ax= gca;
ax.YAxis(1).Color ='blue';

yyaxis right 
ax2 = gca; 
plot(x*10^6,[u(1:npts/2).*c2(1:npts/2)-dc2dx(1:npts/2)*D2c,u(npts/2+1:end).*c2(npts/2+1:end)-dc2dx(npts/2+1:end)*D2s],'Linewidth',6)
hold on 
plot(x*10^6,u.*c2,'Linewidth',6)
plot(x*10^6,[-dc2dx(1:npts/2)*D2c,-dc2dx(npts/2+1:end)*D2s],'Linewidth',6)

xline(Lc*1e6,'Linewidth',4,'color','k');
yyaxis left 
yline(0,'k-','Linewidth',4,'HandleVisibility','off')

