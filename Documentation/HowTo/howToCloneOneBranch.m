%% How to... Clone Just One Branch from a Remote Repository
%
% The Simulink Projects interface was not designed to provide access to all
% of Git's command line functionality. Here are a few common tasks that
% users may find useful and how to accomplish them without too much fuss. 
% 
% By David Meissner
% Copyright 2015 The MathWorks, Inc.
%% Step 1: Create a place for your local files
%
% >>mkdir NewDirectory
%
% >>cd NewDirectory
%
%% Step 2: Initialize a Git Repository
%
% >>!git init
%
% * This will create a Git repo in NewDirectory, a branch with default name
% master, and it will make master the current branch.
%
%% Step 3: Add the Branch of the Remote Repo
%
% From the Window's Command Line
%
% >git remote add -f -t master -m master origin git://example.com/git.git/
%
% * Enter the required authentication
%
%
%% Step 4: Merge the Remote Branch into the Current Branch
%
% >git merge origin
%