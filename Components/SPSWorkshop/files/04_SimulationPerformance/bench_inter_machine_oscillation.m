%% Set model name and number of runs
model = 'inter_machine_oscillation';
nruns = 2;

%% Set up model - ensure controllers are uncommented
open_system(model);

cblocks = { [model,'/B1'];
            [model,'/B2'];
            [model,'/S1'];
            [model,'/S2'];
            [model,'/wm_ref1'];
            [model,'/wm_ref2'];
            [model,'/PID1'];
            [model,'/PID2']};
cellfun(@(x) set_param(x,'Commented','off'), cblocks);

%% Continuous mode
set_param([model '/powergui'],'SimulationMode','Continuous');
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

%% Discrete mode
set_param([model '/powergui'],'SimulationMode','Discrete');
set_param([model '/powergui'],'SampleTime','1e-4');
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

%% Phasor mode
set_param([model '/powergui'],'SimulationMode','Phasor');
set_param([model '/powergui'],'Frequency','60');
% Discard the first run
sim(model);
% Calculate average sim times
AvgRunPhas = 0;
for i = 1:nruns
    tic;
    sim(model);
    AvgRunPhas = AvgRunPhas + toc;
end
AvgRunPhas = AvgRunPhas/nruns;

%% Normalize results
MaxAvgRun = max([AvgRunCont,AvgRunDisc,AvgRunPhas]);
NAvgCont = AvgRunCont/MaxAvgRun;
NAvgDisc = AvgRunDisc/MaxAvgRun;
NAvgPhas = AvgRunPhas/MaxAvgRun;

%% Display results
disp(['Average run time - continuous mode: ',num2str(AvgRunCont)]);
disp(['Average run time - discrete mode: ',num2str(AvgRunDisc)]);
disp(['Average run time - phasor mode: ',num2str(AvgRunPhas)]);
