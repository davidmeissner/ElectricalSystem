%% How to... Manage Remote Git Repositories from MATLAB
%
% The Simulink Projects interface was not designed to provide access to all
% of Git's command line functionality. Here are a few common tasks that
% users may find useful and how to accomplish them without too much fuss. 
% 
% By David Meissner
% Copyright 2015 The MathWorks, Inc.
%% Viewing Remote Repositories
%
% You can view one remote repo in Simulink Projects, but it's often
% advantageous to collaborate with team members across multiple remotes
%
% To review the remote repositories you have set up, get a list of their
% handles or shortnames using:
%
% >>!git remote
%
% origin                                          
%
% To view the URLs, as well, use: 
%
% >>!git remote -v
%
% origin	http://insidelabs-git.mathworks.com/dmeissne/myProject.git (fetch)
% 
% origin	http://insidelabs-git.mathworks.com/dmeissne/myProject.git (push)
%
%% Adding Remotes
%
% >>!git remote add remoteHandle http://insidelabs-git.mathworks.com/dmeissne/myProject.git
%
%% Fetching and Pulling from Remotes
%
% >>!git fetch remoteHandle
%
%% Pushing to Remotes
%
% From the Windows Command Line or Git Bash:
%
% >git push remoteHandle localBranchName
%
% Enter authentication, as required.
%
%% Inspecting a Remote
%
% >>!git remote show remoteHandle
%
%% Renaming a Remote
%
% >>!git remote rename oldHandle newHandle
%
%% Removing a Remote
%
% >>!git remote rm remoteHandle
%

