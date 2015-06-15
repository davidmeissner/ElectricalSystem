function mlstripcomments(infile, outfile)
%MLSTRIPCOMMENTS Strip comments from MATLAB m-files.
%
%   MLSTRIPCOMMENTS(INFILE, OUTFILE) reads the m-file INFILE, strips the
%   comments from it, and writes the result to the file OUTFILE.  Note that you
%   should never specify the same value for INFILE and OUTFILE.

%   Author:      Peter J. Acklam
%   Time-stamp:  2004-03-12 07:32:38 +0100
%   E-mail:      pjacklam@online.no
%   URL:         http://home.online.no/~pjacklam

   nargsin = nargin;
   error(nargchk(1, 2, nargsin));

   % See if the input file exists.
   if ~exist(infile, 'file')
      error([infile ': no such file or directory.']);
   end

   % Open the input file for reading.
   ifid = fopen(infile, 'rt');
   if ifid < 0
      error([infile ': can''t open file for reading.']);
   end

   % Open the output file for writing.
   ofid = fopen(outfile, 'wt');
   if ofid < 0
      closefid(ifid, infile);
      error([outfile ': can''t open file for writing.']);
   end

   mlstripcommentsfilter(ifid, ofid)

   closefid(ifid, infile);
   closefid(ofid, outfile);

function mlstripcommentsfilter(ifid, ofid)
%MLSTRIPCOMMENTSFILTER Strip comments in MATLAB code.
%
%   MLSTRIPCOMMENTSFILTER(IFID, OFID) reads MATLAB code from the file
%   identifier IFID, strips all MATLAB comments, and writes the result on the
%   output file identifier OFID.

   %
   % Regex for removing a comment on a line possibly containing MATLAB code.
   %
   % Find find the part of the line which is not a comment and then replace the
   % whole line with the part that was not a comment.
   %
   % A comment is started by a percent sign, but not all percent signs start a
   % comment.  A percent sign might be embedded in a string, in which case the
   % percent sign obviously does not start a comment.  So we must look for
   % percent signs which are not embedded in strings.  To do this we must find
   % all strings.  Strings are delimited by single quotes, but not all single
   % quotes start strings.  A single quote might also be a tranpose operator.
   % So we must look for single quotes which are not tranpose operators.
   %
   % The MATLAB grammar (syntax and semantics) is not available to the public,
   % but from my knowledge, a single quote is a transpose operator if and only
   % if one of the following criteria is satisfied
   %
   %   1) it follows a right closing delimiter
   %   2) it follows right after a variable name or function name
   %   3) it follows right after a period (as part of the ".'" operator)
   %   4) it follows right after another tranpose operator
   %
   % This can be immediately after a right closing bracket ("]"), right closing
   % parenthesis (")"), right closing brace ("}"), an English letter ("a" to
   % "z" and "A" to "Z", a digit ("0" to "9"), an underline ("_"), a period
   % ("."), or another single quote ("'").
   %

    mainregex = [ ...
      ' ^                   ' ...
      ' (                   ' ... % Grouping parenthesis (contents goes to $1).
      '   (                 ' ... % Non-capturing grouping parenthesis.
      '' ...
      '' ...  % Match anything that is neither a comment nor a string...
      '       (             ' ... % Non-capturing grouping parenthesis.
      '           [\]\)}\w.]' ... % Either a character followed by
      '           ''+       ' ... %    one or more transpose operators
      '         |           ' ... % or else
      '           [^''%]    ' ... %   any character except single quote (which
      '                     ' ... %   starts a string) or a percent sign (which
      '                     ' ... %   starts a comment).
      '       )+            ' ... % Match one or more times.
      '                     ' ...
      '' ...  % ...or...
      '     |               ' ...
      '                     ' ...
      '' ...  % ...match a string.
      '       ''            ' ... % Opening single quote that starts the string.
      '         [^''\n]*    ' ... % Zero or more chars that are neither single
      '                     ' ... %   quotes (special) nor newlines (illegal).
      '         (           ' ... % Non-capturing grouping parenthesis.
      '           ''''      ' ... % An embedded (literal) single quote character.
      '           [^''\n]*  ' ... % Again, zero or more chars that are neither
      '                     ' ... %   single quotes nor newlines.
      '         )*          ' ... % Match zero or more times.
      '       ''            ' ... % Closing single quote that ends the string.
      '                     ' ...
      '   )*                ' ... % Match zero or more times.
      ' )                   ' ...
      ' .*                  ' ... % What remains must be a comment.
               ];

   % Remove all the blanks from the regex.
   mainregex = mainregex(~isspace(mainregex));

   while 1

      % Read input line.
      line = fgetl(ifid);
      if ~ischar(line), break, end

      % Remove a comment line.
      line = regexprep(line, '^\s*%.*', '');

      % Remove a comment on a line possibly containing MATLAB code.
      line = regexprep(line, mainregex, '$1');%, 'tokenize'

      % Remove trailing whitespace from each line.
      line = regexprep(line, '\s+$', '');

      % Write output line.
      fprintf(ofid, '%s\n', line);

   end

function closefid(fid, filename)
%CLOSEFID Close a file identifier.
%
%   CLOSEFID(IFID, FILENAME) closes the specified file identifier.

   status = fclose(fid);
   if status < 0
      error([filename ': can''t close file.']);
   end
