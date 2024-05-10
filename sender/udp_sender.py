import socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

server1_address = ('145.94.175.229', 12345)

try:
    # Send data to the first server
    message1 = b'stop'
    sock.sendto(message1, server1_address)


finally:
    # Close the socket
    sock.close()