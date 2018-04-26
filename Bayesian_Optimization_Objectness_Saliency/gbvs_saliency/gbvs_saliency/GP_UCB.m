clear all
close all
clc

rand('seed',0);
randn('seed',0);
sin1 = @(value) 1*(sin(13 .* value) .* sin(27 .* value) ./ 2.0 + 0.5);
objectnessScore = @(value) getObjectnessScore(value(:,1),value(:,2),value(:,3),value(:,4),value(:,5),params);
saliencyScore = @(value) getSaliencyScore(value(:,1),value(:,2),value(:,3),value(:,4),value(:,5),value(:,6),value(:,7));

%%

% f = objectnessScore; dimension=5; sample_space = [0.1,0.9].*ones(dimension,1);
f = saliencyScore; dimension=7; sample_space = [0.2,1.8].*ones(dimension,1);

%%

xs = ones(1,dimension);
UCB_total_samples = xs;
UCB_total_targets = [];
for i = 1:size(UCB_total_samples,1)
    UCB_total_targets = [UCB_total_targets;f(UCB_total_samples(i,:))];
end
max_of_targets = UCB_total_targets;
UCB_max_targets = [];
count_max = 100;
M = 1;
nu = 0.1;
x0 = xs;
%%
tic
for count = 1:count_max
    gprMdl = fitrgp(UCB_total_samples,UCB_total_targets,'Basis','none','Sigma',0.01,'KernelFunction','ardmatern52','FitMethod','exact','PredictMethod','exact');
    
     acq = @(x) getUCB(x,gprMdl,count);
    
    [x,fval,exitflag] = particleswarm(acq,dimension,sample_space(:,1),sample_space(:,2));

    sample_new = x;
    pause(2);
    target_new = f(sample_new);
    
    UCB_total_samples = [UCB_total_samples;sample_new];
    UCB_total_targets = [UCB_total_targets;target_new];
    
    [max_of_targets,xxx] = max(UCB_total_targets);
    max_sample = UCB_total_samples(xxx,:);
    
    UCB_max_targets = [UCB_max_targets;max_of_targets];
    count
    max_of_targets
    target_new
    toc
%     clc
    
end
figure
h = gca;
plot(UCB_max_targets,'-^b','LineWidth',3)
xlabel('Number of Iterations')
ylabel('Objectness Score')
h.FontWeight = 'bold';
h.FontSize = 16;
h.XGrid = 'on';
h.XMinorGrid = 'on';
h.YGrid = 'on';
h.YMinorGrid = 'on';
h.XTick = [1,10:10:100];
h.YTick = [0.8:0.05:1.15];
% plot(EI_log_distance)



















