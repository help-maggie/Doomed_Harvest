
clear

% Vector of the three equations for average time stressed. 
% _1 is for E=N+S _2 is other E.
% c_less is 0.01 and c_more is 0.1
avg_c_less_1=[ 1.5064, 1.5239, 1.5088];
avg_c_more_1=[ 0.9249, 0.8193, 0.9269];

avg_c_less_2=[ 1.5107, 1.5204,  1.5204];
avg_c_more_2=[ 0.9266, 0.8242, 0.9288];


% Vector of the three equations for duration. 
% _1 is for E=N+S _2 is other E.
% c_less is 0.01 and c_more is 0.1
dur_c_less_1=[ 73.7573, 65.4355, 73.0632];
dur_c_more_1=[ 19.8740, 6.3737, 20.5113];

dur_c_less_2=[ 73.0498, 58.0468,  73.4518];
dur_c_more_2=[ 19.8892, 6.8454, 20.1457];


% Vector of the three equations for total people who skipped the stress state. 
% _1 is for E=N+S _2 is other E.
% c_less is 0.01 and c_more is 0.1
skip_c_less_1=[ 106, 104, 106];
skip_c_more_1=[ 233, 233, 232];

skip_c_less_2=[ 107, 104,  106];
skip_c_more_2=[ 233, 233, 233];


% Vector of the three equations for peak number of people who are stressed . 
% _1 is for E=N+S _2 is other E.
% c_less is 0.01 and c_more is 0.1
peak_c_less_1=[  52, 49, 53];
peak_c_more_1=[ 93, 92, 93];

peak_c_less_2=[ 53, 50,  53];
peak_c_more_2=[ 93, 93, 93];


effort= categorical({'E=N+S','E=N+\rho{(S)}/{(1+e^{\lambda x -\mu })}'});


figure()
tiledlayout(1,4);
nexttile
avg=bar(effort,[avg_c_less_1, avg_c_more_1;avg_c_less_2, avg_c_more_2]);
avg(1).FaceColor = [0 0.4 1];
avg(2).FaceColor = [0 0.7 1];
avg(3).FaceColor = [0 0.9 1];

avg(4).FaceColor = [0 0.4 0.3];
avg(5).FaceColor = [0 0.6 0.3];
avg(6).FaceColor = [0 0.8 0.3];

lgd1 = legend([avg(1) avg(2) avg(3)],'eq 1: dx/dt=rx(1-(x/K))-qEx', 'eq 2: dx/dt=rx(1-(x/K(t)))-qEx', 'eq 3: dx/dt=rx(1-(x/K))-mx-qEx');  
title(lgd1,'c = 0.01') % add legend title
lgd1.Location="southoutside";
lgd1.FontSize = 14;
ax = gca; 
ax.FontSize = 14; 

title('Average time Spent', 'in Stressed State','FontWeight','Normal', 'FontSize', 14); 

nexttile
dur=bar(effort,[dur_c_less_1, dur_c_more_1;dur_c_less_2, dur_c_more_2]);
dur(1).FaceColor = [0 0.4 1];
dur(2).FaceColor = [0 0.7 1];
dur(3).FaceColor = [0 0.9 1];

dur(4).FaceColor = [0 0.4 0.3];
dur(5).FaceColor = [0 0.6 0.3];
dur(6).FaceColor = [0 0.8 0.3]; 
lgd2 = legend([dur(4) dur(5) dur(6)],'eq 1: dx/dt=rx(1-(x/K))-qEx', 'eq 2: dx/dt=rx(1-(x/K(t)))-qEx', 'eq 3: dx/dt=rx(1-(x/K))-mx-qEx'); 
title(lgd2,'c = 0.1') % add legend title
lgd2.Location="southoutside";
lgd2.FontSize = 14;
ax = gca; 
ax.FontSize = 14; 

title('Duration','FontWeight','Normal','FontSize', 14);

nexttile
skip=bar(effort,[skip_c_less_1, skip_c_more_1;skip_c_less_2, skip_c_more_2]);
skip(1).FaceColor = [0 0.4 1];
skip(2).FaceColor = [0 0.7 1];
skip(3).FaceColor = [0 0.9 1];

skip(4).FaceColor = [0 0.4 0.3];
skip(5).FaceColor = [0 0.6 0.3];
skip(6).FaceColor = [0 0.8 0.3];
title('Number of People Who','Skipped Being Stressed','FontWeight','Normal','FontSize', 14);
ax = gca; 
ax.FontSize = 14; 


nexttile
peak=bar(effort,[peak_c_less_1, peak_c_more_1;peak_c_less_2, peak_c_more_2]);
peak(1).FaceColor = [0 0.4 1];
peak(2).FaceColor = [0 0.7 1];
peak(3).FaceColor = [0 0.9 1];

peak(4).FaceColor = [0 0.4 0.3];
peak(5).FaceColor = [0 0.6 0.3];
peak(6).FaceColor = [0 0.8 0.3];
title('Peak Number Stressed','FontWeight','Normal','FontSize', 14);
ax = gca; 
ax.FontSize = 14; 


