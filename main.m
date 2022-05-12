% [img, bodyCoords] = getFullSkeleton('img/img (1).jpg', 70, 120);
% imshow(img)
[pseudoImg] = buildPseudoImage('img', 70, 120);
imshow(pseudoImg)