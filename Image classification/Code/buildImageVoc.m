%code to build the database of images based on the featureType
function voc = buildImageVoc(folder, voc, featureType)

featureVec = [];

files = dir(fullfile(folder,'*.png'));      %gets input images

for file = files'                    %loops through all images
    
    [img, cmap] = imread(fullfile(folder,file.name), 'png');
    img = ind2rgb(img, cmap);
    
    small = imresize(img,[128 128], 'bilinear');    %resizes image to consistent size
    
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
        
        featureVec = [x, y, z];
        voc = [voc; featureVec];    %builds database
    
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
                    featureVec = [featureVec, a];

                    avg = 0;
                end
            end
                 
        end
        
        voc = [voc; featureVec];        %builds database
        featureVec = [];
        
    elseif (featureType == 3)      %color histograms      
        
        for i=1:3
            R = small(:,:,i);
            
            h = hist(R(:), 8);
            featureVec = [featureVec, h];
        end
        
        voc = [voc; featureVec];    %builds database
        featureVec = [];
        
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
                featureVec = [featureVec, a];

                avg = 0;
            end
        end

        voc = [voc; featureVec];                %builds database
        featureVec = [];
        
    end
        
end
    
end