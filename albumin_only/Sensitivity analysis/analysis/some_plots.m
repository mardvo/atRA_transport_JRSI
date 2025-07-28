clear all
close all
%TopFolder = fileparts(pwd);
species =1; 
if species == 1
    disp('Parameters set for human')
    disp(' ');
    load('X_h.mat');
    load('res_h.mat');
elseif species == 2
    disp('Parameters set for mouse')
    disp(' ');
    load('X_m.mat');
    load('res_m.mat');
else
    disp('No parameters set')
    return;
end


%check sampling of parameter k vs parameter m

k=5;
m=2;

figure
plot(X(:,k,k,1),X(:,m,k,1),'o')
hold on 
plot(X(:,k,k,2),X(:,m,k,2),'o')
xlabel(efast_var(k))
ylabel(efast_var(m))

%load('res_rodolofi.mat','Y');

y_var_label={'IOP','Q_ves','Alb_leek','vel','Qu','c_alb'};

Y(:,1,:,:) = Y(:,1,:,:)/133;
Y(:,5,:,:) = Y(:,5,:,:)/Qprod*100;
%Y(:,2,:,:) = -(Y(:,2,:,:));

for k=1:7
l=2% which output we are looking at
ind1=isnan(Y(:,1,k,1));
ind2=isnan(Y(:,1,k,2));

p = polyfit([X(~ind1,k,k,1);X(~ind2,k,k,2)],[Y(~ind1,l,k,1);Y(~ind2,l,k,2)],2);
%p = polyfit([X(~ind1,k,k,1);X(~ind2,k,k,2);X(~ind3,k,k,3)],[Y(~ind1,l,k,1);Y(~ind2,l,k,2);Y(~ind3,l,k,3)],2);

figure
plot(X(:,k,k,1),Y(:,l,k,1),'o')
hold on 
plot(X(:,k,k,2),Y(:,l,k,2),'o') 

plot(sort(X(:,k,k,1)),polyval(p,sort(X(:,k,k,1))),'k-') 

set(gca, 'FontSize', 16)
xlabel( efast_var(k), 'FontSize',16,'Interpreter','LaTex')

ylabel(y_var_label(l),'FontSize',16,'Interpreter','LaTex')
% if you wanna save the plots
%saveas(gcf,char(num2str(k)),'epsc')

end
