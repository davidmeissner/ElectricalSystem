function inputFunctions = getInputFunctionList(tbToQuery, createFileListSubstring)
% Returns a Toolbox-by-Toolbox list of "file import" functions
%
% INPUTFUNCTIONS = GETINPUTFUNCTIONLIST(TBTOQUERY,CREATEFILELISTROOT)
%
% This is a helper function for |requiredFiles|.
%
% SYNTAX:
% inputFunctions = getInputFunctionList;
%    Generates list of all IO functions provided on the matlabroot path
% inputFunctions = getInputFunctionList(tbToQuery)
%    Generates list of IO functions for the Toolbox specified by
%    'tbToQuery'; tbToQuery must be the same string used by |ver|. For
%    example, for the Bioinformatics Toolbox, tbToQuery = 'bioinfo';
% inputFunctions = getInputFunctionList(topLevel)
%    Generates list of IO functions at or below the level of directory
%    topLevel.
% inputFunctions = getInputFunctionList(...,createFileListSubstring)
%    Allows optional specification of 'substrings' that indicate a file is
%    of interest. Note that search is case sensitive!
%    Default = {'info','Info','read','Read','att','Att','open','Open','get','Get','load','Load'}
%
%
%%% EXAMPLES:
%%% 1)
% inputFunctions = getInputFunctionList;
% NOTE: This is the default behavior; scans ALL Toolboxes on the MATLABROOT
%       path, using the default createFileListSubstring.
%
%%% 2)
% inputFunctions = getInputFunctionList('Bioinformatics Toolbox');
%
%%% 3)
% inputFunctions = getInputFunctionList('c:\mfiles');
%
%%% NOTE: To query an all-Toolbox list by Toolbox:
% tbToQuery = 'Bioinformatics Toolbox';
% tbFcns = inputFunctions(strcmp({inputFunctions.Toolbox},tbToQuery)).Functions;
%
% NOTE: Files in folders named private, folders that begin with the @
% character (class folders), folders that begin with the + character
% (package folders), or subfolders within any of these, are NOT included.
%
% See also: requiredFiles

% Brett Shoelson, PhD
% brett.shoelson@mathworks.com
% 6/13/14
%
% Copyright 2014 The MathWorks, Inc.

mlrAugmented = fullfile(matlabroot,'toolbox');
mainDir = dir(mlrAugmented);
% Support for ver('fixpoint') is being removed; ver('fixedpoint') should be
% used instead. However; note that 'fixedpoint' also already exists, so we
% can safely remove that entry.
% mainDir(strcmp({mainDir.name},'fixpoint'))=[];
mainDir = mainDir(~ismember({mainDir.name},{'.','..','fixpoint'}));
%
if nargin > 0 && ~isempty(tbToQuery)
	if ~isempty(strfind(tbToQuery,'Toolbox'))
		error('getInputFunctionList: Please specify Toolboxes by their ''product'' strings, as specified in calls to |ver|; For instance, ''Bioinformatics Toolbox'' should be specified as ''bioinfo''.');
	end
	mainDir = mainDir(strcmp({mainDir.name},tbToQuery));
	%mlrAugmented = fullfile(matlabroot,'toolbox',tbToQuery);
end
if nargin < 2 || isempty(createFileListSubstring)
	% Default
	createFileListSubstring = {...
		'info','Info',...
		'read','Read',...
		'att','Att',...
		'open','Open',...
		'get','Get',...
		'load','Load'};
end
inputFunctions = struct('Toolbox','',...
	'ToolboxProductString','',...
	'ParentDir','',...
	'Functions',{});
ind = 0;

h = waitbar(0,'Generating input function list...please wait...');
steps = numel(mainDir);
for ii = 1:numel(mainDir)
	fileList = [];
	%	tmpName = mainDir(ii).name;
	% 	fprintf('Getting inputFiles from directory %s\n',tmpName)
	% 	if strcmp(tmpName,'matlab')
	% 		tmpName
	% 	end
	%  if isdir(tmpName) && ~ismember(tmpName,{'.','..'})
	ind = ind + 1;
	tmp = ver(mainDir(ii).name);
	inputFunctions(ind).Toolbox = tmp.Name;
	inputFunctions(ind).ToolboxProductString = mainDir(ii).name;
	inputFunctions(ind).ParentDir = fullfile(mlrAugmented,mainDir(ii).name);
	allPaths = genpath(fullfile(mlrAugmented,mainDir(ii).name));
	allPaths = textscan(allPaths,'%s','delimiter',';');
	allPaths = allPaths{1};
	for kk = 1:size(allPaths,1)
		substring = allPaths{kk};
		for jj = 1:numel(createFileListSubstring)
			fileList = [fileList;dir(fullfile(substring,['*' createFileListSubstring{jj} '*.m']))];
		end
	end
	% Strip '.m', alphabetize:
	fileList = regexprep({fileList.name}','\.m','');
	fileList = unique(fileList);
	inputFunctions(ind).Functions = sortrows(fileList);
	%end
	waitbar(ii / steps)
end
close(h)