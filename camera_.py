import cv2
import os
import socket
import shutil

save_folder = "C:/distributed_radar/"
UDP_IP = "127.0.0.1"
UDP_PORT = 8080
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))
sock.setblocking(0)

cam = cv2.VideoCapture(0, cv2.CAP_DSHOW)
cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)
cam.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
cam.set(cv2.CAP_PROP_AUTOFOCUS, 0)

while True:
    ret_, img_ = cam.read()

    try:
        data, addr = sock.recvfrom(1024)

    except socket.error:
        save_pic_path = data.decode("utf-8")

        if (data == b'getframe') :
            t1 = 1
            