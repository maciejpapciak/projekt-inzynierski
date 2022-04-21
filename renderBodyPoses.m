% INPUT
%   im: image to render poses onto
%   poses: matrix of size [numPeople * 18(aka numBodyParts) * 2(x,y)]
%       records locations of each body part for each person in the image,
%       the location value is [NaN, NaN] if that body part is not found in
%       the image
%   outputHeight: height of the neural network output, which is the
%       coordinate reference for the poses
%   outputWidth: width of the neural network output, which is the
%       coordinate reference for the poses
%   params: struct with constants
function [im, bodyParts] = renderBodyPoses(im,poses,outputHeight,outputWidth,params)
    bodyParts = zeros(size(poses,1), 4);
    [inputHeight,inputWidth,~] = size(im);
    
    for i = 1:size(poses,1)
       for j = 1:size(params.RENDER_PAIRS,1)
           partA = params.RENDER_PAIRS(j,1);
           partB = params.RENDER_PAIRS(j,2);
           
           x1 = poses(i,partA,1);
           y1 = poses(i,partA,2);
           x2 = poses(i,partB,1);
           y2 = poses(i,partB,2);
           [x1,y1] = convertCoords(x1,y1,inputHeight,inputWidth,outputHeight,outputWidth);
           [x2,y2] = convertCoords(x2,y2,inputHeight,inputWidth,outputHeight,outputWidth);
           
           color = squeeze(params.PAIR_COLORS(j,:));
           line = [x1 y1 x2 y2];
           
           if ~any(isnan(line))
                im = insertShape(im,'Line',line,'LineWidth',2,'Color',color);
                bodyParts(j, 1) = x1;
                bodyParts(j, 2) = y1;
                bodyParts(j, 3) = x2;
                bodyParts(j, 4) = y2;
           end
       end
    end
    bodyParts=bodyParts(any(bodyParts,2),any(bodyParts,1));
end