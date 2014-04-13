function [sep,spaces] = histogram (sep)
    
    counter = 1;
    spaces = zeros(size(sep)/2 - 1, 1);
    
    for i = 3 : 2 : size(sep)
            spaces(counter) = sep(i) - sep(i - 1);
            counter = counter + 1;
    end
    figure,hist(spaces);
    [his,centres] = hist(spaces);
    
    %fprintf('space %d\n',spaces);
    %fprintf('histogram %d\n',his);
    %figure,imshow(his);
    
%     zero_array = his(his == 0 );
%     fprintf('%d\n',zero_array);
     
     zero_indices = find( his == 0 );
%    fprintf('zero %d\n',zero_indices);
     
    if ( size(zero_indices) ~= 0 )
        word_gap_threshold = centres(zero_indices(1));
    end
    fprintf('threshold for line is %d\n',word_gap_threshold);
     
     indices = [];
     counter = 1;
     for i = 3 : 2 : size(sep)
            if sep(i) - sep(i - 1) <= word_gap_threshold
                indices(counter) = i;
                counter = counter + 1;
                indices(counter) = i - 1;
                counter = counter + 1;
            end
     end
     sep(indices) = [];
        
end

