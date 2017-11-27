#!/usr/bin/env python
import serial
import sys
import subprocess

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

serialArduino = serial.Serial('/dev/ttyUSB0', baudrate = 9600, timeout = .1)
serialArduino.flushInput()
time.sleep(2)
loop=1

while loop:
    value = serialArduino.readline().rstrip()

    if value is "trigger":
        print("triggered")

    gifType = gifSelected()

    if compare(gifType, "dinamic"):
        print("Dinamic gif ...")
    elif compare(gifType, "freeze"):
        print("freeze gif ...")
    loop = 0
