% Make an avi movie from a collection of PNG images in a folder.
% Specify the folder.
myFolder = 'C:\Users\aksha\OneDrive\Documents\ME in ROBOTICS\SEM 2\EMPM673 PEREPTION IN ROBOTICS\Projects\ENPM673 - Project2_Part1';
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end
% Get a directory listing.
filePattern = fullfile(myFolder, 'JPG');
jpgFiles = dir(filePattern);
% Open the video writer object.
writerObj = VideoWriter('YourAVI.avi');
% Go through image by image writing it out to the AVI file.
for frameNumber = 1 : length(jpgFiles)
    % Construct the full filename.
    baseFileName = jpgFiles(frameNumber).name;
    fullFileName = fullfile(myFolder, baseFileName);
    % Display image name in the command window.
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Display image in an axes control.
    thisimage = imread(fullFileName);
    imshow(imageArray);  % Display image.
    drawnow; % Force display to update immediately.
    % Write this frame out to the AVI file.
    writeVideo(writerObj, thisimage);
end
% Close down the video writer object to finish the file.
close(writerObj);