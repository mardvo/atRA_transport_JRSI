clear all
close all

%%% to merge Y vectors in matfiles

direct = pwd+"/m_f_27_01/";
load(direct+"X_m_f.mat");

Y1 = load(direct+"res.mat",'Y');
Y = Y1.Y(:,:,1:11,:);
for m=11
Y2=load(direct+"res_m_f_11_c3.mat",'Y');
Y(:,:,m,3)=Y2.Y(:,:,m,3);

%Y=Y1.Y;
end 



save(direct+"res.mat")