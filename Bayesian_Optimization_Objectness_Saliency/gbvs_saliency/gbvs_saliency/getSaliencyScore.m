function obj = getSaliencyScore(cW,iW,oW,cntW,fW,mW,dW)

params = makeGBVSParams();

params.colorWeight = cW;                % weights of feature channels (do not need to sum to 1). 
params.intensityWeight = iW;             
params.orientationWeight = oW;
params.contrastWeight = cntW;
params.flickerWeight = fW;
params.motionWeight = mW;
params.dklcolorWeight = dW;


obj = simplest_demonstration(params);

end





