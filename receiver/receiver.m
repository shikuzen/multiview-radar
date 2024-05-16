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
        disp(msg);
        sub1 = msg{1};
        sub2 = cellstr(msg{2});
        sub3 = cellstr(msg{3});
        fprintf("msg client: %s\n", sub1);
        if strcmp(sub1, "rstd")
            resp = rstd_start();
            writeline(u, resp, sub2{1}, sub3{1});
        elseif strcmp(sub1, "getframe")
            resp = rstd_getframe();
            writeline(u, resp, sub2{1}, sub3{1});
        elseif strcmp(sub1, "stop") == 1
            break;
        end
    end
end
flush(u,"output");
clear u