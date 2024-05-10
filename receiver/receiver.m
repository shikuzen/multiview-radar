clc;
clear all;
server_address = '0.0.0.0';
port = 12345;
udp_receiver = udp(server_address, port, 'LocalPort', port);
udp.EnablePortSharing = 'on';
set(udp_receiver, 'InputBufferSize', 1024);
set(udp_receiver, 'Timeout', 1);

fopen(udp_receiver);
disp('start_receive');
while true
    if udp_receiver.ByteAvailable > 0
        data = fread(udp_receiver, udp_receiver.ByteAvailable);
        sender_address = udp_receiver.RemoteAddress;
        sender_port = udp_receiver.RemotePort;
        disp(['msg: ', char(data)]);
        disp(['sender_ip: ' server_address]);
        udp_sender = udp(sender_address, sender_port);
        try
            fopen(udp_sender);
            response = 'con_success';
            fwrite(udp_sender, response);
            fclose(udp_sender);
        catch ME
            disp(ME.message);
            if strcmp(udp_sender.Status, 'open')
                fclose(udp_sender);
            end
        end
        if strcmp(char(data'), 'stop') == 1
            break;
        end
    end
end
fclose(udp_receiver);