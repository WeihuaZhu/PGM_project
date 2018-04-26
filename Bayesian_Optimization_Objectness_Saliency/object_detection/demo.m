imgExample = imread('000103.jpg');
boxes = runObjectness(imgExample,5,params);
figure,imshow(imgExample),drawBoxes(boxes);