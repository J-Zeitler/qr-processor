function images = getImages(file_pre, file_i, file_post)
    images = cell(1,size(file_i,2));
    for i = file_i
        images{i} = imread([file_pre num2str(i) file_post]);
    end
end

