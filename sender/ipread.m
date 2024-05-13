function ip = ipread()
    [status, result] = system('ipconfig');
    % Check if the command was executed successfully
    if status == 0
        % Regular expression pattern to match IPv4 addresses
        pattern = '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
        
        % Find all matches of the pattern in the output
        ip_addresses = regexp(result, pattern, 'match');
        ip = ip_addresses(1);
    else
        disp('Error running ipconfig command');
    end
end

