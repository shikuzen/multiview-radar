function x = connect(ip, port)
    clc;
    clear all;
    server_address = ip;
    server_port = port;
    udp_sender = udp('', 'RemoteHost', server_address, 'RemotePort', server_port);
    try
        % Open the connection
        fopen(udp_sender);
        % Send data to the first server
        message = 'Init_RSTD';
        fwrite(udp_sender, message);
        data = fread(udp_receiver, udp_receiver.BytesAvailable);
        disp(['get_response: ', char(data')]);
        fclose(udp_sender);

    catch ME
        % Handle errors
        disp(ME.message);
        if strcmp(udp_sender.Status, 'open')
            fclose(udp_sender);
        end
    end
end

