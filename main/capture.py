#!/usr/bin/env python
import serial
import sys
import subprocess
import time

def compare(a, b, encoding="utf8"):
    if isinstance(a, bytes):
        a = a.decode(encoding)
    if isinstance(b, bytes):
        b = b.decode(encoding)
    return a == b

def gifSelected():
    cmd = [ 'bash', 'gif_type.sh']
    selection = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
    selection = selection.rstrip("\r\n")
    return selection

cmd = [ 'bash', 'cam_setup.sh' ]
cameras = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]

serialArduino = serial.Serial('/dev/ttyACM0', baudrate = 9600, timeout = .1)
serialArduino.flushInput()
time.sleep(4)

cmd = [ 'bash', 'take_pics.sh', cameras ]
save_cmd = [ 'bash', 'save_pics.sh', cameras ]
calib_cmd = [ 'bash', 'auto_config.sh', cameras ]

print("\n===READY===")

while 1:
    value = serialArduino.readline().rstrip()
    if value == "trigger":
        #print("triggered")
        print("\n===WAIT===")
        gifType = gifSelected()
        if compare(gifType, "dinamic"):
            #print("Dinamic gif ...")
            subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
        elif compare(gifType, "freeze"):
            #print("freeze gif ...")
            serialArduino.write(b'f')
            #time.sleep(1)
        elif compare(gifType, "calibration"):
            subprocess.Popen(calib_cmd, stdout=subprocess.PIPE).communicate()[0]
            serialArduino.write(b'f')
        #RECOVER PICS
        #UPDATE CHORE.LIST
        #var = raw_input("Proceed: ")
        #if var is "y":
        #    subprocess.Popen(save_cmd, stdout=subprocess.PIPE).communicate()[0]
        subprocess.Popen(save_cmd, stdout=subprocess.PIPE).communicate()[0]
        #time.sleep(40)
        print("\n===READY===")
