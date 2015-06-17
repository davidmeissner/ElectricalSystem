function result = saveAndLabelModels_Fcn(file)
%saveModelFiles  Simulink Project batch job to save dirty Simulink files
%
% Input arguments:
%  file - string - The absolute path to a file included in the batch job.
%  When you run the batch job, the Simulink Project Tool provides the file
%  input for each selected file.
%
% Output arguments:
%  result - string - If the file was dirty, the result indicates that the
%  file was saved. The Simulink Project Tool displays this result in the
%  Batch Job Results column.
%
% Copyright 2012 The MathWorks, Inc.


[~, name, ext] = fileparts(file);
if ismember(ext, {'.mdl','.slx'})
    if bdIsLoaded(name) && ...
            strcmp(get_param(name, 'dirty'), 'on')
        
        try
            save_system(file);
            project = simulinkproject;
            projectFile = findFile(project, file);
            addLabel(projectFile, 'Review','To Review');
            result = 'Saved file. Added label: To Review';
        catch exception
            warning(exception.message);
            result = 'Failed to save file';
        end
    else
        result = 'No save required';
    end
else
    result = [];
end

end
