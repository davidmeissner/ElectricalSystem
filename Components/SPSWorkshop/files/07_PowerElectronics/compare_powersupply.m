%% Load models and run simulations
open_system('se_powersupply');
sim('se_powersupply');

open_system('sps_powersupply');
sim('sps_powersupply');

%% Compare system level results
figure(1)
plot(Vload_se.time,Vload_se.signals(1).values,...
    'Color',[105/255,120/255,25/255],'LineWidth', 4);
hold on
plot(Vload_sps.time,Vload_sps.signals(1).values,...
    'Color',[210/255,120/255,9/255],'LineWidth', 4,...
    'LineStyle','-.');
title('Switched Power Supply','FontWeight','Bold','FontSize',14)
xlabel('time (sec)','FontSize', 12);
ylabel('Vout (V)','FontSize', 12);
grid on;
legend({'SimElectronics','SimPowerSystems'},...
    'Location','SouthEast','FontWeight','Bold',...
    'FontSize',8);
hold off

%% Compare switching device level responses
figure(2)
subplot(311)
set(gcf,'Position',[10 40 500 640]);
plot(simoutSE.getElement(4).Values.Time,simoutSE.getElement(4).Values.Data,...
    'Color',[105/255,120/255,25/255],'LineWidth',1,...
    'Marker','x','MarkerSize',6);
hold on
plot(simoutSE.getElement(5).Values.Time,simoutSE.getElement(5).Values.Data,...
    'Color',[18/255,86/255,135/255],'LineWidth',1,...
    'Marker','o','MarkerSize',6);
axis([2.0307e-3 2.0311e-3 -10 40]);
title('SE MOSFET Drain-Source Voltage','FontWeight','Bold','FontSize',12);
xlabel('time (sec)','FontSize', 12);
ylabel('Vds (V)','FontSize', 12);
grid on;
legend({'M1', 'M2'},'Location','Best','FontWeight','Bold',...
    'FontSize',8);
hold off

figure(3)
subplot(311)
set(gcf,'Position',[525 40 500 640]);
plot(simoutSPS.getElement(4).Values.Time,simoutSPS.getElement(4).Values.Data,...
    'Color',[210/255,120/255,9/255],'LineWidth',1,...
    'Marker','x','MarkerSize',6);
hold on
plot(simoutSPS.getElement(5).Values.Time,simoutSPS.getElement(5).Values.Data,...
    'Color',[18/255,86/255,135/255],'LineWidth',1,...
    'Marker','o','MarkerSize',6);
axis([2.038e-3 2.042e-3 -10 40]);
title('SPS MOSFET Drain-Source Voltage','FontWeight','Bold','FontSize',12);
xlabel('time (sec)','FontSize', 12);
ylabel('Vds (V)','FontSize', 12);
grid on;
legend({'M1', 'M2'},'Location','Best','FontWeight','Bold',...
    'FontSize',8);
hold off
%%
figure(2)
subplot(312)
plot(simoutSE.getElement(1).Values.Time,simoutSE.getElement(1).Values.Data,...
    'Color',[105/255,120/255,25/255],'LineWidth',1,...
    'Marker','x','MarkerSize',6);
hold on
plot(simoutSE.getElement(2).Values.Time,simoutSE.getElement(2).Values.Data,...
    'Color',[18/255,86/255,135/255],'LineWidth',1,...
    'Marker','o','MarkerSize',6);
axis([2.0307e-3 2.0311e-3 -10 40]);
title('SE MOSFET Drain-Source Current','FontWeight','Bold','FontSize',12);
xlabel('time (sec)','FontSize', 12);
ylabel('IM (A)','FontSize', 12);
grid on;
legend({'M1', 'M2'},'Location','Best','FontWeight','Bold',...
    'FontSize',8);
hold off

figure(3)
subplot(312)
plot(simoutSPS.getElement(1).Values.Time,simoutSPS.getElement(1).Values.Data,...
    'Color',[210/255,120/255,9/255],'LineWidth',1,...
    'Marker','x','MarkerSize',6);
hold on
plot(simoutSPS.getElement(2).Values.Time,simoutSPS.getElement(2).Values.Data,...
    'Color',[18/255,86/255,135/255],'LineWidth',1,...
    'Marker','o','MarkerSize',6);
axis([2.038e-3 2.042e-3 -10 40])
title('SPS MOSFET Drain-Source Current','FontWeight','Bold','FontSize',12);
xlabel('time (sec)','FontSize', 12);
ylabel('IM (A)','FontSize', 12);
grid on;
legend({'M1', 'M2'},'Location','Best','FontWeight','Bold',...
    'FontSize',8);
hold off

%%
figure(2)
subplot(313)
plot(simoutSE.getElement(1).Values.Time,...
    simoutSE.getElement(1).Values.Data.*simoutSE.getElement(4).Values.Data,...
    'Color',[105/255,120/255,25/255],'LineWidth',1,...
    'Marker','x','MarkerSize',6);
hold on
plot(simoutSE.getElement(2).Values.Time,...
    simoutSE.getElement(2).Values.Data.*simoutSE.getElement(5).Values.Data,...
    'Color',[18/255,86/255,135/255],'LineWidth',1,...
    'Marker','o','MarkerSize',6);
axis([2.0307e-3 2.0311e-3 -10 1000]);
title('SE MOSFET Power','FontWeight','Bold','FontSize',12);
xlabel('time (sec)','FontSize', 12);
ylabel('PM (W)','FontSize', 12);
grid on;
legend({'M1', 'M2'},'Location','Best','FontWeight','Bold',...
    'FontSize',8);
hold off

figure(3)
subplot(313)
plot(simoutSPS.getElement(1).Values.Time,...
    simoutSPS.getElement(1).Values.Data.*simoutSPS.getElement(4).Values.Data,...
    'Color',[210/255,120/255,9/255],'LineWidth',1,...
    'Marker','x','MarkerSize',6);
hold on
plot(simoutSPS.getElement(2).Values.Time,...
    simoutSPS.getElement(2).Values.Data.*simoutSPS.getElement(5).Values.Data,...
    'Color',[18/255,86/255,135/255],'LineWidth',1,...
    'Marker','o','MarkerSize',6);
axis([2.038e-3 2.042e-3 -10 1000]);
title('SPS MOSFET Power','FontWeight','Bold','FontSize',12);
xlabel('time (sec)','FontSize', 12);
ylabel('PM (W)','FontSize', 12);
grid on;
legend({'M1', 'M2'},'Location','Best','FontWeight','Bold',...
    'FontSize',8);
hold off

