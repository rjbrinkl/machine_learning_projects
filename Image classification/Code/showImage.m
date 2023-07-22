%displays the image on the screen when the button is pressed on the app
function showImage(file)

folder = '../Data/Database';

[img, cmap] = imread(fullfile(folder,file), 'png');
img = ind2rgb(img, cmap); 
imshow(img);

end