function minDistMean = meanNNDistance(pointSet1,PointSet2)

A = pointSet1;
B = PointSet2;

% (optional) drop rows with NaNs
A(any(isnan(A),2),:) = [];
B(any(isnan(B),2),:) = [];

% pairwise distances and per-point minimum (A -> nearest in B)
D = pdist2(A, B);            % size: [numA × numB]
minDist = min(D, [], 2);  
minDistMean = mean(minDist);