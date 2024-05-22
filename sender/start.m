function start(rad_ip_1, rad_ip_2, rad_port_1, rad_port_2, cam_ip, cam_port)
    fixport = 10000;
    u = udpport("IPV4", 'LocalPort', fixport);
    configureTerminator(u,"CR/LF");
    ip_client = ipread();
    msg = strcat("getframe","//",ip_client,"//", num2str(fixport));
    writeline(u, msg, rad_ip_1, rad_port_1); % ip cam1
    writeline(u, msg, rad_ip_2, rad_port_2); % ip cam2
    %% start cam
    while true
        if u.NumBytesAvailable > 0
            rmsg = readline(u);
            if strcmp(rmsg, "start") == 1
                writeline(u, "start", cam_ip, cam_port);
            elseif strcmp(rmsg, "stop") == 1
                writeline(u, "stop", cam_ip, cam_port);
                break;
            end
        end
    end
    clear u;
end

    