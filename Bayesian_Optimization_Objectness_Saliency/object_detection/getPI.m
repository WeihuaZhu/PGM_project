function PI = getPI(x,gprMdl,max_of_targets)
    sigma1 = 0.0;
    [gp_output,sample_std]  = predict(gprMdl,x);%gp(hyp,@infGaussLik, meanfunc, covfunc, likfunc, total_samples, total_targets, test_x);%%
    Z1 = (gp_output - max_of_targets-sigma1)./(sample_std);
    PI = -1*Z1;
end