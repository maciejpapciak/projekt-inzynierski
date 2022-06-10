dataFolders = {'circling'};
for i=1:size(dataFolders, 2)
    fprintf('TOTAL PROGRESS: %i / %i\n', i, size(dataFolders, 2));
    for j=4:10
        fprintf('GESTURE PROGRESS: %i / %i\n', j, 10);
        [pseudoImg] = buildPseudoImage(strcat('data/circling','/',num2str(j)), 70, 120);
        fileName = fullfile(strcat('output/', dataFolders{i}), strcat(num2str(j),'.jpg'));
        imwrite(pseudoImg, fileName);
    end
end