clear all
close all
clc


EI = load('EI_objecntess_MS_theta.mat');
PI = load('PI_objectness_MS_theta.mat');
UCB = load('UCB_objectness_MS_theta.mat');


figure
h = gca;
plot(EI.EI_max_targets,'-^r','LineWidth',3);
hold on
plot(PI.PI_max_targets,'-vb','LineWidth',3);
plot(UCB.UCB_max_targets,'-*r','LineWidth',3,'Color',[0,128,0]/255);
plot(0.89*ones(100,1),'--k','LineWidth',3);
xlabel('Number of Iterations')
ylabel('Objectness Score')
legend('GP-EI','GP-PI','GP-UCB','Hand-Tuned')
h.XLim = [1,100];
h.XTick = [1,10:10:100];
h.YTick = [0.8:0.05:1.15];
h.XGrid = 'on'; h.XMinorGrid = 'on';
h.YGrid = 'on'; h.YMinorGrid = 'on';
h.FontWeight = 'bold';
h.FontSize = 16;
