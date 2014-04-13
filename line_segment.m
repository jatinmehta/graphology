function sep = line_segment(img_name, bin_t)
    img_name = int2str(img_name);
    if ( ~isdir(strcat('lines/', img_name)) )
        mkdir('lines',img_name);
    end
    dir_samples = 'samples/';
    dir_lines = strcat('lines/', img_name, '/');
    img_name = strcat(img_name, '.jpg');
    img = imread(strcat(dir_samples, img_name));
    img = rgb2gray(img);
%    img = medfilt2(img,[3 3]);

    s = size(img);
    row = s(1,1);
    col = s(1,2);
    
    img = binarize(img, img_name, bin_t);

    sep = zeros(row, 1);
    mark = 0;
    
    for i = 1:row
        col_counter = 0;
        for j = 1:col
            if img(i,j) <= bin_t && mark ~= 1
                mark = 1;
                sep(i,1) = i;
                break;
            end
            if img(i,j) > bin_t
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
   
   sep = thin_line_eliminator(sep, 25); % see file functions.m
   
   line_no = 1;

   for i = 1 : 2 : size(sep)
       seg_line = img( sep(i) : sep(i+1), : );
       line_path_n_name = strcat(dir_lines, int2str(line_no), '.jpg');
       imwrite(seg_line, line_path_n_name);
       line_no = line_no + 1;
   end
   
end