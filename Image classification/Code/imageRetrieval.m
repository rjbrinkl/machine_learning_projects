%code to determine the knn classification using the DstType, train_feat,
%and test_feat
function imgRet = imageRetrieval(test_feat, train_feat, DstType)

D = zeros(length(train_feat), 1);
imgRet = zeros(10, 1);

if DstType == 1
    for i=1:length(train_feat)                               %loops through rows of train_feat
        prod = 0;
        for j=1:size(train_feat, 2)                                %loops through columns of train_feat
            prod = prod + (test_feat(j) - train_feat(i,j))^2;   %calculates SSD
        end
        D(i) = prod;                                          %stores prod in index of SSD
    end  
    
elseif DstType == 2
    
    sum1 = zeros(length(train_feat), 1);                       %creates array of zeros
    sum2 = zeros(length(train_feat), 1);                       %creates array of zeros
    
    for i=1:length(train_feat)                                 %loops through rows of train_feat
        prod = 0;
        for j=1:size(train_feat, 2)                              %loops through columns of train_feat
            sum1(i) = sum1(i) + (test_feat(j))^2;
            sum2(i) = sum2(i) + (train_feat(i,j))^2;
            prod = prod + (test_feat(j) * train_feat(i,j));     %intermediate calculations
        end      
        D(i) = prod;
    end
    
    for i=1:length(train_feat)
        D(i) = cos(D(i) / (sqrt(sum1(i)) * sqrt((sum2(i)))));   %computes angle between vectors
    end
    
end

[B,I] = sort(D);           %sorts the info

%imgRet = [];
for k=2:11                  %excludes the first image (should be the original image)
    imgRet(k-1) = I(k);     %stores first 10 images for return
end

end
