clear all
close all

%%% to merge Y vectors in matfiles
direct = pwd+"/h_27_01/";
load(direct+"X.mat");

load(direct+"res.mat");
k=11;

efast_var={'$K_S$','$\mathcal{L}^*_p$','$\beta$','$u_{RPE}$','$\Delta P_{blood}$','$\Delta P_{SCS}$','$k_{CYPdeg}$','$k_{prod}$','$Ind_{C50}$','$c_{3,B}$','dummy'};%,

y_var_label={'IOP','Q_{ves}','vel','Qu','c_{alb}','Alb_{leak}','$<c_{3}>$','$c_{3,S}(x=L_S+L_C)$','$<c_{3}>_S$'};
l_order = [1,2,3,4,5,6,8,7,9,10,11]; %IOP,Qleak,vel,Qu,c_alb,Alb_leak,tot_atra,atra_S


kk=[9,8];
[Si,Sti,rangeSi,rangeSti] = efast_sd_2(Y,OMi,MI,kk);
figure
fig=gcf;
fig.Position(3:4)=[800,400];
bar(1:k,[Sti(l_order,kk)])
hold on 
set(gca,'xticklabel',efast_var(l_order))
set(gca,'Fontsize',24)
%legend(y_var_label(kk))
%ll=legend(y_var_label(kk))
%ll.Interpreter='latex';
ylim([0,1])
ylabel('$S_T$','Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')

