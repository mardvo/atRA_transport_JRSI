%% figure 7
close all 
clear all
figure
load('mouse_nf.mat')
deg = k2*c3(npts/2+1:end).*(Ind_max*(c3(npts/2+1:end)/fu_inc)./((c3(npts/2+1:end)/fu_inc)+Ind_C50));
max(deg)
semilogy((x(npts/2+1:end)-Lc)/Ls,deg,'Linewidth',2)
set(gca,'FontSize',20);
hold on
load('mouse_f.mat')
deg = k2*c3(npts/2+1:end).*(Ind_max*(c3(npts/2+1:end)/fu_inc)./((c3(npts/2+1:end)/fu_inc)+Ind_C50));
semilogy((x(npts/2+1:end)-Lc)/Ls,deg,'Linewidth',2)
max(deg)
load('human.mat')

deg = k2*c3(npts/2+1:end).*(Ind_max*(c3(npts/2+1:end)/fu_inc)./((c3(npts/2+1:end)/fu_inc)+Ind_C50));
semilogy((x(npts/2+1:end)-Lc)/Ls,deg,'Linewidth',2)
max(deg)
%xlabel('$\mathsf{Normalised\ scleral\ position} (x-L_C)/L_S$','Interpreter','latex')
xlabel('Normalised scleral position')

ylabel('atRA consumption rate, mM/s')
xlim([0,1])
%legend('mouse physiological','mouse atRA feeding','human')