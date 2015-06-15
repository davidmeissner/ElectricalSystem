%% Set model name and number of runs
model = 'threephase_power_inverter';
nruns = 2;

%% Set up model
open_system(model);

%% Continuous mode
set_param(model,'SimulationMode','normal');
set_param([model '/powergui'],'SimulationMode','Continuous');
set_param([model '/powergui'],'SPID','off'); % SPID is for the ideal switches toggle button
set_param([model '/Bridge'],'Device','IGBT / Diodes');
set_param([model '/60 Hz modulation'],'SampleTime','0');
set_param([model '/10 kHz PWM generator'],'Ts','0');
% Discard the first run
sim(model);
% Calculate average sim times
AvgRunCont = 0;
for i = 1:nruns
    tic;
    sim(model);
    AvgRunCont = AvgRunCont + toc;
end
AvgRunCont = AvgRunCont/nruns;

%% Continuous mode - ideal switch
set_param(model,'SimulationMode','normal');
set_param([model '/powergui'],'SimulationMode','Continuous');
set_param([model '/powergui'],'SPID','on',...
    'DisableSnubberDevices','on','DisableRonSwitches','on');
set_param([model '/Bridge'],'Device','Ideal Switches');
% Discard the first run
sim(model);
% Calculate average sim times
AvgRunContIS = 0;
for i = 1:nruns
    tic;
    sim(model);
    AvgRunContIS = AvgRunContIS + toc;
end
AvgRunContIS = AvgRunContIS/nruns;

%% Discrete mode
set_param(model,'SimulationMode','normal');
set_param([model '/powergui'],'SimulationMode','Discrete');
set_param([model '/powergui'],'SampleTime','1e-6');
set_param([model '/Bridge'],'Device','IGBT / Diodes');
set_param([model '/60 Hz modulation'],'SampleTime','1e-4');
set_param([model '/10 kHz PWM generator'],'Ts','1e-6');
% Discard the first run
sim(model);
% Calculate average sim times
AvgRunDisc = 0;
for i = 1:nruns
    tic;
    sim(model);
    AvgRunDisc = AvgRunDisc + toc;
end
AvgRunDisc = AvgRunDisc/nruns;

%% Discrete mode - accelerator
set_param(model,'SimulationMode','accelerator');
% Discard the first run
sim(model);
% Calculate average sim times
AvgRunDiscAcc = 0;
for i = 1:nruns
    tic;
    sim(model);
    AvgRunDiscAcc = AvgRunDiscAcc + toc;
end
AvgRunDiscAcc = AvgRunDiscAcc/nruns;

%% Normalize results
MaxAvgRun = max([AvgRunCont,AvgRunContIS,AvgRunDisc,AvgRunDiscAcc]);
NAvgCont = AvgRunCont/MaxAvgRun;
NAvgContIS = AvgRunContIS/MaxAvgRun;
NAvgDisc = AvgRunDisc/MaxAvgRun;
NAvgDiscAcc = AvgRunDiscAcc/MaxAvgRun;

%% Display results
disp(['Average run time - continuous mode: ',num2str(AvgRunCont)]);
disp(['Average run time - continuous mode (ideal switch): ',num2str(AvgRunContIS)]);
disp(['Average run time - discrete mode: ',num2str(AvgRunDisc)]);
disp(['Average run time - discrete mode (accelerator): ',num2str(AvgRunDiscAcc)]);
