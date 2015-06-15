function projectStartup()
%% projectStartup()
% Executes startup tasks ass
thisProject = slproject.getCurrentProject;
rootFolder  = thisProject.RootFolder;
workFolder = fullfile(rootFolder, 'Work');
if ~exist(workFolder, 'dir')
    mkdir(workFolder);
end

%% Generic Tasks
%  Open Demo Script to Navigate the Example
% open('APN_Demo_Script.html') % Steve Miller's
open('demoScript.html')

%% Custom Tasks for this demo
% Specify that the work folder be the cache folder for files related to
% model updates and code generation
myCacheFolder = workFolder;
Simulink.fileGenControl('set', 'CacheFolder', myCacheFolder, ...
'CodeGenFolder', myCacheFolder);

% % Turn off some warnings
% warning('off','Simulink:Logging:LoggingOutportWithSlowTs')  % Turn off the warning for slower logging of output port

% Build Custom Libraries
if(exist('/Components/Libraries/Battery')==7)
    cd('/Components/Libraries/Battery');
    if((exist('+LeadAcidBattery')==7) && ~exist('./LeadAcidBattery_lib'))
        ssc_build LeadAcidBattery
    end
    cd(rootFolder)
end

% Load Custom Simulink Libraries
cd([rootFolder '/Components/Libraries']);
liblist = dir('*_Lib.slx');
libnames = {liblist.name}';
for i=1:length(libnames)
    load_system(char(libnames(i)));
end
clear liblist libnames
cd(rootFolder);

% SETUP REQUIREMENTS MANAGEMENT
if(exist('rmi')==2)
    rmi setup
end

% LOAD PARAMETERS
% APN_Model_PARAM loads via shortcut

% OPEN MODEL
Aircraft_Power_Network

end


