function spaces = word_segment ( sample_num, bin_t )

    sample_name = strcat('sample',int2str(sample_num));
    sample_no = int2str(sample_num);
    
    if ( ~isdir(strcat('words/', sample_name )) )
        mkdir('words', sample_name);
    end
    
    dir_words = 'words/';
    dir_lines = 'lines/';
    path_to_lines = strcat (dir_lines, sample_no, '/*.jpg');
    no_of_lines  = length(dir(path_to_lines));
    
    for no = 1 : no_of_lines
        path_to_line = strcat(dir_lines, sample_no, '/', int2str(no) , '.jpg');
        text_line = imread(path_to_line);

        s = size(text_line);
        row = s(1,1);
        col = s(1,2);       

        mark = 0;
        sep = zeros(col,1);
        sep_counter = 1;
        
        for c = 1:col
            row_counter = 0;
            for r = 1:row
                if text_line(r,c) <= bin_t && mark ~= 1
                    mark = 1;
                    sep(sep_counter,1) = c;
                    sep_counter = sep_counter + 1;
                    break;
                end
                if text_line(r,c) > bin_t
                    row_counter = row_counter + 1;
                end
            end
            if ( row_counter == row && mark == 1 )
                sep(sep_counter,1) = c;
                mark = 0;
                sep_counter = sep_counter + 1;
            end
        end 
        
        sep = sep(sep > 0);

        if ( mod (size(sep), 2) == 1 )
             sep = sep(1:end - 1, :);
        end
        
     %   sep = thin_line_eliminator(sep, 10); % see file functions.m
        word_no = 1;
        
        [sep,spaces] = histogram(sep);
%          fprintf('%d\n',his);
%          fprintf('space size %d\n',size(spaces,1));

        for i = 1 : 2 : size(sep)
           seg_word = text_line( :, sep(i) : sep(i+1));
           if  size(seg_word,2) > 10  
               seg_word = word_top_n_down_boundaries(seg_word, bin_t); 
               line_name = strcat ( 'line', int2str(no) );
               if ( ~isdir(strcat('words/', sample_name, '/', line_name )))
                    mkdir( strcat(dir_words, sample_name), line_name); 
               end
               word_path_n_name = strcat(dir_words, sample_name, '/',  line_name, '/', int2str(word_no), '.jpg');
               imwrite(seg_word, word_path_n_name);  
               word_no = word_no + 1;
           end
        end
       
    end
end   