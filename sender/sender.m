% Define server addresses and ports
server1_address = '145.94.175.229';
port = 12345;

% Create UDP object
udp_sender = udp('', 'RemoteHost', server1_address, 'RemotePort', port);

try
    % Open the connection
    fopen(udp_sender);
    
    % Send data to the first server
    message1 = 'stop';
    fwrite(udp_sender, message1);
    
    % Close the connection
    fclose(udp_sender);
    
catch ME
    % Handle errors
    disp(ME.message);
    if strcmp(udp_sender.Status, 'open')
        fclose(udp_sender);
    end
end