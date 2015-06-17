function result = checkCode_Fcn(file)
%checkCodeProblems   Simulink Project batch job for MATLAB code checking
%
% Input arguments:
%  file - string - The absolute path to a file included in the batch job.
%  When you run the batch job, the Simulink Project Tool provides the file 
%  input for each selected file. 
%
% Output arguments:
%  result - string - The number of problems detected. The Simulink Project 
%  Tool displays this result in the Batch Job Results column.
%
% Copyright 2012 The MathWorks, Inc.


[~, ~, ext] = fileparts(file);
if strcmp(ext, '.m')
    problems = length(checkcode(file));
    switch problems
        case 0
            result = 'No problems detected';
        case 1
            result = '1 problem detected';
        otherwise
            result = [int2str(problems) ' problems detected'];
    end
else
    result = [];
end

end
