%% Set model name and number of runs
model = 'threephase_matrix_converter';
nruns = 2;

%% Set up model
open_system(model);

%% Continuous mode - normal
set_param(model,'SimulationMode','normal');
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

%% Continuous mode - accelerator
set_param(model,'SimulationMode','accelerator');
% Discard the first run
sim(model);
% Calculate average sim times
AvgRunContAcc = 0;
for i = 1:nruns
    tic;
    sim(model);
    AvgRunContAcc = AvgRunContAcc + toc;
end
AvgRunContAcc = AvgRunContAcc/nruns;

%% Discrete mode
set_param(model,'SimulationMode','normal');
set_param([model '/powergui'],'SimulationMode','Discrete');
set_param([model '/powergui'],'SampleTime','2.5e-6');
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
MaxAvgRun = max([AvgRunCont,AvgRunDisc,AvgRunContAcc,AvgRunDiscAcc]);
NAvgCont = AvgRunCont/MaxAvgRun;
NAvgDisc = AvgRunDisc/MaxAvgRun;
NAvgContAcc = AvgRunContAcc/MaxAvgRun;
NAvgDiscAcc = AvgRunDiscAcc/MaxAvgRun;

%% Display results
disp(['Average run time - continuous mode: ',num2str(AvgRunCont)]);
disp(['Average run time - discrete mode: ',num2str(AvgRunDisc)]);
disp(['Average run time - continuous mode (accelerator): ',num2str(AvgRunContAcc)]);
disp(['Average run time - discrete mode (accelerator): ',num2str(AvgRunDiscAcc)]);
