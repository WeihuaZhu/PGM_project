function mean_score = evaluate_score(params)
load pascal_gt_data.mat
display(['computing the model mean score for the test images']);
fileFolder=fullfile('.\testset\test_images');
dirOutput=dir(fullfile(fileFolder,'*.jpg'));
fileNames={dirOutput.name}';
GT = impos(55:69);%%GROUND TRUTH for test images
mean_score = 0;


for i = 1:length(fileNames)
    imgExample = imread(['.\testset\test_images\',fileNames{i}]);
    boxes = runObjectness(imgExample,5,params);
    mean_score = mean_score + computeOverlapScore(boxes,GT(i).boxes);
    figure,imshow(imgExample),drawBoxes(boxes);
end

mean_score = mean_score./length(fileNames);
end
