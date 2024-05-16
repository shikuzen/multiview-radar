function connect(ip, port)
    fixport = 10000;
    u = udpport("IPV4", 'LocalPort', fixport);
    configureTerminator(u,"CR/LF");
    ip_client = ipread();
    msg = strcat("rstd","//", ip_client, "//", num2str(fixport));
    writeline(u, msg, ip, port);    
    % % resp = readline(u);
    % % fprintf("msg resp: %s\n", resp);
    clear u;
end

