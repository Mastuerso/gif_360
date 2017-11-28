#!/usr/bin/env python
import serial
import sys
import time
import subprocess

#ser = serial.Serial('/dev/ttyUSB0', baudrate = 9600, timeout = .1)
#ser.flushInput()
#time.sleep(2)
#ARGS = len(sys.argv)
#loop=1

#while loop:
#    value = serialArduino.readline().rstrip()
#    if value == "trigger":
#        print("triggered")
#        loop = 0
#    else:
#        print("not triggered")
        #loop = 0

#def getValuesY():
#    ser.write(b'y')
#    arduinoData = ser.readline().decode('ascii')
#    return arduinoData

#def getValuesN():
#    ser.write(b'n')
#    arduinoData = ser.readline().decode('ascii')
#    return arduinoData

cmd = [ 'bash', 'cam_setup.sh' ]
dummyRes = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
#dummyRes = dummyRes.rstrip("\n\r")
print("Message received: \n" + dummyRes)

cmd = [ 'bash', 'take_pics.sh', dummyRes ]
#dummyRes2 = subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
subprocess.Popen(cmd, stdout=subprocess.PIPE).communicate()[0]
#dummyRes = dummyRes.rstrip("\n\r")

#print("Message received 2: \n" + dummyRes2)



#if ARGS > 1:
#    OPTION = sys.argv[1]
#    if OPTION == 'y':
#        print(getValuesY())
#    else:
#        print(getValuesN())


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
