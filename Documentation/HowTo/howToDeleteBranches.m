%% How to... Delete Branches in Git from MATLAB
%
% The Simulink Projects interface was not designed to provide access to all
% of Git's command line functionality. Here are a few common tasks that
% users may find useful and how to accomplish them without too much fuss. 
% 
% By David Meissner
% Copyright 2015 The MathWorks, Inc.
%% Delete a Local Branch
%
% You can view branches from the "Manage Branches" dialog box, but to 
% delete a branch you need to go one step further. Try this:
%
% From the MATLAB command line:
%
% >>!git branch -v              
%
% Note: This will list all local branches, the commit ID for the HEAD of that branch and the commit message for that commit.
% 
% Now, delete a branch named 'dev' from the MATLAB command line:
%
% >>!git branch -d dev
%
%% Delete a Remote Branch
%
% To delete a remote that exists on a server that requires authentication, 
% deleting the remote branch requires an interface that will present the
% prompt for username/password. One tool I typically use is the Git Bash
% application.
%
% From the Git Bash command line: 
%
% Note: 
%
% # In Linux that $ replaces >>
% # I have set my preferences so that my prompt includes username, current branch and current folder name.
%
% dmeissne (master) FolderName $git push origin --delete branchName        % origin is the handle for the remote repo                
%
% Username for 'http://insidelabs-git.mathworks.com':               
%
% Password for 'http://dmeissne@insidelabs-git.mathworks.com':      
%


 
