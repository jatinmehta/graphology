function pix = remove_loop()
    im = imread('words/sample4/Line2/5.jpg');   
   % im = rgb2gray(im);
    s = size(im);
    row = s(1,1);
    col = s(1,2);
    pix = [];
     for i = 1:row
         count = 0;
         for j = 1:col
             if im(i,j) <= 200
                 count = count + 1;
             end
         end
         pix(1,i) = count;
     end
  x = 1:row;
  plot(x,pix);
  img = im(1:35,:);
  figure,imshow(img);
  img = im(1:37,:);
  figure,imshow(img);
end