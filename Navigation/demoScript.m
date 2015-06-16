%% Electrical System
% 
%% Key Messages
%
% * Model networks containing generators, AC loads, DC loads, and TRU
% * Refine requirements using abstract component models
% * Analyze power quality at various points in different flight cycles
% * Integrate requirements into your development process
% * Accelerate development by running simulations in parallel
%
%% Overview
%
% * <matlab:winopen('electricalSystem.pptx'); Open PowerPoint> 
% 
%% Aircraft Power Network
%
% * <matlab:open_system('Aircraft_Power_Network'); Open model>
% * <matlab:sim('Aircraft_Power_Network'); Run model>
% * Generator, AC Bus, TRU, DC Bus
% * Testing various flight cycles/ varying loading conditions
% * <matlab:web('APN_Model_Report_SHORT1.html','-new'); Open report>
% * Fully configurable reports, plots, FFT Analysis, THD
%
%% Physical Modeling
% 
% * <matlab:winopen('electricalSystem.pptx'); Open PowerPoint> 
%
%% Modeling Electronics and Power Systems
%
% * <matlab:winopen('electricalSystem.pptx'); Open PowerPoint> 
% * <matlab:simulink; Open Simulink Library Browser>
% * <matlab:open_system('PS_Simulation_Modes'); Open PS_Simulation_Modes>
% * <matlab:run('PS_Simulation_Modes_Test.m'); Run PS_Simulation_Modes_Test.m>
% 
%% Transformer Rectifier Unit
%
% * Open Subsystem, talk about TRU, DC Loads
% * Transformer - Winding connection, Parameters
% * Universal Bridge - Power Electronic Device Options
% * Show help
% * Change Block Choice to Multi-Domain and review DC loads
%
%% Logic and Controls
%
% * <matlab:synchronizing_breaker; Syncronizing Breaker>
% * Top level overview
% * Open the controller, Mechanical Power Control, Field Voltage, PID
% * PID Tuner overview
% * Stateflow chart
% * Run
% * After it disconnects, go into phasesync
% * In measurements, review the scope Vab (and review the phase sync)
%
%% Voltage Regulator Example / Controls
%
% * <matlab:acdcac_specialized; acdcac_specialized> SPS Specialized
% Technology
% * abs to dq0 transformation
% * PI controllers
% * <matlab:acdcac_simscape; acdcac_simscape> SPS Simscape Components
%
%% Requirements Traceability
%
% * <matlab:open_system('Aircraft_Power_Network'); Open model>
% * Right click on TRU / Requirements Traceability / 1. "TRU Requirements"
% * <matlab:winopen('APN_System_Requirements.docx'); Open requirements in Word>
% * Highlight blocks in the model with requirements (Analysis / Requirements
% tracability / Highlight Model
% * Add a requirement for the generator (Highlight "Generator
% Requirements", the right click on the generator block and select,
% Requirements Traceability, Link to Selection in Word.)
% 
%% Other Potential Discussion
%
% * VnV, Certification, Code Generation
% * model coverage, Decision, Condition, MC/DC
% * generate test cases to ensure full coverage
% * determine expected outputs for each new test case
% * compare simulation with expected outputs
%
% Copyright 2014-2015 The MathWorks, Inc.