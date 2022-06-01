function [imWithPoses, bodyCoords, bodyParts] = getFullSkeleton(filename, xRadius, yRadius)
    im = imread(filename);
    [imWithPoses, bodyParts] = getOpenPoseSkeleton(im);
    size(bodyParts, 1)
    if size(bodyParts,1) == 11
        handCoords = [bodyParts(4,3), bodyParts(4,4); bodyParts(6,3), bodyParts(6,4)];
    elseif size(bodyParts, 1) == 9
        handCoords = [bodyParts(4,3), bodyParts(4,4)];
    end
    finalHand = [];
    for i=1:size(handCoords,1)
        handIm = imcrop(imWithPoses, [handCoords(i,1)- xRadius, handCoords(i,2)-yRadius, xRadius*2, yRadius]);
        figure;imshow(handIm)
        [skeleton] = getSkeleton(handIm);
        
        % recalculate hand skeleton coords
        coords = skeleton.Location(:,1:2);
        for j=1:size(coords)
            x = coords(j,1);
            y = coords(j,2);
            coords(j,1) = x + handCoords(i,1) - xRadius;
            coords(j,2) = y + handCoords(i,2) - yRadius;
        end
        [imWithPoses]= renderSkeleton(imWithPoses, coords);
        finalHand = [finalHand; coords];
    end

    bodyCoords = [bodyParts(:,1:2); bodyParts(:,3:4); finalHand];
    bodyCoords = unique(bodyCoords, 'rows', 'stable');
end