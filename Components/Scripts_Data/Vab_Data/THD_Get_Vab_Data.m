% RUN FLIGHT CYCLES TO COLLECT Vab DATA FOR THD CALCULATION
for i = 1:length(FCFiles)
    Flight_Cycle_Num = i;
    sim('Aircraft_Power_Network');
    disp(['Gen1_Vab_' num2str(i) '= Gen1_Vab;']);
    eval(['Gen1_Vab_' num2str(i) '= Gen1_Vab;']);
    disp(['save Gen1_Vab_' num2str(i) ' Gen1_Vab_' num2str(i)]);
    eval(['save Gen1_Vab_' num2str(i) ' Gen1_Vab_' num2str(i)]);
end

