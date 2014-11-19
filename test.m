% Get training images
clear all;
close all;

sets = cell(8,1);

sets{1} = getImages('images/training/training_1/Bygg_', 11:16, '.png');
sets{2} = getImages('images/training/training_1/Bygg_', 21:26, '.png');
sets{3} = getImages('images/training/training_1/Bygg_', 31:36, '.png');
sets{4} = getImages('images/training/training_1/Bygg_', 41:46, '.png');

sets{5} = getImages('images/training/training_2/Hus_', 11:16, '.png');
sets{6} = getImages('images/training/training_3/Hus_', 21:26, '.png');
sets{7} = getImages('images/training/training_4/Hus_', 31:36, '.png');
sets{8} = getImages('images/training/training_5/Hus_', 41:47, '.png');

messages = cell(8,1);
for c = 1:8
  messages{c} = correctStrings(c);
end

nSets = size(sets,1);
nCorrect = 0;
nImages = 0;

disp('Starting test');
for s = 1:nSets
  imageSet = sets{s};
  setSize = size(imageSet,2);
  if (setSize > 0)
    nImages = nImages + setSize;
    nCorrectInSet = 0;
    disp([' Test set ' num2str(s)]);
    for i = 1:setSize
      image = imageSet{i};
      imageName = sprintf('Image %d:%d',s,i);
      message = qrap(image);
      correct = messages{s};
      if strcmp(message,correct)
        nCorrectInSet = nCorrectInSet + 1;
        disp(['  ' imageName ' correct']);
      else
        disp(['  ' imageName ' incorrect']);
        disp(message);
        disp(messages{s});
      end
    end
    disp([' Results set ' num2str(s) ': ' num2str(nCorrectInSet) '/' num2str(setSize) ' correct']);
    nCorrect = nCorrect + nCorrectInSet;
  end
end

disp('---------------------');
disp(['Results: ' num2str(round(100*nCorrect/nImages)) '% correct']);

