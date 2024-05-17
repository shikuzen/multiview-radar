function status = rstd_start(u, cip, fixport)
    addpath(genpath('.\'));
    RSTD_DLL_Path = 'C:\ti\mmwave_studio_02_01_01_00\mmWaveStudio\Clients\RtttNetClientController\RtttNetClientAPI.dll';
    ErrStatus = rstd_init(RSTD_DLL_Path, u, cip, str2num(fixport));
    if (ErrStatus ~= 30000)
        status = "error connection";
    else
        status = "connection done!!!";
    end
end

