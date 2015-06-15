%% Set up model and run the simulations
open_system('gtobuck_idealswitching');

PowerGUI_h = find_system(get_param(gcs,'Handle'),'Name','powergui');

set_param(PowerGUI_h,'SPID','off','DisableSnubberDevices','off','DisableRonSwitches','off');
sim(gcs)
time_cont = GTO_Data.time;
data_cont = GTO_Data.signals(3).values;
%%
set_param(PowerGUI_h,'SPID','on','DisableSnubberDevices','on','DisableRonSwitches','off');
sim(gcs)
time_ideal = GTO_Data.time;
data_ideal = GTO_Data.signals(3).values;

%% Compare results
figure(1);

t1 = 0.0420;
t2 = 0.0426;

set(gcf,'Position',[600 120 640 480]);
plot(time_cont,data_cont,...
    'Color', [210/255,120/255,9/255],...
    'LineWidth',2,'Marker','x','MarkerSize',8);
hold on
plot(time_ideal,data_ideal,...
    'Color', [18/255,86/255,135/255],...
    'LineWidth',2,'LineStyle','-.',...
    'Marker','o','MarkerSize',8);
axis([t1 t2 -5 220]);
title('GTO Thyristor',...
    'FontWeight','bold','FontSize',12);
xlabel('Time (s)','FontSize',10);
ylabel('Voltage (V)', 'FontSize',10);
grid on
hold off

steps_ideal = sum(time_ideal > t1 & time_ideal < t2);
steps_cont = sum(time_cont > t1 & time_cont < t2);

legend_array{1} = ['Continuous, ' num2str(steps_cont) ' steps'];
legend_array{2} = ['Ideal - no snubbers, ' num2str(steps_ideal) ' steps'];
legend(legend_array,'Location',[0.32 0.3 0.4 0.1]');


