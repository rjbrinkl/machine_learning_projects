% function of lexicon based sentimental Analysis
% Input: a path to the target text file
% Output: a sentimental score of the text

function sent_score = sentimentalAnalysis(filename)


lexicon = '../Data/wordwithStrength.txt';

[fid, msg] = fopen(lexicon, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
%Initialize a Map structure to store the lexicon
cM = containers.Map();
while line ~= -1

    %fprintf('%s', line); % Print the line on
    ii = 1;
    token={};
    while any(line)
        [token{ii}, line] = strtok(line);
        % Repeatedly apply the
        ii = ii + 1; % strtok function.
    end
    cM(token{1}) = str2double(token{2});
    
    line = fgets(fid); % Get the next line
    % from the file.
end
fclose(fid);

[fid, msg] = fopen(filename, 'rt');
error(msg);
line = fgets(fid); % Get the first line from
 % the file.
test_token={};
ii = 1;
while line ~= -1
     %Store each word in the test_token array
     x{1} = line;                         %stores line of input into x
    leftover = x{1};
     
    while (leftover ~= "")                                  %loops through leftover while it has not reached the end of a line or finds no additional info to parse
        [test_token{end + 1}, leftover] = strtok(leftover, ' ');     %strtok uses the space ' ' character to parse the line, storing the parsed string into a cell of y and placing the remainder in leftover
    end
        
    for i=1:length(test_token)  
        test_token{1,i} = strtok(test_token{1,i}, {'?', '!', '?', '+', '"', '.', ',', ':', ')', "'", ' ', '*', '/', '(', ';'});  %parses out symbols from the words in y
    end
    
    line = fgets(fid);                    %gets next line of input
end
fclose(fid);

sent_score = 0;
for k=1:length(test_token)                %loops through indeces of test_token
    if (isKey(cM, test_token{k}) == 1)    %if the value of test_token is a key in cM
        sent_score = sent_score + cM(test_token{k});    %adds to the current sent_score
    end
end 

%accuracy seems to be higher than the other tests with the positive reviews, but the negative
%reviews caused more inaccuracies with an overall correctness of 0.6667

if sent_score > 0
     if sent_score > 0.7
         disp(sent_score);
         disp('Highly Positive Sentiment');
     else
        disp(sent_score);
        disp('Positive Sentiment');
     end
end

if sent_score < 0
    if sent_score < -0.7
         disp(sent_score);
         disp('Highly Negative Sentiment');
    else
         disp(sent_score);
         disp('Negative Sentiment');
    end
end

if sent_score == 0
    disp('Neutral Sentiment');
end
