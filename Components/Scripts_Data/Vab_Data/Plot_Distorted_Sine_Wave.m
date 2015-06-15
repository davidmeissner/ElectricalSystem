load Gen1_Vab_5;
CycleVabData = Gen1_Vab_5;
plot(CycleVabData.time,CycleVabData.signals.values,'LineWidth',4);
%set(gca,'XLim',[1.25 1.25+1/400]);

hold on

t=[1:0.00001:1.3];
x=sin(t*2*pi*400+pi/4*0.62)*282;
plot(t,x,'r--','LineWidth',2);
set(gca,'XLim',[1.25 1.25+1/400]-0.0002,'YLim',[-320 320]);
hold off



