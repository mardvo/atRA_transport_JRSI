clear all
close all

%%% to merge Y vectors in matfiles
species =1; 
if species == 1
    disp('Parameters set for human')
    disp(' ');
    load(pwd+"/h_26_01/X_h.mat");
    load(pwd+"/h_26_01/res_h.mat");
elseif species == 2
    disp('Parameters set for mouse')
    disp(' ');
    load(pwd+"/m_26_01/X_m.mat");
    load(pwd+"/m_26_01/res_m.mat");
else
    disp('No parameters set')
    return;
end

efast_var={'$K_S$','$\mathcal{L}^*_p$','$\beta$','$u_{RPE}$','$\Delta P_{blood}$','$\Delta P_{SCS}$','dummy'};%,
y_var_label={'IOP','$u_{CC}$','$u_S$','$Q_u$','$<c_2>_{CS}$','$J_2$'};

%water
kk=[1,2,3,5];
[Si,Sti,rangeSi,rangeSti,var] = efast_sd_2(Y,OMi,MI,kk);

figure
fig=gcf;
fig.Position(3:4)=[800,400];
bar(1:k,[Sti(:,kk)])
hold on 
set(gca,'xticklabel',efast_var)
set(gca,'Fontsize',24)
ylabel('$S_{T}$','Interpreter','latex');
ll=legend(y_var_label(kk));
ll.Interpreter='latex';
set(gca,'TickLabelInterpreter','latex')
ylim([0,0.7])

%albumin
kk=[5,6];
[Si,Sti,rangeSi,rangeSti,var] = efast_sd_2(Y,OMi,MI,kk);


figure
bar(1:k,[Sti(:,kk)])
hold on 
set(gca,'xticklabel',efast_var)
set(gca,'Fontsize',14)
ll=legend(y_var_label(kk))
ll.Interpreter='latex';
ylim([0,1])
ylabel('$S_T$','Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')
