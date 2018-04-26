function UCB = getUCB(x,gprMdl,M)
    nu = 0.05;
    GP_varsigma = @(M) sqrt(2*log(pi^2*(M)^2/(12*nu))); 

    [gp_output,sample_std]  = predict(gprMdl,x);%gp(hyp,@infGaussLik, meanfunc, covfunc, likfunc, total_samples, total_targets, test_x);%%
    UCB = -1*(gp_output + GP_varsigma(M)*(sample_std));
end