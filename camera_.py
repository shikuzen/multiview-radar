import cv2
import os
import socket
import shutil
import time

save_folder = "C:/distributed_radar/"
UDP_IP = "127.0.0.1"
UDP_PORT = 8080
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))
sock.setblocking(0)

cam = cv2.VideoCapture(1, cv2.CAP_DSHOW)
# cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
# cam.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
# cam.set(cv2.CAP_PROP_AUTOFOCUS, 0)
# cam.set(cv2.CAP_PROP_FPS, 30)

data = "default"
start_time = time.time()
display_time = 2
fc = 0
FPS = 0

count=0
while True:
    ret_, img_ = cam.read()
    
    ##---------FPS----------##
    fc+=1
    TIME = time.time() - start_time
    
    if (TIME) >= display_time :
        FPS = fc / (TIME)
        fc = 0
        start_time = time.time()
    fps_disp = "FPS: "+ str(FPS)[:5]
    ##----------------------##

    try:
        data, addr = sock.recvfrom(1024)
        print(data)

    except socket.error:
        
        if data == b'start\r\n':
            cv2.imwrite("C:/distributed_data/77_79/" + str(count) + '.jpg', img_)
            count += 1
        elif data == b'stop\r\n':
            print("stop_sending")
            pass

        img_ = cv2.putText(img_, fps_disp, (10, 25), 
                            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)
        cv2.imshow('cam1', img_)

        key = cv2.waitKey(1)
        if key == ord('q'):
            break            