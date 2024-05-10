function x = start(number, ip, port)
    fix_path = 'C:\\multiview_radar\\data';
    folder_name = strcat(fix_path, '\\', num2str(number));
    save_name = 'adc_data.bin';
    mkdir(folder_name);
    up = udpport;
    % write(up, folder_label, "string", ip, port);
    pause(2);

    % save_path = strcat(folder_name, '\\', save_name);
    % Lua_String = strcat('ar1.CaptureCardConfig_StartRecord("', save_path, '", 1)');
    % ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    % if (ErrStatus ~= 30000)
    %     disp('XX CCF Start Fail XX');
    % else
    %     disp('--CCF Start--');
    % end
    % pause(3);
    % write(up, 'start', "string", ip, port);
    % Lua_String = 'ar1.StartFrame()';
    % ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    % if (ErrStatus ~= 30000)
    %     disp('XX START XX');
    % else
    %     disp('--START--');
    % end
    % pause(time);
    % Lua_String = 'ar1.StopFrame()';
    % ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    % if (ErrStatus ~= 30000)
    %     disp('XX STOP XX');
    % else
    %     disp('--STOP--');
    % end
    % write(up, 'stop', "string", ip, port);
    % x = "stop";
    % pause(11);
    % 
    % Lua_String = strcat('ar1.StartMatlabPostProc("', save_path, '")');
    % ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    % if (ErrStatus ~= 30000)
    %     disp('XX MATLAB XX');
    % else
    %     disp('--MATLAB--');
    % end

end
