load PQ_BDMotor_FULL

figure(1)
clf
set(gcf,'Position',[17   361   495   277]);
subplot(211)
plot(PQ_BDMotor.time,PQ_BDMotor.signals(1).values(:,1),'r:');
hold on
plot(PQ_BDMotor.time,PQ_BDMotor.signals(1).values(:,2),'b','LineWidth',2);
hold off
set(gca,'XLim',[1.2 3.2]);
set(gca,'XTickLabel','');
set(gca,'Position',[0.1300    0.4513    0.7750    0.4332]);
title('Active Power (W)','FontSize',14,'FontWeight','Bold');
legend({'Detailed','Abstract'},'Location','Best','FontSize',12,'FontWeight','Bold');
subplot(212)
plot(FC06_Test.time,FC06_Test.signals.values(:,8),'LineWidth',2);
set(gca,'XLim',[1.2 3.2]);
set(gca,'YLim',[-500 500]*1.1);
set(gca,'Position',[ 0.1300    0.1100    0.7750    0.1752]);
title('On/Off Signal','FontSize',14,'FontWeight','Bold');

figure(2)
clf
set(gcf,'Position',[452   155   495   390]);
subplot(311)
plot(PQ_BDMotor.time,PQ_BDMotor.signals(1).values(:,1),'r:');
hold on
plot(PQ_BDMotor.time,PQ_BDMotor.signals(1).values(:,2),'b','LineWidth',2);
plot(FC06_Test.time,abs(FC06_Test.signals.values(:,8))/500*600,'g-.','LineWidth',2);
hold off
set(gca,'XLim',[1.2 3.2]);
set(gca,'XTickLabel','');
set(gca,'Position',[0.1300    0.6528    0.7750    0.2374]);
title('Active Power (W)','FontSize',14,'FontWeight','Bold');
legend({'Detailed','Tuned','Initial'},'Location','North','FontSize',10,'FontWeight','Bold');
subplot(313)
plot(FC06_Test.time,FC06_Test.signals.values(:,8),'k','LineWidth',2);
set(gca,'XLim',[1.2 3.2]);
set(gca,'YLim',[-500 500]*1.1);
set(gca,'Position',[0.1300    0.0742    0.7750    0.1187]);
title('On/Off Signal','FontSize',14,'FontWeight','Bold');
subplot(312)
plot(PQ_BDMotor.time,PQ_BDMotor.signals(2).values(:,1),'r:');
hold on
plot(PQ_BDMotor.time,PQ_BDMotor.signals(2).values(:,2),'b','LineWidth',2);
plot(FC06_Test.time,abs(FC06_Test.signals.values(:,8))/500*150,'g-.','LineWidth',2);
hold off
set(gca,'XLim',[1.2 3.2]);
set(gca,'YLim',[-100 700]);
set(gca,'XTickLabel','');
set(gca,'Position',[0.1300    0.3116    0.7750    0.2344]);
title('Reactive Power (W)','FontSize',14,'FontWeight','Bold');


