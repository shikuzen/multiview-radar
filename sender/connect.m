function connect(ip, port)
    fixport = 10000; %% fixport
    u = udpport("IPV4", 'LocalPort', fixport);
    configureTerminator(u,"CR/LF");
    ip_client = ipread();
    msg = strcat("rstd","//", ip_client, "//", num2str(fixport));
    writeline(u, msg, ip, port);
    update = 0;
    f = waitbar(update,"waiting load config");
    while true
        if u.NumBytesAvailable > 0
            rmsg = readline(u);
            update = update + 0.05; 
            waitbar(update, f, rmsg);
            
            if strcmp(rmsg, "all config success") == 1
                break;
            elseif strcmp(rmsg, "XX BSS Fail XX") == 1
                break;
            end
        end
    end     
    pause(0.5)
    close(f);
    clear u;
end

