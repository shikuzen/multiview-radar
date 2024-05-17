function ErrStatus = rstd_init(RSTD_DLL_Path, u, cip, fixport)
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
        writeline(u, "XX BSS Fail XX", cip, fixport);
    else
        disp('--BSS Pass--');
        writeline(u, "--BSS Pass--", cip, fixport);
    end
    pause(2);
    Mss_file = 'C:\\ti\\mmwave_studio_02_01_01_00\\rf_eval_firmware\\masterss\\xwr12xx_xwr14xx_masterss.bin';
    Lua_String = strcat('ar1.DownloadMSSFw','(''', Mss_file, ''')');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX MSS Fail XX');
        writeline(u, "XX MSS Fail XX", cip, fixport);
    else
        disp('--MSS Pass--');
        writeline(u, "--MSS Pass--", cip, fixport);
    end
    pause(2);
    Lua_String = 'ar1.PowerOn(1, 1000, 0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX SPI Fail XX');
        writeline(u, "XX SPI Fail XX", cip, fixport);
    else
        disp('--SPI Pass--');
        writeline(u, "--SPI Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.RfEnable()';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX RF Enable Fail XX');
        writeline(u, "--RF Enable Fail--", cip, fixport);
    else
        disp('--RF Enable Pass--');
        writeline(u, "--RF Enable Pass--", cip, fixport);
    end
    pause(5);
    Lua_String = 'ar1.ChanNAdcConfig(1, 1, 1, 1, 1, 1, 1, 2, 1, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chan config Fail XX');
        writeline(u, "--Chan config Fail--", cip, fixport);
    else
        disp('--Chan config Pass--');
        writeline(u, "--Chan config Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.LPModConfig(0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX LPMod Fail XX');
        writeline(u, "XX LPMod Fail XX", cip, fixport);
    else
        disp('--LPMod Pass--');
        writeline(u, "--LPMod Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.RfInit()';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Rf Init Fail XX');
        writeline(u, "XX Rf Init Fail XX", cip, fixport);
    else
        disp('--Rf Init Pass--');
        writeline(u, "--Rf Init Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.DataPathConfig(1, 1, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Data path Fail XX');
        writeline(u, "XX Data path Fail XX", cip, fixport);
    else
        disp('--Data path config Pass--');
        writeline(u, "--Data path Fail--c", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.LvdsClkConfig(1, 1)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX LVDS Fail XX');
        writeline(u, "XX LVDS Fail XX", cip, fixport);
    else
        disp('--LVDS Pass--');
        writeline(u, "--LVDS Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.LVDSLaneConfig(0, 1, 1, 1, 1, 1, 0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX LVDS Lane Fail XX');
        writeline(u, "XX LVDS Fail XX", cip, fixport);
    else
        disp('--LVDS Lane Pass--');
        writeline(u, "--LVDS Lane Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.ProfileConfig(0, 77, 7, 6, 106.9, 0, 0, 0, 0, 0, 0, 37.417, 1, 256, 3000, 0, 0, 30)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Profile config Fail XX');
        writeline(u, "XX Profile config Fail XX", cip, fixport);
    else
        disp('--Profile config Pass--');
        writeline(u, "--Profile config Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.ChirpConfig(0, 0, 0, 0, 0, 0, 0, 1, 0, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chirp 1 config Fail XX');
        writeline(u, "XX Chirp 1 config Fail XX", cip, fixport);
    else
        disp('--Chirp 1 config Pass--');
        writeline(u, "--Chirp 1 config Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.ChirpConfig(1, 1, 0, 0, 0, 0, 0, 0, 1, 0)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chirp 2 config Fail XX');
        writeline(u, "XX Chirp 2 config Fail XX", cip, fixport);
    else
        disp('--Chirp 2 config Pass--');
        writeline(u, "--Chirp 2 config Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.ChirpConfig(2, 2, 0, 0, 0, 0, 0, 0, 0, 1)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Chirp 3 config Fail XX');
        writeline(u, "XX Chirp 3 config Fail XX", cip, fixport);
    else
        disp('--Chirp 3 config Pass--');
        writeline(u, "--Chirp 3 config Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.FrameConfig(0, 2, 0, 32, 33.333333, 0, 0, 1)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX Frame config Fail XX');
        writeline(u, "XX Frame config Fail XX", cip, fixport);
    else
        disp('--Frame config Pass--');
        writeline(u, "--Frame config Pass--", cip, fixport);
    end
    pause(1);
    DCA_file = 'DCA1000';
    Lua_String = strcat('ar1.SelectCaptureDevice("', DCA_file,'")');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX DCA Fail XX');
        writeline(u, "XX DCA Fail XX--", cip, fixport);
    else
        disp('--DCA Pass--');
        writeline(u, "--DCA Pass--", cip, fixport);
    end
    pause(1);
    ip1 = '192.168.33.30';
    ip2 = '192.168.33.180';
    mac = '12:34:56:78:90:12';
    Lua_String = strcat('ar1.CaptureCardConfig_EthInit("', ip1,'", "', ip2, '", "', mac, '",', ' 4096, 4098)');
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCCE Fail XX');
        writeline(u, "XX CCCE Fail XX", cip, fixport);
    else
        disp('--CCCE Pass--');
        writeline(u, "--CCCE Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.CaptureCardConfig_Mode(1, 1, 1, 2, 3, 30)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCCM Fail XX');
        writeline(u, "XX CCCM Fail XX", cip, fixport);
    else
        disp('--CCCM Pass--');
        writeline(u, "--CCCM Pass--", cip, fixport);
    end
    pause(1);
    Lua_String = 'ar1.CaptureCardConfig_PacketDelay(25)';
    ErrStatus = RtttNetClientAPI.RtttNetClient.SendCommand(Lua_String);
    if (ErrStatus ~= 30000)
        disp('XX CCCP Fail XX');
        writeline(u, "XX CCCP Fail XX", cip, fixport);
    else
        disp('--CCCP Pass--');
        writeline(u, "--CCCP Pass--", cip, fixport);
    end
    pause(1);

disp('all config success');
writeline(u, "all config success", cip, fixport);
end