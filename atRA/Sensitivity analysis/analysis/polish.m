%% polish the results


direct = pwd+"/m_f_27_01/";
load(direct+"X.mat");

load(direct+"res.mat")

% throw out X<0


for k=1:NR
    for i=1:11
        ind=(Y(:,7,i,k)<=0); % X<0
        Y(ind,:,i,k)=NaN;
        ind=Y(:,8,i,k)<=0; %np0<0
        Y(ind,:,i,k)=NaN;
        % ind=imag(Y(:,5,i,k))~=0;% complex entries
        % Y(ind,:,i,k)=NaN;
    end
end

save(direct+"res_h.mat")

