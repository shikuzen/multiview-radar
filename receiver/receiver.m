% Define the port number to listen on
port = 12345;

% Create a UDP object
u = udp('localhost', port);

% Open the UDP connection
fopen(u);

disp('UDP Server is running. Waiting for messages...');

% Set a timeout for receiving messages (optional)
set(u, 'Timeout', 60); % Set timeout to 60 seconds

try
    while true
        % Specify the size for reading data
        dataSize = 1024; % Set to a positive value
        
        % Receive data
        dataReceived = fread(u, dataSize);

        if ~isempty(dataReceived)
            % Display received data
            disp(['Received message: ' char(dataReceived')]);
            
            % You can add your processing code here
            
            % If you want to send a response back, you can do it here
            
        end
    end
catch
    disp('Error occurred. Closing UDP connection.');
    fclose(u);
    delete(u);
end