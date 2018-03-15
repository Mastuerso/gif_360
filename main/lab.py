#!/usr/bin/env python
import sys
import os
# import the necessary packages
#import cv2
#
## load the image and show it
#image = cv2.imread("/home/onikom/Pictures/jurassic-park-tour-jeep.jpg")
#(h, w) = image.shape[:2]
##print  "W:", w, ", H:", h
#cut = [30, 16]
#cv2.imshow("original", image)
#cv2.waitKey(0)
#cropped = image[cut[0]:-cut[0], cut[1]:-cut[1]]
#cv2.imshow("cropped", cropped)
#cv2.waitKey(0)

existence=os.path.isfile("trigger.flag")
if not existence:
    f=open("trigger.flag","w+")
    f.close()

f=open("trigger.flag","r")
content = f.read()
f.close()

if "1" in content:
    f=open("trigger.flag","w")
    #f.write("")
    f.close()


#file = open("gif_settings.txt", "r")
##print file.read()
#for line in file:
#    if "calibrated" in line:
#        print line