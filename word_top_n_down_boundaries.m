function  word = word_top_n_down_boundaries( word, bin_t )

    s = size(word);
    row = s(1,1);
    col = s(1,2);

    sep = zeros(row, 1);
    mark = 0;
    
    for i = 1:row
        col_counter = 0;
        for j = 1:col
            if word(i,j) <= bin_t && mark ~= 1
                mark = 1;
                sep(i,1) = i;
                break;
            end
            if word(i,j) > bin_t
                col_counter = col_counter + 1;
            end
        end
        if ( col_counter == col && mark == 1 )
            sep(i,1) = i;
            mark = 0;
        end
    end 

   sep = sep(sep > 0);

   if ( mod (size(sep),2) == 1 )
        sep = sep(1:end - 1, :);
   end

   sep = thin_line_eliminator(sep, 7); % see file functions.m
   line_no = 1;
    
    if (size(sep, 1) > 2 )
        sep(2:end-1) = [];
    end

   for i = 1 : 2 : size(sep)
        word = word( sep(i) : sep(i+1), : );  
       line_no = line_no + 1;
   end
end

