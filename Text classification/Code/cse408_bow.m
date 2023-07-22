% function to create a vocabulary from multiple text files under folders

function feat_vec = cse408_bow(filepath, voc)

[fid, msg] = fopen(filepath, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
feat_vec = zeros(size(voc)); %Initialize the feature vector'

while line ~= -1
    x{1} = line;                         %stores line of input into x
    leftover = x{1};
    y = {};                              %y stores tokenized input
     
    while (leftover ~= "")                                  %loops through leftover while it has not reached the end of a line or finds no additional info to parse
        [y{end + 1}, leftover] = strtok(leftover, ' ');     %strtok uses the space ' ' character to parse the line, storing the parsed string into a cell of y and placing the remainder in leftover
    end
        
    for i=1:length(y)  
        y{1,i} = strtok(y{1,i}, {'?', '!', '?', '+', '"', '.', ',', ':', ')', "'", ' ', '*', '/', '(', ';'});  %parses out symbols from the words in y
    end
        
    y = normalizeWords(y);                %normalizes all words in y
    
    for i=1:length(y)                     %loops through each index of lexicon
        for j=1:length(voc)                       %loops through each index of y
            if (strcmp(y{i}, voc{j}) == 1)  %checks if there is a match between the elements of lexicon and y
                feat_vec(j) = feat_vec(j) + 1;                %increments the corresponding index of z
            end
        end
    end
    
    line = fgets(fid); % Get the next line from file
end
fclose(fid);