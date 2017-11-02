warning off;


%# create AVI object
nFrames = 250; % set number of images
vidObj = VideoWriter('lane2.avi'); % name your movie
vidObj.Quality = 100;% set quality
vidObj.FrameRate = 30; %set framerate
open(vidObj);
filepath = ('C:\Users\aksha\OneDrive\Documents\ME in ROBOTICS\SEM 2\EMPM673 PEREPTION IN ROBOTICS\Projects\ENPM673 - Project2_Part1\Frames/'); %set filepath
%# create movie
for k=1:nFrames
  I= imread([filepath, 'Final Frame'  ,num2str(k), '.jpg']);
I2=im2double(I); 
figure(),imshow(I2)
   writeVideo(vidObj, getframe(gca));
   close all;
end
close(gcf)

%# save as AVI file, and open it using system video player
close(vidObj);
winopen('lane2.avi')