videoFile = ('movie_name.avi') ;
outputPath = ('C:\Users\aksha\OneDrive\Documents\ME in ROBOTICS\SEM 2\EMPM673 PEREPTION IN ROBOTICS\Projects\ENPM673 - Project2_Part1') ;
picFormat = ('JPG') ;
video2pic( videoFile, outputPath, picFormat )






Creating .avi files from images
clear all
close all
clc

%% Import data and set movie file naming convention
framesPerSec                = 30                                                     ;
movie_name                  = ('Lane')                                ;
aviobj                      = avifile(movie_name,'fps',framesPerSec)                ; %Initialize .avi file

dname = ('C:\Users\aksha\OneDrive\Documents\ME in ROBOTICS\SEM 2\EMPM673 PEREPTION IN ROBOTICS\Projects\ENPM673 - Project2_Part1');%Default Directory To be Opened

%% Set up basic file name path to read
top_file                                = [dname '\']                               ;   %Set up main database to open and look inside
ls_top_file                             = ls(top_file)                              ;   %List Files inside main folder
c                                       = cellstr(ls_top_file)                      ;   %Turn cells from ls function into strings
cc                                      = c(3:length(c))                            ;   %Set up a matrix without the . and .. produces by the ls function
S                                       = size(cc)                                  ;   %Find the size of matrix containing names of files inside of main database
a                                       = 1                                         ;   %This counter is set to 3 to account for the . and .. at the begining of each matrix created by "ls"

while a <= S(1)
    close all
    file                                = char(cellstr([top_file char(cc(a))]))     ;   %File to be operated on
    data_n                              = char(cc(a))
    file_name                           = char(cc(a))                               ;
    
    figure
    fileToRead2                         = [dname '\' file_name]                     ;
    imshow((fileToRead2))
    axis tight

    hold off
    h                                   = getframe(gcf)                             ; % get current figure handle
    aviobj                              = addframe(aviobj,h)                        ;    % add frame to .avi file
    a                                   = a+1                                       ;
end

%% Finish Movie
h               = getframe(gcf)                                         ; % get current figure handle
aviobj          = addframe(aviobj,h)                                    ;    % add frame to .avi file
aviobj          = close(aviobj)                                         ;   %Close .avi file
