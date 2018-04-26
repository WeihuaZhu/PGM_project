% function total_score = simplest_demonstration(params)
% example of how to call gbvs with default params
figrimDir = ('samplepics/FIGRIM/');
dataset = dir(fullfile(strcat(figrimDir,'images/'),'*.jpg'));
score3 = [];
for i = 1 : 30%length(dataset)
    fprintf('Testing Image %0.0f/%0.0f\n',i,30); 
    if (i ~= 20)
    baseImgName = dataset(i).name;
    fullImgName = fullfile('samplepics/FIGRIM/images/', baseImgName);
    fullFixlocName = fullfile('samplepics/FIGRIM/fixlocs/', strcat(baseImgName(1:end-4),'.mat'));
    
    img = imread(fullImgName);
    fixations = load(fullFixlocName);
    [frow, fcol] = find(fixations.fixLocs == 1);
%     tic
    params = makeGBVSParams();
%     toc
    out_gbvs = gbvs(img, params);
    out_itti = ittikochmap(img); % don't worry about this, for visualization purposes
%     rc = load('row_col.mat');
%     X = rc.row;
%     Y = rc.col;
    %  
    % This outputs ROC Area-Under-Curve Score between a saliency map and fixat-
    %         ions.
    % 
    %          salmap       : a saliency map
    %          X            : vector of X locations of fixations in original image
    %          Y            : vector of Y locations of fixations in original image
    %          origimgsize  : size of original image (should have same aspect ratio as
    %                         saliency map) 
    score3 = [score3;rocScoreSaliencyVsFixations(out_gbvs.master_map, frow, fcol, out_gbvs.paramsUsed.origimgsize)];

    % Below is visualization of saliency map, comment out if you like %
    figure
    subplot(2,1,1);
    imshow(img);
    title('Original Image');

    subplot(2,1,2);
    show_imgnmap(img,out_gbvs);
    title('GBVS map overlayed');

%     subplot(2,3,3);
%     show_imgnmap(img,out_itti);
%     title('Itti/Koch map overlayed');
% 
% 
%     subplot(2,3,5);
%     imshow( out_gbvs.master_map_resized );
%     title('GBVS map');
% 
%     subplot(2,3,6);
%     imshow(out_itti.master_map_resized);
%     title('Itti/Koch map');
    
    % Comment below to run without pause
%     if ( i < 210 )
%         fprintf(1,'Now waiting for user to press enter...\n');
%         pause;
%     end
    end
end
total_score = sum(score3);