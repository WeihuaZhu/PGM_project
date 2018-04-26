function y = boxOverlapCheck(box1, box2)
% check if two boxes have more than threshold overlap
threshold = 0.5; % defualt threshold, can be modified
if box1(1)>= box2(3) || box1(3)<= box2(1) || box1(2)>= box2(4) || box1(4) <= box2(2)
    y = 0;
else
    x1 = max([box1(1),box2(1)]);
    y1 = max([box1(2),box2(2)]);
    x2 = min([box1(3),box2(3)]);
    y2 = min([box1(4),box2(4)]);
    inner_area = abs((x2-x1).*(y2-y1));
    outer_area = (box1(3)-box1(1)).*(box1(4)-box1(2)) + (box2(3)-box2(1)).*(box2(4)-box2(2));
    outer_area = outer_area - inner_area;
    if (inner_area./outer_area >= threshold)
        y = 1;
    else
        y = 0;
    end
end