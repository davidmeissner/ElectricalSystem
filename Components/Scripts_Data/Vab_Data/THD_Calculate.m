%% INVESTIGATING THD DURING FLIGHT CYCLES
% LIST OF TEST POINTS [Cycles; Times]
THD_TestPoints = ...
    [1 2    2    2    2    2    2    2    3    4    5    6    6    6   7    7    8    8    8    8;...
    1 0.75 1.25 1.75 2.25 2.75 3.25 3.75 1.75 2.25 1.25 1.25 1.75 3.5 2.75 3.25 1.75 2.7  3.25 3.8];

%% LOAD PHASE-TO-PHASE VOLTAGE DATA
for i=1:length(FCFiles)
    CycleVabDataName = ['Gen1_Vab_' num2str(i)];
    load(CycleVabDataName);
end
    
%% LOOP OVER TEST POINTS TO CALCULATE THD
for i=1:size(THD_TestPoints,2)
    eval(['CycleVabData = Gen1_Vab_' num2str(THD_TestPoints(1,i)) ';']);
    FFTDATA = power_fftscope(CycleVabData);
    FFTDATA.cycles = 1;
    FFTDATA.fundamental = 400;
    FFTDATA.startTime = THD_TestPoints(2,i);
    FFTDATA.maxFrequency = 12000;
    FFTDATA=power_fftscope(FFTDATA);
    THDRes(i) = FFTDATA.THD;
    disp(['Test Point ' num2str(i) ': THD = ' num2str(FFTDATA.THD)]);
    clear FFTDATA
end

%% PLOT RESULTS
figure(1)
clf
bar(THDRes);
title('THD at Test Points','FontSize',14,'FontWeight','Bold');
xlabel('Test Point','FontWeight','Bold');
ylabel('THD (%)','FontWeight','Bold');
set(gca,'XLim',[0 21]);

