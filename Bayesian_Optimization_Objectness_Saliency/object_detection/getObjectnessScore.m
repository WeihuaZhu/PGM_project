function score = getObjectnessScore(MS_theta1,MS_theta2,MS_theta3,MS_theta4,MS_theta5,params)


params_new = params;

params_new.MS.theta = [MS_theta1,MS_theta2,MS_theta3,MS_theta4,MS_theta5];


score = evaluate_score(params_new);

end