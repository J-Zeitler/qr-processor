% Get training images
clear all;
close all;

sets = cell(10,1);

%sets{1} = getImages('images/training/training_1/Bygg_', 11:16, '.png');
%sets{2} = getImages('images/training/training_1/Bygg_', 21:26, '.png');
%sets{3} = getImages('images/training/training_1/Bygg_', 31:36, '.png');
%sets{4} = getImages('images/training/training_1/Bygg_', 41:46, '.png');

%sets{5} = getImages('images/training/training_2/Hus_', 11:16, '.png');
%sets{6} = getImages('images/training/training_3/Hus_', 21:26, '.png');
%sets{7} = getImages('images/training/training_4/Hus_', 31:36, '.png');
%sets{8} = getImages('images/training/training_5/Hus_', 41:47, '.png');

nSets = size(sets,1);

for s = 1:nSets
  imageSet = sets{s};
  setSize = size(imageSet,2);
  for i = 1:setSize
    image = imageSet{i};
    message = qrap(image, sprintf('Image %d:%d',s,i));
    pause;
  end
end