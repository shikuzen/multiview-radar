function start(ip, port)
    u = udpport("IPV4", 'LocalPort', port);
    configureTerminator(u,"CR/LF");
    ip_client = ipread();
    msg = strcat("getframe","//",ip_client);
    writeline(u, msg, ip, port);    
    % resp = readline(u);
    % fprintf("msg resp: %s\n", resp);
    clear u;
end

