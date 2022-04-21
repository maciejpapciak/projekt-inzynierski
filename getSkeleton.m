function [cloud, heatMap] = getSkeleton(frame)
imwrite(frame, '.\temp\handImage.bmp');
% cd utils\heatmaps\
system('GetSkeleton.exe .\temp\handImage.bmp .\temp\skeletonData.txt .\temp\heatMap.bmp');
% cd ..\..\
cloud = loadSkeleton('.\temp\skeletonData.txt');
heatMap = imread('.\temp\heatMap.bmp');
delete('.\temp\handImage.bmp');
delete('.\temp\skeletonData.txt');
delete('.\temp\heatMap.bmp');