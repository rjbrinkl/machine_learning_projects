% function to run KNN classification


function pred_label = cse408_knn(test_feat, train_label, train_feat, k, DstType)

D = zeros(size(train_feat, 2), 1);                            %creates array of zeros

if DstType == 1 %SSD
    for i=1:size(train_feat, 2)                                 %loops through columns of train_feat
        prod = 0;
        for j=1:length(train_feat)                              %loops through rows of train_feat
            prod = prod + (test_feat(j) - train_feat(j,i))^2;   %calculates SSD
        end
        D(i) = prod;                                          %stores prod in index of SSD
    end    
elseif DstType == 2 %Angle Between Vectors
    sum1 = zeros(size(train_feat, 2), 1);                       %creates array of zeros
    sum2 = zeros(size(train_feat, 2), 1);                       %creates array of zeros
    
    for i=1:size(train_feat, 2)                                 %loops through columns of train_feat
        prod = 0;
        for j=1:length(train_feat)                              %loops through rows of train_feat
            sum1(i) = sum1(i) + (test_feat(j))^2;
            sum2(i) = sum2(i) + (train_feat(j,i))^2;
            prod = prod + (test_feat(j) * train_feat(j,i));     %intermediate calculations
        end      
        D(i) = prod;
    end
    
    for i=1:size(train_feat, 2)
        D(i) = cos(D(i) / (sqrt(sum1(i)) * sqrt((sum2(i)))));   %computes angle between vectors
    end
elseif DstType == 3 %Number of words in common
    K = sum(min(train_feat, repmat(test_feat, 1, size(train_feat, 2)))); %calculates the sum of the minimums of each index of test_feat and the corresponding part of train_feat
    D = K';
    D = -D; %This is done to sort by the doc with the highest number of words, not lowest
end

%Find the top k nearest neighbors, and do the voting. 

[B,I] = sort(D);

posCt=0;
negCt=0;
for ii = 1:k
    if train_label(I(ii)) == 1
        posCt = posCt + 1;
    elseif train_label(I(ii)) == 0
        negCt = negCt + 1;
    end    
end

if posCt >= negCt
    pred_label = 1;
else
    pred_label = 0;
end