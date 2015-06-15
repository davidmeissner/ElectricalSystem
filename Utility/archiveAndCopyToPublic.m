%% Archive the Current HEAD can copy it to you public folder
%
% In order to make demo content developed or maintained using Git available
% to those who do not use Git, it's beneficial to place a .zip archive of
% the material in your public folder.
%
% By David Meissner
% Copyright 2015, The MathWorks, Inc.
%% Assumptions
%
% The version of the material that you want to archive is the current HEAD
%
%% Set Defaults
thisProject = slproject.getCurrentProject;
projectName = thisProject.Name;
myPublicFolder = '\\mathworks\AH\Public\David_Meissner\sharedDemos\CoreDemoTemplateGit';

%% Prompt for User Input
prompts = {'File name: (This will overwrite existing files with the same name)', 'Public Folder'};
dialogTitle = 'Archive Project in Public Folder';
num_lines = [1 100; 1 100];
defaultAnswer = {[projectName, '.zip'], myPublicFolder};
option = 'on'; %makes window horizontally resizable
try
    answer = inputdlg(prompts,dialogTitle,num_lines,defaultAnswer, option);
    % Use the defaults unless something else was entered
if exist('answer','var')
    if ~isempty(answer{1})
        fileName = answer{1};
    else
        fileName = projectName;
    end
    if ~isempty(answer{2})
        folderName = answer{2};
    else
        folderName = myPublicFolder;
    end
end

%% Create the Archive
eval(['!git archive -o ', fileName, '.zip HEAD'])

%% Copy/Paste the Archive to your public folder
eval(['copy ', fileName, '.zip ', folderName, ' /Y'])

catch
    disp('Archive operation cancelled')
end

