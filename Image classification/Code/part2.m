%part 2 loads in the feature vectors and uses pca() to transform the images
%into a 2D space
folder = '../Data/Database';
load('feature_vgg_f.mat');  %loads in the data

x = [];
for i=1:length(image_feat)
    x = [x, image_feat(i).feat];    %extracts the feature vectors and stores them in x
end
x = x';
[coeff, score] = pca(x);  %computes the pca

%score should contain the principal components extracted in order of
%importance
pc1 = score(:,1); 
pc2 = score(:,2); 

plot(pc1, pc2, 'o');    %plot with pc1 in x and pc2 in y
hold on

for i=1:length(image_feat)
    [img, cmap] = imread(fullfile(folder,image_feat(i).name), 'png');
    img = ind2rgb(img, cmap); 

    image([pc1(i,1) pc1(i,1)+6],[pc2(i,1) pc2(i,1)+4],flipud(img)); %plots images with bottom left corner at the point associated
end


