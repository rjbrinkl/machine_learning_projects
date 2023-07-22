% function to create a vocabulary from multiple text files under folders

function voc = buildVoc(folder, voc)

stopword = {'ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', ...
    'about', 'once', 'during', 'out', 'very', 'having', 'with', 'they', 'own', ...
    'an', 'be', 'some', 'for', 'do', 'its', 'yours', 'such', 'into', ...
    'of', 'most', 'itself', 'other', 'off', 'is', 's', 'am', 'or', ...
    'who', 'as', 'from', 'him', 'each', 'the', 'themselves', 'until', ...
    'below', 'are', 'we', 'these', 'your', 'his', 'through', 'don', 'nor', ...
    'me', 'were', 'her', 'more', 'himself', 'this', 'down', 'should', 'our', ...
    'their', 'while', 'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', ...
    'no', 'when', 'at', 'any', 'before', 'them', 'same', 'and', 'been', 'have', ...
    'in', 'will', 'on', 'does', 'yourselves', 'then', 'that', 'because', ...
    'what', 'over', 'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', ...
    'you', 'herself', 'has', 'just', 'where', 'too', 'only', 'myself', ...
    'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', ...
    'theirs', 'my', 'against', 'a', 'by', 'doing', 'it', 'how', ...
    'further', 'was', 'here', 'than'}; % define English stop words, from NLTK



files = dir(fullfile(folder,'*.txt'));

for file = files'
    [fid, msg] = fopen(fullfile(folder,file.name), 'rt');
    error(msg);
    line = fgets(fid); % Get the first line from
     % the file.
    while line ~= -1
        x{1} = line;                         %stores line of input into x
        leftover = x{1};
        y = {};                              %y stores tokenized input
        
        while (leftover ~= "")                                  %loops through leftover while it has not reached the end of a line or finds no additional info to parse
            [y{end + 1}, leftover] = strtok(leftover, ' ');     %strtok uses the space ' ' character to parse the line, storing the parsed string into a cell of y and placing the remainder in leftover
        end
        
        for i=1:length(y)  
            y{1,i} = strtok(y{1,i}, {'-', '?', '!', '?', '+', '"', '.', ',', ':', ')', "'", ' ', '*', '/', '(', ';'});  %parses out symbols from the words in y
        end
        
        y = normalizeWords(y);                %normalizes all elements of y
        
        y = unique(y, 'stable');              %makes sure there is only one instance of each word in y
        
        z = ismember(y, stopword);            %marks words that are stopwords
        t = ismember(y, voc);                 
        
        for i=1:length(z)                     %loops through all indeces of z
            if (z(i) ~= 1 && t(i) ~= 1)       %if index of z isn't a 1
                voc{end + 1} = y{1,i};        %add word to voc
            end
        end
        
        line = fgets(fid);                   %gets the next line of input     
    end
    fclose(fid);
end
