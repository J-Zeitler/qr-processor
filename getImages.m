function images = getImages(file_pre, file_i, file_post)
  disp(sprintf('reading images %d:%d...',file_i(1),file_i(end)));
  images = cell(1,size(file_i,2));
  j = 1;
  for i = file_i
    images{j} = imread([file_pre num2str(i) file_post]);
    j = j + 1;
  end
end
