clc;
clear all;
port = 12099; 
u = udpport("IPV4", 'LocalPort', port);
configureTerminator(u, "CR/LF");
disp('Server waiting for messages...');
while true   
    if u.NumBytesAvailable > 0
        msg = readline(u);
        msg = split(msg, "//");
        sub1 = msg{1};
        sub2 = cellstr(msg{2});
        fprintf("msg client: %s\n", msg{1});
        if strcmp(sub1, "rstd")
            resp = rstd_start();
            writeline(u, resp, sub2{1}, port);
        elseif strcmp(sub1, "getframe")
            resp = rstd_getframe();
            writeline(u, resp, sub2{1}, port);
        elseif strcmp(sub1, "stop") == 1
            break;
        end
    end
end
flush(u,"output");
clear u