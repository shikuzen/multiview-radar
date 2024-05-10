function x = connect()
    addpath(genpath('.\'))
    RSTD_DLL_Path = 'C:\ti\mmwave_studio_02_01_01_00\mmWaveStudio\Clients\RtttNetClientController\RtttNetClientAPI.dll';
    ErrStatus = Init_RSTD_Connection(RSTD_DLL_Path);
    if (ErrStatus ~= 30000)
        disp('Error inside Init_RSTD_Connection');
    end
    x = "ready";
end
