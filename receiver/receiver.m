clc;
clear all;
%% udp receive declare
port = 8080; 
u = udpport("IPV4", 'LocalPort', port);
configureTerminator(u, "CR/LF");
disp('Server waiting for messages...');
%% waiting for msg incoming from sender
while true   
    if u.NumBytesAvailable > 0
        msg = readline(u);
        msg = split(msg, "//");
        disp(msg);
        sub1 = msg{1};
        cip = cellstr(msg{2});
        fixport = cellstr(msg{3});
        fprintf("msg client: %s\n", sub1);
        if strcmp(sub1, "rstd")
            resp = rstd_start(u, cip{1}, fixport{1});
        elseif strcmp(sub1, "getframe")
            resp = rstd_getframe();
        elseif strcmp(sub1, "stop") == 1
            break;
        end
    end
end
flush(u,"output");
clear u