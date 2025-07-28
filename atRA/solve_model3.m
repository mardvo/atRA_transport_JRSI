function [x, p, dpdx, c2, dc2dx, c3, dc3dx, IOP] = solve_model3(toll,npts)

global_variables;

x = [linspace(0,Lc,npts/2),linspace(Lc,Lc+Ls,npts/2)];

solinit = bvpinit(x,[15*133 0 c2b 0 c3b 0],133*15);
options = bvpset('RelTol',1e-6,'AbsTol',1e-8,'NMax',15000);

y2_p = solinit.y+1;
y2 = solinit.y;
n=0;

% while max(abs((y2-y2_p)./y2_p)) > toll
%     n=n+1;
%     disp(['   Iteration #' num2str(n)]);
%     y2_p=y2;
%     solinit.y = y2_p;
    sol = bvp4c(@(x,y,r,IOP)twoode3(x,y,r,IOP),@twobc3,solinit,options);
    y = deval(sol,x);
    y2=y;

    % if n>=3
    %     p=NaN; dpdx=NaN; c2 = NaN; dc2dx = NaN; c3 = NaN; dc3dx = NaN; IOP = NaN;
    %     disp('No solution for this parameter set')
    %     return
    % end

% end

p = y(1,:);
dpdx = y(2,:);
c2 = y(3,:);
dc2dx = y(4,:);
c3 = y(5,:);
dc3dx = y(6,:);
IOP = sol.parameters;

end

