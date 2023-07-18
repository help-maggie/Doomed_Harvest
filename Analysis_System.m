function [dydt]= ode_system2_2(t,y)
dydt=zeros(5,1);
x_0=y(1);
%%
%%%%%% Fishing Effort Options %%%%%%

%%%% (1) manpower (# fishing) %%%%
  % E= @(N,S) N+S;
 
%%%% (2) increasing desperation %%%%
 rho=3;
 lambda=.07;
 mu=x_0/50; % shifts curve to center around a half of the intial fish population 
 E= @(N,S,x) N+rho*(S)/(1+exp(lambda*x-mu));
 
 
 
%%
%%%%%% catchability %%%%%%
q=0.001;


%%
%%%%%% Fish Population ODE Options %%%%%%

% K=150000;
% r=-.01;
% dxdt=@(x,E) r*x*(1-(x/K))-q*E*x; %density dependent decrease where the smaller the population is, the faster the decrease

r=.3;
b=0.007; %rate of decrease
K_0=150000;
K=K_0*(1-b)^t;
dxdt=@(x,E) r*x*(1-(x/K))-q*E*x; %decreasing carrying cpacity

% r=.3;
% m=.35; %proportion of death due to reason such as disease
% K=150000;
% dxdt=@(x,E) r*x*(1-(x/K))-m*x-q*E*x; %density dependent removal such as disease




%% 
%%%%%%%%%%%% expected values of switching state based on number of contacts  %%%%%%%%%%%%
c=.01;

alpha_1=4;
alpha_2=4;
alpha_3=4;
alpha_4=4;

phi_1=1;
phi_2=1;
phi_3=1;
phi_4=1;
    function out = gammaP_N(N)
        z = 1:floor(N);
        out = sum((1./(1+exp(-(z-alpha_1)/phi_1))).*poisspdf(z,c*N));
    end

    function out = betaP_S(S)
        z = 1:floor(S);
        out =sum((1./(1+exp(-(z-alpha_2)/phi_2))).*poisspdf(z,c*S));
    end

    function out = psiP_R(R)
        z = 1:floor(R);
        out = sum((1./(1+exp(-(z-alpha_3)/phi_3))).*poisspdf(z,c*R));
    end

    function out = deltaP_S(S)
        z = 1:floor(S);
        out = sum((1./(1+exp(-(z-alpha_4)/phi_4))).*poisspdf(z,c*S));
    end

 
% syms z;
% gammaP_N = @(N) symsum(1/(1+exp(-(z-alpha_1)/phi_1))*poisspdf(z,c*N),z,1,floor(N));
% betaP_S = @(S) sysmsum((1/(1+exp(-(z-alpha_2)/phi_2)))*poisspdf(z,c*S),z,1,floor(S));
% psiP_R = @(R) sysmsum((1/(1+exp(-(z-alpha_3)/phi_3)))*poisspdf(z,c*R),z,1,floor(R));
% deltaP_S = @(S) sysmsum((1/(1+exp(-(z-alpha_4)/phi_4)))*poisspdf(z,c*S),z,1,floor(S));

%%
%%%%%%%%%%%%% R_0 %%%%%%%%%%%%


%% 
%%%%%%%%%%%% ODE System %%%%%%%%%%%%
% y(1)=x; %(fish pop)
% y(2)=N_1; %(non-stressed never stressed pop)
% y(3)=N_1; %(non-stressed but stressed before\ pop)
% y(4)=S; %(stressed pop),
% y(5)=R; %(recovered pop)


r_1=.05;
r_2=.05;
r_3=.05;


dydt(1)=dxdt(y(1),E(y(2)+y(3),y(4),y(1))); %fish population ode
dydt(2)=-((r_1*(K-y(1))/K)+betaP_S(y(4)) + deltaP_S(y(4)))*y(2); %non-stressed population ode
dydt(3)=((r_3*y(1)/K)+ gammaP_N(y(2)+y(3)))*y(4)-((r_1*(K-y(1))/K)+betaP_S(y(4)) + deltaP_S(y(4)))*y(3); %non-stressed population ode
dydt(4)=((r_1*(K-y(1))/K)+betaP_S(y(4)))*(y(2)+y(3)) - ((r_2*(K-y(1))/K) + r_3*y(1)/K + psiP_R(y(5)) + gammaP_N(y(2)+y(3)))*y(4); %stressed population ode
dydt(5)=((r_2*(K-y(1))/K) + psiP_R(y(5)))*y(4) + deltaP_S(y(4))*(y(2)+y(3));  %recovered population ode

end