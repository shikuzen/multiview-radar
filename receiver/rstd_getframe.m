function status = rstd_getframe(u, cip, fixport)
    fixport = str2num(fixport);
    fix_path = 'C:\\distributed_data';
    mkdir(fix_path);
    save_path = strcat(fix_path, '\\', 'adc_data.bin');
    Lua_String = strcat('ar1.CaptureCardConfig_StartRecord("', save_path, '", 1)');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCF Start Fail XX');
    else
        disp('--CCF Start--');
    end
    pause(3);

    Lua_String = 'ar1.StartFrame()';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    writeline(u, "start", cip, fixport);
    
    if (ErrStatus ~= 30000)
        disp('XX START XX');
    else
        disp('--START--');
    end
    pause(35); %% frame time
    Lua_String = 'ar1.StopFrame()';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    writeline(u, "stop", cip, fixport);
    if (ErrStatus ~= 30000)
        disp('XX STOP XX');
    else
        disp('--STOP--');
    end
    status = "stop";
    pause(10);
 
    Lua_String = strcat('ar1.StartMatlabPostProc("', save_path, '")');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX MATLAB XX');
    else
        disp('--MATLAB--');
    end
end

