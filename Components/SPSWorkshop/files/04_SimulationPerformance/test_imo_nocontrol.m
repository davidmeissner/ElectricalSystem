%% Set model name
model = 'inter_machine_oscillation';

%% NO CONTROL (comment out the controllers)
open_system(model);

cblocks = { [model,'/B1'];
            [model,'/B2'];
            [model,'/S1'];
            [model,'/S2'];
            [model,'/wm_ref1'];
            [model,'/wm_ref2'];
            [model,'/PID1'];
            [model,'/PID2']};
        
cellfun(@(x) set_param(x,'Commented','on'), cblocks);

%% Continuous mode
set_param([model '/powergui'],'SimulationMode','Continuous');
sim(model);
m_cont = measurements;

%% Phasor mode
set_param([model '/powergui'],'SimulationMode','Phasor');
set_param([model '/powergui'],'Frequency','60');
sim(model);
m_phas = measurements;

%% Display results for NO CONTROL test
figure(1)
plot(m_cont.time,m_cont.signals(1).values(:,1),...
    'Color',[210/255,120/255,9/255],'LineWidth',2);
hold on
plot(m_phas.time,m_phas.signals(1).values(:,1),...
    'Color',[105/255,120/255,25/255],'LineStyle','-.','LineWidth',2);
hold off
title('No Control','FontSize',12,'FontWeight','Bold');
xlabel('time (sec)');
ylabel('wm (pu)');
grid on
legend({'Continuous','Phasor'},'Location','NorthEast',...
    'FontSize',10,'FontWeight','Bold');

%% CONTROL (uncomment the controllers)        
cellfun(@(x) set_param(x,'Commented','off'), cblocks);

%% Continuous mode
set_param([model '/powergui'],'SimulationMode','Continuous');
sim(model);
m_cont = measurements;

%% Phasor mode
set_param([model '/powergui'],'SimulationMode','Phasor');
set_param([model '/powergui'],'Frequency','60');
sim(model);
m_phas = measurements;

%% Display results for CONTROL test
figure(2)
plot(m_cont.time,m_cont.signals(1).values(:,1),...
    'Color',[210/255,120/255,9/255],'LineWidth',2);
hold on
plot(m_phas.time,m_phas.signals(1).values(:,1),...
    'Color',[105/255,120/255,25/255],'LineStyle','-.','LineWidth',2);
hold off
title('Control','FontSize',12,'FontWeight','Bold');
xlabel('time (sec)');
ylabel('wm (pu)');
grid on
legend({'Continuous','Phasor'},'Location','SouthEast',...
    'FontSize',10,'FontWeight','Bold');