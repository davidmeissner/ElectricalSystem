%load PQ_BDMotor_DATA

colordef black
figure(3)
clf
set(gcf,'Position',[379   616   495   390]);
subplot(311)
plot(PQ_BDMotor_DATA.time,PQ_BDMotor_DATA.signals(1).values(:,1),'m','LineWidth',2);
hold on
plot(PQ_BDMotor_DATA.time,PQ_BDMotor_DATA.signals(1).values(:,2),'c-.','LineWidth',2);
hold off
set(gca,'XLim',[0 2.5]);
set(gca,'YLim',[0 1500]);
set(gca,'XTickLabel','');
set(gca,'Position',[0.1300    0.6528    0.7750    0.2374]);
title('Active Power (W)','FontSize',14,'FontWeight','Bold');
legend({'Detailed','Abstract'},'Location','North','FontSize',10,'FontWeight','Bold');
grid on

subplot(313)
plot(PQ_BDMotor_DATA.time,PQ_BDMotor_DATA.signals(3).values,'w','LineWidth',2);
set(gca,'XLim',[0 2.5]);
set(gca,'YLim',[-500 500]*1.1);
set(gca,'Position',[0.1300    0.0742    0.7750    0.1187]);
title('On/Off Signal','FontSize',14,'FontWeight','Bold');
box on

subplot(312)
plot(PQ_BDMotor_DATA.time,PQ_BDMotor_DATA.signals(2).values(:,1),'m','LineWidth',2);
hold on
plot(PQ_BDMotor_DATA.time,PQ_BDMotor_DATA.signals(2).values(:,2),'c-.','LineWidth',2);
hold off
set(gca,'XLim',[0 2.5]);
set(gca,'YLim',[-50 400]);
set(gca,'XTickLabel','');
set(gca,'Position',[0.1300    0.3116    0.7750    0.2344]);
title('Reactive Power (W)','FontSize',14,'FontWeight','Bold');
grid on

colordef white