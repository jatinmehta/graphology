function img = binarize(img, img_name, threshhold)
    dir_bin_samples = 'bin_samples/';
    s = size(img);
    row = s(1,1);
    col = s(1,2);

    for i = 1:row
        for j = 1:col
            if img(i,j) > threshhold
                img(i, j) = 255;
            end
        end
    end
    imwrite(img, strcat(dir_bin_samples, img_name), 'jpg');
end