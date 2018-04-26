function s = computeOverlapScore(box,GTbox)
% compute the overlap between two box matrix
% box is the computed box matrix (default as top 5)
% GTbox is the ground truth box matrix of the test image
% return the weighted overlap score of the image
s = 0;
n = size(box,1);
m = size(GTbox,1);
for i = 1:n
    for j= 1:m
        if (boxOverlapCheck(box(i,1:4),GTbox(j,:)) == 1)
            s = s + box(i,5)*1;
            break
        end 
    end
end



end
