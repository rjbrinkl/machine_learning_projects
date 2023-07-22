%code to test part 1

function images = part1(fileName, featureType, KNN)

%featureTypes: 1 is avg pixel color, 2 is spatial grid of pixel colors, 3
%is color histogram, 4 is avg edge energy

%KNN: 1 is SSD, 2 is angle between vectors

folder = '../Data/Database';
voc = [];
files = dir(fullfile(folder,'*.png'));
featureLib = buildImageVoc(folder, voc, featureType);           %builds the feature library of all the images using the specified featureType

test_feat = [];                                                 %builds test feature from input image
    [img, cmap] = imread(fullfile(folder,fileName), 'png');
    img = ind2rgb(img, cmap); 
    small = imresize(img,[128 128], 'bilinear');                %resizes image to consistent shape
    imshow(small);
    
    if (featureType == 1)       %avg pixel color
        
        R = small(:,:,1);
        G = small(:,:,2);
        B = small(:,:,3);
        
        x = 0;
        y = 0;
        z = 0;
               
        for i=1:length(R)
            for j=1:length(R)
                x = x + R(i,j);
            end
        end
        for i=1:length(G)
            for j=1:length(G)
                y = y + G(i,j);
            end
        end
        for i=1:length(B)
            for j=1:length(B)
                z = z + B(i,j);
            end
        end
        
        x = x/length(R);
        y = y/length(G);
        z = z/length(B);
        
        test_feat = [x, y, z];      %builds test_feat
      
    elseif (featureType == 2)      %spatial grid of avg pixel colors
        
        for h=1:3
            R = small(:,:,h);
            G = mat2cell(R, 32*ones(size(R,1)/32,1), 32*ones(size(R,2)/32,1))       %creates 4x4 cell array of 32x32 matrices
        
            avg = 0;
            a = zeros(1);
        
            for i=1:4
                for j=1:4
                    for k=1:32
                        for m=1:32
                            avg = avg + G{i,j}(k,m);
                        end
                    end

                    a(1) = avg/32;
                    test_feat = [test_feat, a]; %builds test_feat

                    avg = 0;
                end
            end
                 
        end
        
    elseif (featureType == 3)      %color histograms      
        
        for i=1:3
            R = small(:,:,i);
            
            h = hist(R(:), 8);
            test_feat = [test_feat, h];     %builds test_feat
        end
        
    elseif (featureType == 4)      %edge extraction, edge energy in spatial grid
                    
        R = small(:,:,1);
        e = edge(R, 'Canny');
        G = mat2cell(e, 32*ones(size(e,1)/32,1), 32*ones(size(e,2)/32,1))       %creates 4x4 cell array of 32x32 matrices

        avg = 0;
        a = zeros(1);

        for i=1:4
            for j=1:4
                for k=1:32
                    for m=1:32
                        avg = avg + G{i,j}(k,m);
                    end
                end

                a(1) = avg;
                test_feat = [test_feat, a];         %builds test_feat

                avg = 0;
            end
        end
        
    end

test = imageRetrieval(test_feat ,featureLib, KNN);  %determines top 10 most similar images indeces
file = files';
images = {};
for j=1:10
    [img, cmap] = imread(fullfile(folder,file(test(j)).name), 'png');
    img = ind2rgb(img, cmap); 
    images{end + 1} = file(test(j)).name;           %images holds the names of the top 10 images
end

end
