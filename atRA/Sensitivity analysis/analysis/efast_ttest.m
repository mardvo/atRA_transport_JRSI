function s = efast_ttest(Si,rangeSi, Sti,rangeSti,efast_var,y_var,y_var_label,alpha) % use rangeSi or ramgeSti from efast_sd
%Si=Si(:,time_points);
%Sti=Sti(:,time_points);
%rangeSi=rangeSi(:,time_points,:);
%rangeSti=rangeSti(:,time_points,:);
%Si_struct
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
function pairwise_ttest

input: matrix of sensitivity indices Si(# parameters,# search curves)
output: square matrix of p-values, comparing each parameter
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SAefast_struct=struct;

[k,NR,output]=size(rangeSi); %record k number of parameters, NR number of search curves

SAefast_struct.Si=Si;
SAefast_struct.rangeSi=rangeSi;
SAefast_struct.Sti=Sti;
SAefast_struct.rangeSti=rangeSti;
g=1;
for u=y_var

        [y_var_label(u)]
        %% Compare Si or STi of parameter j with the dummy
        for i=1:k-1
            %% Si
            [rangeSi(i,:,u) rangeSi(k,:,u)];
            [squeeze(rangeSi(i,:,u)) squeeze(rangeSi(k,:,u))];
            [mean(squeeze(rangeSi(i,:,u))) mean(squeeze(rangeSi(k,:,u)))];
            [a,p_Si(i,u)]=ttest2(squeeze(rangeSi(i,:,u)),squeeze(rangeSi(k,:,u)),alpha,'right','unequal');
            %% Sti
            [rangeSti(i,:,u) rangeSti(k,:,u)];
            [squeeze(rangeSti(i,:,u)) squeeze(rangeSti(k,:,u))];
            [mean(squeeze(rangeSti(i,:,u))) mean(squeeze(rangeSti(k,:,u)))];
            [a,p_Sti(i,u)]=ttest2(squeeze(rangeSti(i,:,u)),squeeze(rangeSti(k,:,u)),alpha,'right','unequal');
        end % for i
        SAefast_struct.p_Si(:,u)=p_Si(:,u);
        SAefast_struct.p_Sti(:,u)=p_Sti(:,u);
end
s=SAefast_struct
efast_var
Si_out=squeeze(s.Si(:,y_var))'
p_Si_out=squeeze(s.p_Si(:,y_var))'
%% To display Sti and p-value
Sti_out=squeeze(s.Sti(:,y_var))'
p_Sti_out=squeeze(s.p_Si(:,y_var))'