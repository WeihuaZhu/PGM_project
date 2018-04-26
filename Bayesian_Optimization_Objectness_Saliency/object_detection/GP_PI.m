clear all
close all
clc

startup;
rand('seed',0);
randn('seed',0);
sin1 = @(value) 1*(sin(13 .* value) .* sin(27 .* value) ./ 2.0 + 0.5);
objectnessScore = @(value) getObjectnessScore(value(:,1),value(:,2),value(:,3),value(:,4),value(:,5),params);
%%

f = objectnessScore; dimension=5; sample_space = [0.1,0.9].*ones(dimension,1);
%%

xs = params.MS.theta;
PI_total_samples = xs;
PI_total_targets = [];
for i = 1:size(PI_total_samples,1)
    PI_total_targets = [PI_total_targets;f(PI_total_samples(i,:))];
end
max_of_targets = PI_total_targets;
PI_max_targets = [];
count_max = 100;
M = 1;
nu = 0.1;
x0 = xs;
%%
tic
for count = 1:count_max
    startup;
    gprMdl = fitrgp(PI_total_samples,PI_total_targets,'Basis','none','Sigma',0.01,'KernelFunction','ardmatern52','FitMethod','exact','PredictMethod','exact');
    
     acq = @(x) getPI(x,gprMdl,max_of_targets);
    
    [x,fval,exitflag] = particleswarm(acq,dimension,sample_space(:,1),sample_space(:,2));

    sample_new = x;
    pause(2);
    target_new = f(sample_new);
    
    PI_total_samples = [PI_total_samples;sample_new];
    PI_total_targets = [PI_total_targets;target_new];
    
    [max_of_targets,xxx] = max(PI_total_targets);
    max_sample = PI_total_samples(xxx,:);
    
    PI_max_targets = [PI_max_targets;max_of_targets];
    count
    max_of_targets
    target_new
    toc
%     clc
    
end
figure
h = gca;
plot(PI_max_targets,'-^b','LineWidth',3)
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



















