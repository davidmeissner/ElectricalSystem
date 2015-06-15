%% Set up model and run the simulations
open_system('gtobuck_snubbers');

PowerGUI_h = find_system(get_param(gcs,'Handle'),'Name','powergui');

set_param(PowerGUI_h,'SPID','on','DisableSnubberDevices','off');
sim(gcs)
time_ideals = GTO_Data.time;
data_ideals = GTO_Data.signals(2).values;

set_param(PowerGUI_h,'SPID','on','DisableSnubberDevices','on');
sim(gcs)
time_idealns = GTO_Data.time;
data_idealns = GTO_Data.signals(2).values;

%% Compare results
figure(1);

t1 = 0.0431;
t2 = 0.0435;

set(gcf,'Position',[600 120 640 480]);
plot(time_ideals,data_ideals,...
    'Color', [210/255,120/255,9/255],...
    'LineWidth',2,'Marker','x','MarkerSize',8);
hold on
plot(time_idealns,data_idealns,...
    'Color', [18/255,86/255,135/255],...
    'LineWidth',2,'LineStyle','-.',...
    'Marker','o','MarkerSize',8);
axis([0.043 0.0436 201.12 201.26]);
title('GTO Thyristor',...
    'FontWeight','bold','FontSize',12);
xlabel('Time (s)','FontSize',10);
ylabel('Voltage (V)', 'FontSize',10);
grid on
hold off

steps_ideals = sum(time_ideals > t1 & time_ideals < t2);
steps_idealns = sum(time_idealns > t1 & time_idealns < t2);

legend_array{1} = ['Ideal - snubbers, ' num2str(steps_ideals) ' steps'];
legend_array{2} = ['Ideal - no snubbers, ' num2str(steps_idealns) ' steps'];
legend(legend_array,'Location','NorthEast');


