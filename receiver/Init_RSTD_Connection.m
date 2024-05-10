function ErrStatus = Init_RSTD_Connection(RSTD_DLL_Path)
    if (strcmp(which('RtttNetClientAPI.RtttNetClient.IsConnected'),''))
        disp('Adding RSTD Assembly');
        RSTD_Assembly = NET.addAssembly(RSTD_DLL_Path);
        if ~strcmp(RSTD_Assembly.Classes{1},'RtttNetClientAPI.RtttClient')
            disp('RSTD Assembly not loaded correctly. Check DLL path');
            ErrStatus = -10;
            return
        end
        Init_RSTD_Connection = 1;
    elseif ~RtttNetClientAPI.RtttNetClient.IsConnected() 
        Init_RSTD_Connection = 1;
    else
        Init_RSTD_Connection = 0;
    end
   
    if Init_RSTD_Connection
        disp('Initializing RSTD client');
        ErrStatus = RtttNetClientAPI.RtttNetClient.Init();
        if (ErrStatus ~= 0)
            disp('Unable to initialize NetClient DLL');
            return;
        end
        disp('Connecting to RSTD client');
        ErrStatus = RtttNetClientAPI.RtttNetClient.Connect('127.0.0.1',2777);
        if (ErrStatus ~= 0)
            disp('Unable to connect to mmWaveStudio');
            disp('Reopen port in mmWaveStudio. Type RSTD.NetClose() followed RSTD.NetStart()');
            return;
        end
        pause(1);
    end
    disp('Sending test message to RSTD');
    

    Bss_file = 'C:\\ti\\mmwave_studio_02_01_01_00\\rf_eval_firmware\\radarss\\xwr12xx_xwr14xx_radarss.bin';
    Lua_String = strcat('ar1.DownloadBSSFw','(''', Bss_file, ''')');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX BSS Fail XX');
    else
        disp('--BSS Pass--');
    end
    pause(2);
    Mss_file = 'C:\\ti\\mmwave_studio_02_01_01_00\\rf_eval_firmware\\masterss\\xwr12xx_xwr14xx_masterss.bin';
    Lua_String = strcat('ar1.DownloadMSSFw','(''', Mss_file, ''')');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX MSS Fail XX');
    else
        disp('--MSS Pass--');
    end
    pause(2);
    Lua_String = 'ar1.PowerOn(1, 1000, 0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX SPI Fail XX');
    else
        disp('--SPI Pass--');
    end
    pause(1);
    Lua_String = 'ar1.RfEnable()';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX RF Enable FailXX');
    else
        disp('--RF Enable Pass--');
    end
    pause(8);
    Lua_String = 'ar1.ChanNAdcConfig(1, 1, 1, 1, 1, 1, 1, 2, 1, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chan config Fail XX');
    else
        disp('--Chan config Pass--');
    end
    pause(1);
    Lua_String = 'ar1.LPModConfig(0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX LPMod Fail XX');
    else
        disp('--LPMod Pass--');
    end
    pause(1);
    Lua_String = 'ar1.RfInit()';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Rf Init Fail XX');
    else
        disp('--Rf Init Pass--');
    end
    pause(1);
    Lua_String = 'ar1.DataPathConfig(1, 1, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Data path Fail XX');
    else
        disp('--Data path config Pass--');
    end
    pause(1);
    Lua_String = 'ar1.LvdsClkConfig(1, 1)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX LVDS Fail XX');
    else
        disp('--LVDS Pass--');
    end
    pause(1);
    Lua_String = 'ar1.LVDSLaneConfig(0, 1, 1, 1, 1, 1, 0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX LVDS Lane Fail XX');
    else
        disp('--LVDS Lane Pass--');
    end
    pause(1);
    Lua_String = 'ar1.ProfileConfig(0, 77, 7, 6, 106.9, 0, 0, 0, 0, 0, 0, 37.417, 1, 256, 3000, 0, 0, 30)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Profile config Fail XX');
    else
        disp('--Profile config Pass--');
    end
    pause(1);
    Lua_String = 'ar1.ChirpConfig(0, 0, 0, 0, 0, 0, 0, 1, 0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chirp 1 config Fail XX');
    else
        disp('--Chirp 1 config Pass--');
    end
    pause(1);
    Lua_String = 'ar1.ChirpConfig(1, 1, 0, 0, 0, 0, 0, 0, 1, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chirp 2 config Fail XX');
    else
        disp('--Chirp 2 config Pass--');
    end
    pause(1);
    Lua_String = 'ar1.ChirpConfig(2, 2, 0, 0, 0, 0, 0, 0, 0, 1)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chirp 3 config Fail XX');
    else
        disp('--Chirp 3 config Pass--');
    end
    pause(1);
    Lua_String = 'ar1.FrameConfig(0, 2, 0, 32, 33.333333, 0, 0, 1)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Frame config Fail XX');
    else
        disp('--Frame config Pass--');
    end
    pause(1);
    DCA_file = 'DCA1000';
    Lua_String = strcat('ar1.SelectCaptureDevice("', DCA_file,'")');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX DCA Fail XX');
    else
        disp('--DCA Pass--');
    end
    pause(1);
    ip1 = '192.168.33.30';
    ip2 = '192.168.33.180';
    mac = '12:34:56:78:90:12';
    Lua_String = strcat('ar1.CaptureCardConfig_EthInit("', ip1,'", "', ip2, '", "', mac, '",', ' 4096, 4098)');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCCE Fail XX');
    else
        disp('--CCCE Pass--');
    end
    pause(1);
    Lua_String = 'ar1.CaptureCardConfig_Mode(1, 1, 1, 2, 3, 30)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCCM Fail XX');
    else
        disp('--CCCM Pass--');
    end
    pause(1);
    Lua_String = 'ar1.CaptureCardConfig_PacketDelay(25)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCCP Fail XX');
    else
        disp('--CCCP Pass--');
    end
    pause(1);


disp('all config success');
end