function convertFromOldVersion() % This converts .mdl files in the current Simulink Project to .slx
project = slproject.getCurrentProject();
allProjectFiles = project.Files;

for fileIndex = 1:numel(allProjectFiles)
    projectFile = allProjectFiles(fileIndex);
    [folder, name, ext] = fileparts(projectFile.Path);
    if strcmp(ext, '.mdl')
        mdlModel = fullfile(folder, [name, ext]);
        slxModel = fullfile(folder, [name '.slx']);
        load_system(mdlModel);
        save_system(name, slxModel);
        close_system(name,0);
    end
    if strcmp(ext,'.slx') % look for the .slx string
        modelName = projectFile.Path;
        info = Simulink.MDLInfo(modelName); % grab all the model info
        if isempty(strfind(info.ReleaseName,version('-release'))) % strfind returns the indices 
            load_system(modelName);
            close_system(modelName,1);
        end
    end
end
