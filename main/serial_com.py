#!/usr/bin/env python
import serial
import sys
import time
import subprocess

def getValuesY():
    ser.write(b'y')
    arduinoData = ser.readline().decode('ascii')
    return arduinoData

def getValuesN():
    ser.write(b'n')
    arduinoData = ser.readline().decode('ascii')
    return arduinoData

ser = serial.Serial('/dev/ttyUSB0', baudrate = 9600, timeout = .1)
time.sleep(2)
ARGS = len(sys.argv)

cmd = [ 'bash', 'dummy.sh', 'funciona' ]
dummyRes = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
dummyRes.rstrip("\n\r")

print("El mensaje enviado fue " + dummyRes)

if ARGS > 1:
    OPTION = sys.argv[1]
    if OPTION == 'y':
        print(getValuesY())
    else:
        print(getValuesN())


#print "This is the name of the script: ", sys.argv[0]
#print "This is the argument passed: ", sys.argv[1]
#print "Number of arguments: ", len(sys.argv)
#print "The arguments are: " , str(sys.argv)

#loop=1

#ser = serial.Serial('/dev/ttyUSB0', baudrate = 9600, timeout = 1)



#while(loop):
#
#    userInput = raw_input('Get data point?')
#
#    if userInput == 'y':
#        print(getValuesY())
#        loop=0
#    elif userInput == 'n':
#        print(getValuesN())
#        loop=0
#    elif userInput == 'x':
#        loop=0
