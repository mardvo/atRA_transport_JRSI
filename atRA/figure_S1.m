% figure in supplementary
clear all
close all

load("k1_k2_mouse_feeding.mat")
figure
contourf(Par1,Par2,tot_atra_S,5000,'EdgeColor','none')
set(gca,'XScale','log')
set(gca,'YScale','log')
set(gca,'ColorScale','log');
c=colorbar
hold on
% Add contour lines with labels
levels = [1e-6,3e-6,1e-5,3e-5,1e-4,3e-4,1e-3,3e-3,1e-2];
[C, h] = contour(Par1,Par2,tot_atra_S, levels, 'LineColor', 'k');

%xlabel('$k_{prod}$, mM/s','Interpreter','Latex')
xlabel('$c_{3,B}$, mM','Interpreter','Latex')

ylabel('$k_{CYPdeg}$, 1/s','Interpreter','Latex')
set(gca,'Fontsize', 20)
ylabel(c, '$<c_3>_S$, mM','Interpreter','Latex','FontSize',20)
set(c,'Fontsize', 20)