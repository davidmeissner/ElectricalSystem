load PQ_BDMotor_FULL;

StartInd=min(find(PQ_BDMotor.time>=1));
StopInd=min(find(PQ_BDMotor.time>=3.5));

Ref_Data_P1 = PQ_BDMotor.signals(1).values(StartInd:StopInd,2);
Ref_Data_Q1 = PQ_BDMotor.signals(2).values(StartInd:StopInd,2);
Ref_Data_time1 =  PQ_BDMotor.time(StartInd:StopInd)-PQ_BDMotor.time(StartInd);

StartInd=min(find(FC06_Test.time>=1));
StopInd=min(find(FC06_Test.time>=3.5));
Ref_Data_C = FC06_Test.signals.values(StartInd:StopInd,8);
Ref_Data_Ctime =  FC06_Test.time(StartInd:StopInd)-FC06_Test.time(StartInd);

% DOWNSAMPLE REFERENCE DATA
Ref_Data_P = decimate(Ref_Data_P1,100);
Ref_Data_Q = decimate(Ref_Data_Q1,100);
Ref_Data_time = decimate(Ref_Data_time1,100);

figure
subplot(311);
plot(Ref_Data_time1,Ref_Data_P1,'b-x');
hold on
plot(Ref_Data_time,Ref_Data_P,'r-o','MarkerSize',2);
hold off
title('Active Power','FontSize',14,'FontWeight','Bold');
set(gca,'YLim',[0 1200]);
legend({'Original','For Tuning'},'Location','NorthEast','FontWeight','Bold');

subplot(312);
plot(Ref_Data_time1,Ref_Data_Q1,'b-x');
hold on
plot(Ref_Data_time,Ref_Data_Q,'r-o','MarkerSize',2);
hold off
set(gca,'YLim',[0 1200]);
title('Reactive Power','FontSize',14,'FontWeight','Bold');
legend({'Original','For Tuning'},'Location','NorthEast','FontWeight','Bold');

subplot(313);
plot(Ref_Data_Ctime,Ref_Data_C,'b-x');
title('Control Signal','FontSize',14,'FontWeight','Bold');

save Ref_Data_BDMotor Ref_Data_P Ref_Data_Q Ref_Data_time Ref_Data_C Ref_Data_Ctime
