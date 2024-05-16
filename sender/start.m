function start(ip1, ip2, port1, port2)
    fixport = 10000;
    u = udpport("IPV4", 'LocalPort', fixport);
    configureTerminator(u,"CR/LF");
    ip_client = ipread();
    msg = strcat("getframe","//",ip_client,"//", num2str(fixport));
    writeline(u, msg, ip1, port1);
    writeline(u, msg, ip2, port2);
    % resp = readline(u);
    % fprintf("msg resp: %s\n", resp);
    clear u;
end

