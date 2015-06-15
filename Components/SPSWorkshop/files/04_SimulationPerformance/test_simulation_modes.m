%% Set model name
model = 'compare_simulation_modes';

%% Continuous mode
open_system(model);
set_param([model '/powergui'],'SimulationMode','Continuous');
sim(model);
VI_Data_CONT = VI_Data;

%% Discrete mode
set_param([model '/powergui'],'SimulationMode','Discrete');
set_param([model '/powergui'],'SampleTime','1e-4');
sim(model);
VI_Data_DISC = VI_Data;

%% Phasor mode
set_param([model '/powergui'],'SimulationMode','Phasor');
set_param([model '/powergui'],'Frequency','60');
sim(model);
VI_Data_PHAS = VI_Data;

%% Display simulation results
figure(1)
set(gcf,'Position',[50,50,480,580]);
subplot(211)
plot(VI_Data_CONT.time,VI_Data_CONT.signals(1).values,...
    'Color',[210/255,120/255,9/255],'LineWidth',2);
hold on
stairs(VI_Data_DISC.time,VI_Data_DISC.signals(1).values,...
    'Color',[50/255,87/255,132/255],'LineStyle',':','LineWidth',2);
plot(VI_Data_PHAS.time,VI_Data_PHAS.signals(1).values,...
    'Color',[105/255,120/255,25/255],'LineWidth',2);
hold off
axis([0 0.3 -200 200])
grid on
title('Line Voltage','FontSize',10,'FontWeight','Bold');

subplot(212)
plot(VI_Data_CONT.time,VI_Data_CONT.signals(2).values,...
    'Color',[210/255,120/255,9/255],'LineWidth',2);
hold on
stairs(VI_Data_DISC.time,VI_Data_DISC.signals(2).values,...
    'Color',[50/255,87/255,132/255],'LineStyle',':','LineWidth',2);
plot(VI_Data_PHAS.time,VI_Data_PHAS.signals(2).values,...
    'Color',[105/255,120/255,25/255],'LineWidth',2);
hold off
axis([0 0.3 -1 1])
grid on
title('Load Current','FontSize',10,'FontWeight','Bold');
legendstrings = {'Continuous','Discrete','Phasor'};
legend(legendstrings,'Location','SouthEast','FontSize',8,'FontWeight','Bold');

%% Compare solution modes
figure(2)
set(gcf,'Position',[550,50,480,580]);
semilogy(VI_Data_CONT.time(1:end-1),diff(VI_Data_CONT.time),...
    'Color',[210/255,120/255,9/255],'LineWidth',2,...
    'Marker','x','MarkerSize',8);
hold on
semilogy(VI_Data_DISC.time(1:end-1),diff(VI_Data_DISC.time),...
    'Color',[50/255,87/255,132/255],'LineWidth',2,...
    'Marker','x','MarkerSize',8);
semilogy(VI_Data_PHAS.time(1:end-1),diff(VI_Data_PHAS.time),...
    'Color',[105/255,120/255,25/255],'LineWidth',2,...
    'Marker','x','MarkerSize',8);
hold off
axis([0 0.3 1e-16 100])
grid on
title('Simulation Step Size','FontSize',10,'FontWeight','Bold');
legendstrings = {...
    ['Continuous, ' num2str(length(VI_Data_CONT.time)) ' Steps'],...
    ['Discrete, ' num2str(length(VI_Data_DISC.time)) ' Steps'],...
    ['Phasor, ' num2str(length(VI_Data_PHAS.time)) ' Steps']};
legend(legendstrings,'Location','NorthEast','FontSize',8,'FontWeight','Bold');


