%% How to... Add Everything in a Folder to Git
%
% The Simulink Projects interface was not designed to provide access to all
% of Git's command line functionality. Here are a few common tasks that
% users may find useful and how to accomplish them without too much fuss. 
% 
% By David Meissner
% Copyright 2015 The MathWorks, Inc.
%% Step 1: Initialize a Git Repository in your root folder
%
% >>cd ProjectDirectory
%
% >>!git init
%
% * This will create a Git repo in ProjectDirectory, a branch with the default name
% master, and it will make master the current branch.
%
%% Step 2: Do a Dry Run
%
% * git add adds files in the working directory to the staging area. This
% adds the files to a list called the index so Git knows what to commit
% when you make the next commit.
%
% >>!git add -A -n
%
% * The -A tells Git to add all the files in the current directory and all
% subfolders.
% * The -n tells Git that this will just be a dry run.
%
%% Step 3: Add All Files to the Staging Area
%
% >>!git add -A
%
%% Step 4: Make a Commit
%
% >>!git commit -m "Initial commit"
%
% * The -m tells Git that you'll be adding the commit message in the quotes
% that immediately follows.
%