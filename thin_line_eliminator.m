   function sep = thin_line_eliminator(sep, th)
        indices = [];
        counter = 1;
        for i = 1 : 2 : size(sep)
           if sep(i + 1, 1) - sep(i, 1) <= th
               indices(counter) = i;
               counter = counter + 1;
               indices(counter) = i + 1;
               counter = counter + 1;
           end
        end
        sep(indices) = [];
   end