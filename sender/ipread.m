function ipv4Address = ipread()
   % Execute ipconfig command
    [~, cmdout] = system('ipconfig');
    
    % Find the Wi-Fi adapter information
    startIndex = strfind(cmdout, 'Wi-Fi');
    if isempty(startIndex)
        ipv4Address = 'Wi-Fi adapter not found';
        return;
    end
    
    % Extract the IPv4 address
    ipv4Pattern = '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
    match = regexp(cmdout(startIndex:end), ipv4Pattern, 'match', 'once');
    
    if isempty(match)
        ipv4Address = 'No IPv4 address found for Wi-Fi adapter';
    else
        ipv4Address = match;
    end
end

