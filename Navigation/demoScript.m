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
%% Model Overview
%
% * <matlab:open_system('Aircraft_Power_Network'); Open model>
% * <matlab:sim('Aircraft_Power_Network'); Run model>
% * Generator, AC Bus, TRU, DC Bus
% * Testing various flight cycles/ varying loading conditions
% * <matlab:web('APN_Model_Report_SHORT1.html','-new'); Open report>
% * Fully configurable reports, plots, FFT Analysis, THD
%
%% Model Based Design
% 
% * <matlab:uiopen('SPS_CraneAerospace.pptx',1); Open Powerpoint>
%
%% Requirements Traceability
%
% * <matlab:open_system('Aircraft_Power_Network'); Open model>
% * Right click on TRU / Requirements Traceability / 1. "TRU Requirements"
% * <matlab:uiopen('APN_System_Requirements'); Open requirements in Word>
% * Highlight blocks in the model with requirements (Analysis / Requirements
% tracability / Highlight Model
%
% 
%% Transformer Rectifier Unit
%
% * Open Subsystem, talk about TRU, DC Loads
% * Transformer - Winding connection, Parameters
% * Universal Bridge - Power Electronic Device Options
% * Show help
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
%
%% Voltage Regulator Example / Controls
%
% * <matlab:acdcac_specialized; acdcac_specialized> SPS Specialized
% Technology
% * abs to dq0 transformation
% * PI controllers
% * <matlab:acdcac_simscape; acdcac_simscape> SPS Simscape Components
%
%% SimElectronics vs SimPowerSystems
%
% * <matlab:uiopen('SPS_CraneAerospace.pptx',1); Open Powerpoint>
% * <matlab:simulink; Open Simulink Library Browser>
% 
%% Other Potential Discussion
%
% * VnV, Certification, Code Generation
% * model coverage, Decision, Condition, MC/DC
% * generate test cases to ensure full coverage
% * determine expected outputs for each new test case
% * compare simulation with expected outputs
%
% Copyright 2014 The MathWorks, Inc.