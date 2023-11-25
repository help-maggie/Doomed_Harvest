clear

%%%%%% Inital population numbers %%%%%%
x_0=100000;
N_0=500;
S_0=0;
R_0=0;


initial_vals=[x_0 N_0 S_0 R_0];


%% 
%%%%%%%%%%%% Solving ODE %%%%%%%%%%%%
% options = odeset('RelTol',1e-8,'AbsTol',1e-10, InitialStep=1);
[t,y] = ode45(@ode_system2_2,[0 1000],initial_vals);

%%
%%%%%%%%%%% Analysis %%%%%%%%%%%%
r_1=.05; %make sure matches in ode_system2_2
r_2=.05; %make sure matches in ode_system2_2
r_3=.05; %make sure matches in ode_system2_2


K=150000; %make sure matches in ode_system2_2

inv_stress_people_dec=zeros;
for i = 1:length(t)-1
inv_stress_people_dec(i+1)=1/((r_2*(K-y(i+1,1))/K) + r_3*y(i+1,1)/K + psiP_R(y(i+1,4)) + gammaP_N(y(i+1,2)));
end

% % K(t) case%%
% K_0=150000; %make sure matches in ode_system2_2
% b=0.007;
% 
% inv_stress_people_dec=zeros;
% for i = 1:length(t)-1
% inv_stress_people_dec(i+1)=1/((r_2*((K_0*(1-b)^t(i+1))-y(i+1,1))/(K_0*(1-b)^t(i+1))) + r_3*y(i+1,1)/(K_0*(1-b)^t(i+1)) + psiP_R(y(i+1,4)) + gammaP_N(y(i+1,2)));
% end 

%%

initial_vals_2=[x_0 N_0 0 S_0 R_0];
[t_2,y_2] = ode45(@Analysis_System,[0 1000],initial_vals_2);

people_never_stressed=zeros;
for i = 1:length(t_2)-1
people_never_stressed(i+1)=(deltaP_S(y_2(i+1,4)))*y_2(i+1,2)*(t_2(i+1)-t_2(i));
end

avg_time_stressed=mean(inv_stress_people_dec)

total_people_never_stressed=sum(people_never_stressed)

total_people_that_were_stressed=N_0-total_people_never_stressed
 
max_stressed=max(findpeaks(y(:,3)))



tspan=zeros;
tspan_2=zeros;
for i = 1:length(t)
    if y(i,3)>1
        tspan(i)= t(i);
    end
end

time_of_stress=tspan(end)-tspan(1)

%%

% Plot solution

figure("Name","Human Population")
hold on
plot(t,y(:,2),'color', 'b')
plot(t,y(:,3),'color', 'r')
plot(t,y(:,4),'color', '#EDB120')
xlim([0 100])
xlabel('t')
ylabel('number of people')
legend('Non-stressed', 'Stressed', 'Recovered')


figure()
subplot(1,2,1)
title("Fish Population")
hold on
plot(t,y(:,1))
xlim([0 50])
xlabel('t')
ylabel('number of fish')


subplot(1,2,2)
title("Human Population")
hold on
plot(t_2,y_2(:,2),'color', 'b')
plot(t_2,y_2(:,3),'color', 'm')
plot(t_2,y_2(:,4),'color', 'r')
plot(t_2,y_2(:,5),'color', '#EDB120')
xlim([0 100])
xlabel('t')
ylabel('number of people')
legend('Non-stressed Never Stressed','Non-stressed but Stressed Before', 'Stressed', 'Recovered')

%%
% %%% Figures of growth and effort versus time and fish population
% q=0.001;
% 
% E=y(:,2)+y(:,3);
% 
% % r=-.01;
% % fish_growth=r.*y(:,1).*(1-(y(:,1)./K));
% 
% r=.3;
% b=0.007; %rate of decrease
% K_0=150000;
% for i= 1:length(t)
%     K(i)=K_0*(1-b)^t(i);
%     fish_growth(i)=r*y(i,1)*(1-y(i,1)/K(i));
%     harvest(i)=q*(y(i,2)+y(i,3))*y(i,1);
% end 
% 
% figure("Name","Human Population")
% hold on
% plot(t,y(:,2),'color', 'b')
% plot(t,y(:,3),'color', 'r')
% plot(t,y(:,4),'color', '#EDB120')
% plot(t,E,'color', 'g')
% xlim([0 100])
% xlabel('t')
% ylabel('number of people')
% legend('Non-stressed', 'Stressed', 'Recovered', 'Effort')
% 
% figure("Name","Fish Population")
% hold on
% plot(t,y(:,1),'color', 'b')
% plot(t,fish_growth,'color', 'r')
% plot(t,harvest,'color', '#EDB120')
% xlim([0 100])
% xlabel('t')
% ylabel('number of fish')
% legend('Fish population', 'Growth', 'Harvest')
% 
% figure()
% subplot(1,2,1)
% hold on
% plot(t,E)
% plot(t,fish_growth)
% plot(t,harvest)
% xlim([0 100])
% xlabel('t')
% legend('Effort (N+S)', 'growth without harvest','harvest')
% 
% subplot(1,2,2)
% hold on
% plot(y(:,1),harvest)
% plot(y(:,1),fish_growth)
% xlim([0 150000])
% xlabel('x (fish population)')
% legend('harvest (qEx)', 'growth without harvest')

%%
alpha_1=4;%make sure matches in ode_system2_2
alpha_2=4;%make sure matches in ode_system2_2
alpha_3=4;%make sure matches in ode_system2_2
alpha_4=4;%make sure matches in ode_system2_2

phi_1=1;%make sure matches in ode_system2_2
phi_2=1;%make sure matches in ode_system2_2
phi_3=1;%make sure matches in ode_system2_2
phi_4=1;%make sure matches in ode_system2_2

c= .01; % Make sure to change in each of the equations below
    function out = betaP_S(S)
        z = 1:floor(S);
        out =sum((1./(1+exp(-(z-4)/1))).*poisspdf(z,.01*S));
    end

    function out = gammaP_N(N)
        z = 1:floor(N);
        out = sum((1./(1+exp(-(z-4)/1))).*poisspdf(z,.01*N));
    end

    function out = psiP_R(R)
        z = 1:floor(R);
        out = sum((1./(1+exp(-(z-4)/1))).*poisspdf(z,.01*R));
     end

   function out = deltaP_S(S)
        z = 1:floor(S);
        out = sum((1./(1+exp(-(z-4)/1))).*poisspdf(z,.01*S));
   end


