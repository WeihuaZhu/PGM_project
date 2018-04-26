function EI = getEI(x,gprMdl,max_of_targets)
    sigma1 = 0.01;
    [gp_output,sample_std]  = predict(gprMdl,x);%gp(hyp,@infGaussLik, meanfunc, covfunc, likfunc, total_samples, total_targets, test_x);%%
    Z1 = (gp_output - max_of_targets-sigma1)./(sample_std);
    EI = -1*((-max_of_targets+gp_output-sigma1).*normcdf(Z1) + (sample_std).*normpdf(Z1));
end