function [pseudoImg] = buildPseudoImage(sequencePath, xRadius, yRadius)
    imgs = imageDatastore(sequencePath, "FileExtensions", '.jpg');
    pseudoImg = [];
    for i=1:size(imgs.Files)
        [~, bodyCoords] = getFullSkeleton(char(imgs.Files(i)), xRadius, yRadius);
        r = bodyCoords(:,1);
        g = bodyCoords(:, 2);
        b = zeros(size(bodyCoords, 1), 1);
        pseudoImg = [pseudoImg, cat(3,r,g, b)];
    end

    Imax = max(pseudoImg(:));
    Imin = min(pseudoImg(:));
    pseudoImg = (pseudoImg - Imin)/(Imax - Imin);
end