function [pseudoImg] = buildPseudoImage(sequencePath, xRadius, yRadius)
    imgs = imageDatastore(sequencePath, "IncludeSubfolders", true, "LabelSource", "foldernames");
    pseudoImg = [];
    for i=1:size(imgs.Files)
        [~, bodyCoords] = getFullSkeleton(char(imgs.Files(i)), xRadius, yRadius);
        r = bodyCoords(:,1);
        g = bodyCoords(:, 2);
        b = zeros(size(bodyCoords, 1), 1);
        rgb = cat(3,r,g, b);
        sPseudoImg = size(pseudoImg, 1);
        sRgb = size(rgb, 1);
        if (sPseudoImg > sRgb)
            temp=[rgb; zeros(sPseudoImg-sRgb, i, 3)];
            pseudoImg = [pseudoImg, temp];
        elseif (sPseudoImg < sRgb)
            temp=[pseudoImg; zeros(sRgb-sPseudoImg, i, 3)];
            pseudoImg = [temp, rgb];
        else
            pseudoImg = [pseudoImg, rgb];
        fprintf('PROGRESS: %i / %i\n', i, size(imgs.Files))
        end
    end
    pseudoImg = pseudoImg(:,2:size(pseudoImg,2),:);
    Imax = max(pseudoImg(:));
    Imin = min(pseudoImg(:));
    pseudoImg = (pseudoImg - Imin)/(Imax - Imin);
    
end