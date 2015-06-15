function [fileList,productList,loadedFiles,hasCopyright] = requiredFiles(mainFiles,createZip)
% Returns a complete list, augmented with filenames called by I/O
% functions, required to run the program files specified by files.
%
% COMMENTED LINES WILL BE IGNORED!
% (Thanks to Peter Acklam!)
% LOADED FILES PROVIDED BY MATHWORKS WILL BE IGNORED!
%
% Optionally creates a zip file; optionally checks for copyright
% indications; optionally indicates with MathWorks' products are required.
%
% SYNTAX:
% [fileList,productList,loadedFiles,hasCopyright] = requiredFiles(fnames,createZip)
%
% INPUTS:
%
% fnames:
%   string or cell array of strings
%      List of files for analysis, specified as a string or cell array of
%      strings. Each string is the name of a single MATLAB program file.
%      All files and dependencies must be on the MATLAB path.
%
% createZip:
%   true/{false}
%      Optional logical indicator of whether you want to output a zip file.
%
% OUTPUTS:
%
% See also: matlab.codetools.requiredFilesAndProducts

% Brett Shoelson, PhD
% brett.shoelson@mathworks.com
% 6/12/14
%
% Copyright The MathWorks, Inc. 2014

% persistent inputFunctionList
inputFunctionList = [];
%
u_p = userpath;
u_p = u_p(1:end-1);
mlroot = matlabroot;
productList = [];
zipFile = [];
%
if nargin < 2 || isempty(createZip)
	createZip = false;
end
if nargout < 4
	checkForCopyright = false;
else
	checkForCopyright = true;
end
%
% (If you want to trigger a manual re-generation of those files, you can go
% to your userpath and delete the file inputFunctionList.mat.
% u_p = userpath
% cd(u_p(1:end-1)) %there’s an unwanted semicolon that needs to be removed

if isempty(inputFunctionList)
	try
		inputFunctionList = load(fullfile(u_p,'inputFunctionList'));
		inputFunctionList = inputFunctionList.inputFunctionList;
		disp('Pre-generated function list loaded.......')
	catch
		disp('Preparing function list for first use; this will take a moment.......')
		inputFunctionList = getInputFunctionList;
		save(fullfile(u_p,'inputFunctionList'),'inputFunctionList');
	end
end
disp('Checking for required products and code files.......')
[fileList, productList] = matlab.codetools.requiredFilesAndProducts(mainFiles);
fileList = fileList';
disp('Checking for required data files.......')
loadFunctions = getLoadFunctions(productList,inputFunctionList);
loadedFiles = {};
if checkForCopyright
	hasCopyright = false(numel(fileList),1);
end
for ii = 1:numel(fileList)
	if checkForCopyright
		fprintf('Analyzing file %s for copyright and data-file dependencies.\n',fileList{ii})
		hasCopyright(ii) = checkForCopyrightFcn(fileList{ii});
	else
		fprintf('Analyzing file %s for data-file dependencies.\n',fileList{ii})
	end
	mlstripcomments(fileList{ii}, fullfile(u_p,'tempFileNoComments.txt'))
	% MLSTRIPCOMMENTS Strip comments from MATLAB m-files.
	% MLSTRIPCOMMENTS(INFILE, OUTFILE) reads the m-file INFILE,
	% strips the comments from it, and writes the result to the file
	% OUTFILE. Note that you should never specify the same value for
	% INFILE and OUTFILE.
	% Author: Peter J. Acklam
	
	% fid = fopen(fileList{ii});
	fid = fopen(fullfile(u_p,'tempFileNoComments.txt'));
	if fid == -1
		error(sprintf('Unable to open file %s',f{ii}));%#ok
	end
	filecontents = textscan(fid,'%s');
	fclose(fid);
	filecontents = char(filecontents{1});
	for jj = 1:size(filecontents,1)
		for kk = 1:numel(loadFunctions)
			found = ~isempty(strfind(filecontents(jj,:),['' loadFunctions{kk} '(''']));
			if found
				quotemarks = strfind(filecontents(jj,:),'''');
				if numel(quotemarks) ~= 2
					%Skip--maybe a passed string argument
					continue
				else
					fn = filecontents(jj,quotemarks(1)+1:quotemarks(2)-1);
					tmp = which(fn,'-all');
					if ~isempty(tmp)
						tmp = tmp{1};
					end
					if numel(tmp) >= numel(mlroot) && strcmp(tmp(1:numel(mlroot)),mlroot)
						%Skip--may be a MathWorks-provided file
						continue
					end
					if ~isempty(tmp) %This allows skipping of '*.*' signature
						loadedFiles = cat(1,loadedFiles,fn);
					end
				end
			end
		end
	end
end
try
	% Cleanup
	delete(fullfile(u_p,'tempFileNoComments.txt'))
end
% for ii = 1:numel(fileList)
% 	fprintf('%d: %s\n',ii,fileList{ii});
% end
if createZip
	[pn,fn]= fileparts(mainFiles);
	if isempty(pn)
		pn = which(mainFiles);
		pn = fileparts(pn);
	end
	fn2 = fullfile(pn,[fn,'.zip']);
	if exist(fn2,'file');
		n = 0; tmp = 1;
		while tmp
			n = n + 1;
			fn2 = fullfile(pn,[fn, num2str(n),'.zip']);
			tmp = exist(fn2,'file');
		end
	end
	zipFilename = inputdlg(sprintf('Enter ZIPFILE name, including path.\n(If path is omitted, file is written to parent directory of mainFiles.)'),...
		'ZipFileName',1,{fn2});
	if ~isempty(zipFilename)
		makeZip = 'Continue';
		if checkForCopyright && ~all(hasCopyright)
			beep
			makeZip = questdlg(sprintf('You asked for a check of copyrights,\nbut not all files appear to have been so tagged.\nDo you still want to make a zip file?'),...
				'Copyright Missing!','ABORT','Continue','ABORT');
		end
		if strcmp(makeZip,'Continue')
			zip(zipFilename{1},[fileList;loadedFiles])
			fprintf('Zip file %s created!\n',zipFilename{1})
		else
			disp('Zip creation aborted')
		end
	end
end
fprintf('\nDONE!\n')
end

% This doesn't need to be nested..
function loadFunctions = getLoadFunctions(productList,inputFunctionList)
productListNames = {productList.Name}';
loadFunctions = [];
for ii = 1:numel(productListNames)
	% Query all-Toolbox list by Toolbox:
	tbToQuery = productListNames{ii};
    tbFcns = inputFunctionList(strcmp({inputFunctionList.Toolbox},tbToQuery)).Functions;
    %stringsToSearch = cat(2,{'MATLAB'},{inputFunctionList.Toolbox});    
    %tbFcns = inputFunctionList(strcmp(stringsToSearch,tbToQuery)).Functions;
	loadFunctions = [loadFunctions;tbFcns];
end
end

function fileHasCopyright = checkForCopyrightFcn(filename)
fid = fopen(filename);
if fid == -1
	error(sprintf('checkForCopyrightFcn: Unable to open file %s',filename));
end
filecontents = textscan(fid,'%s');
fclose(fid);
filecontents = char(filecontents{1});
fileHasCopyright = false;
for ind = 1:size(filecontents,1)
	fileHasCopyright = ~isempty(strfind(filecontents(ind,:),'Copyright'));
	%startIndex = regexpi(filecontents(ind,:),'Copyright');
	if fileHasCopyright
		fprintf('Copyright notice detected in file %s.\n',filename);
		break
	end
end
end
