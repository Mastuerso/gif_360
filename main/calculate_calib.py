#!/usr/bin/env python
import sys
import cv2
import os
import math
import time
import numpy
import glob
import argparse
import imutils
from PIL import Image
from imutils import contours
from skimage import measure


print "===================PYTHON COMPUTE CALIBRATION==================="

def calculateTraslation(origin, finalPoint):
    #print "origin: ", origin
    #print "finalPoint: ", finalPoint
    movement=[0,0]

    if (finalPoint[0] == origin[0]):
        movement[0] = 0
    elif (finalPoint[0] >= origin[0]):
        movement[0] -= finalPoint[0] - origin[0]
    else:
        movement[0] = origin[0] - finalPoint[0]

    if (finalPoint[1] == origin[1]):
        movement[1] = 0
    elif (finalPoint[1] >= origin[1]):
        movement[1] -= finalPoint[1] - origin[1]
    else:
        movement[1] = origin[1] - finalPoint[1]

    return movement


def dotspin(p1, angle):
    rotM = numpy.array([[ numpy.cos( angle ), -numpy.sin( angle ) ],
                        [ numpy.sin( angle ), numpy.cos( angle ) ]])
    dot = numpy.array([[ p1[0] ],
                       [ p1[1] ]])
    return rotM.dot(dot)

def midpoint(p1, p2):
    middle = [0, 0]
    middle[0] = ( p1[0] + p2[0]) / 2
    middle[1] = ( p1[1] + p2[1]) / 2
    return middle

def magvect(v):
  magnitude = numpy.sqrt(v[0]*v[0] + v[1]*v[1])
  return magnitude

def angle(v1,v2):
  ang = numpy.arccos( numpy.dot( v1, v2 )/( magvect( v1 )*magvect( v2 ) ) )
  #ang = ang*180/numpy.pi
  #if (ang > 90):
    #ang = 180 + ang
    #    print "magv1 magv2 dv1v2 cos(angle)", magv1, magv2, dv1v2, dv1v2/(magv1*magv2)
  return ang

def adjust(number):
    number = int(number)
    res = number%2
    if (res == 0):
        number += 2
    else:
        number += 3
    return number

mdir = os.getcwd()
#working dir
wdir = sys.argv[1]
#images dir
idir = wdir + "/images"
#images list
imgList = []
lista =  os.listdir(idir)
lista = sorted(lista)
imgList = lista
#print lista

#imgList = sorted( os.listdir( idir ) )

print "------------------------"
print idir
print imgList
print "------------------------"
try:
    os.remove(os.getcwd()+'/calibracion_camaras.txt')
except:
    pass
img = Image.open(idir+"/"+ imgList[0] )
width, height = img.size
imgCenter = [width/2, height/2]
print "W: ", width, "H: ", height
print "Center is at: [", imgCenter[0], ", ", imgCenter[1], "]"

img.close()

max_pointx = []
min_pointx = []
max_pointy = []
min_pointy = []
img_list = []
calib_img = []

index = 0

for imges in imgList:

    #print "-------"
    img_list.append( idir+"/"+imges)
    #Just for testing
    calib_img.append( idir+"/calibrated/"+imges)

    # load the image, convert it to grayscale, and blur it
    image = cv2.imread(idir+"/"+imges)
    print "image: ", imges
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (11, 11), 0)

    # threshold the image to reveal light regions in the
    # blurred image
    thresh = cv2.threshold(blurred, 40, 255, cv2.THRESH_BINARY)[1]

    # perform a series of erosions and dilations to remove
    # any small blobs of noise from the thresholded image
    thresh = cv2.erode(thresh, None, iterations=2)
    thresh = cv2.dilate(thresh, None, iterations=4)

    # perform a connected component analysis on the thresholded
    # image, then initialize a mask to store only the "large"
    # components
    labels = measure.label(thresh, neighbors=8, background=0)
    mask = numpy.zeros(thresh.shape, dtype="uint8")

    # loop over the unique components
    for label in numpy.unique(labels):
    	# if this is the background label, ignore it
    	if label == 0:
    		continue

    	# otherwise, construct the label mask and count the
    	# number of pixels
    	labelMask = numpy.zeros(thresh.shape, dtype="uint8")
    	labelMask[labels == label] = 255
    	numPixels = cv2.countNonZero(labelMask)

    	# if the number of pixels in the component is sufficiently
    	# large, then add it to our mask of "large blobs"
    	if numPixels > 100:
    		mask = cv2.add(mask, labelMask)

    # find the contours in the mask, then sort them from left to
    # right
    cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
    	cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] if imutils.is_cv2() else cnts[1]
    cnts = contours.sort_contours(cnts, method="bottom-to-top")[0]

    dato_x=[]
    dato_y=[]

    # loop over the contours
    for (i, c) in enumerate(cnts):
    	# draw the bright spot on the image
    	(x, y, w, h) = cv2.boundingRect(c)
    	((cX, cY), radius) = cv2.minEnclosingCircle(c)
        dato_x.append(cX)
        dato_y.append(cY)
    	#print "cX: ", cX, " cY: ", cY
    	cv2.circle(image, (int(cX), int(cY)), int(radius),
    		(0, 0, 255), 3)
    	#cv2.putText(image, "#{}".format(i + 1), (x, y - 15),
    	#	cv2.FONT_HERSHEY_SIMPLEX, 0.45, (0, 0, 255), 2)

    # show the output image
    #cv2.imshow("Image", image)
    #cv2.waitKey(0)
    # save the image
    testDir = wdir+"/test/"
    if not os.path.exists(testDir):
        os.makedirs(testDir)
    cv2.imwrite(testDir + imges, image)

    max_pointx.append( dato_x[0] )
    max_pointy.append( dato_y[0] )
    min_pointx.append( dato_x[1] )
    min_pointy.append( dato_y[1] )

print "-------" #out of for
#print max_pointx, max_pointy
index = 0
imgVector = [0, 0]
maxDot = [0, 0]
minDot = [0, 0]
corner = [0, 0] #upper left
cut = [0, 0]

#calibDir = idir + "/calibrated/"
#if not os.path.exists(calibDir):
#    os.makedirs(calibDir)

for point in max_pointx:
    print "============================="
    maxDot[0] = int( max_pointx[index] );
    maxDot[1] = int( max_pointy[index] );
    minDot[0] = int( min_pointx[index] );
    minDot[1] = int( min_pointy[index] );
    center = midpoint(maxDot, minDot)
    center[0] = int(center[0])
    center[1] = int(center[1])
    imgMov = calculateTraslation(imgCenter, center)
    #print "Highest Point[", maxDot[0], ",", maxDot[1], "]"
    #print "Lowest Point[", minDot[0], ",", minDot[1], "]"
    imgVector[0] = int(max_pointx[index]) - int(min_pointx[index])
    imgVector[1] = int(max_pointy[index]) - int(min_pointy[index])
    #print "imgVector: ", imgVector[0]
    jVector = ( 0, 1)
    #iVector = ( 1, -1)
    rotation = angle(jVector, imgVector)
    rotationDeg = (rotation*180/numpy.pi)

    if (imgVector[0] > 0):
        rotationDeg *= -1
        rotation *= -1

    if (rotationDeg > 0):
        corner[0] = center[0] + imgMov[0]
    else:
        corner[0] = -center[0] + imgMov[0]

    corner[1] = center[1] + imgMov[1]
    rotCorner = dotspin(corner, rotation)

    if (rotationDeg > 0):
        cut[0] = corner[0] - rotCorner[0]
    else:
        cut[0] = rotCorner[0] - corner[0]

    if (imgMov[0] > 0):
        cut[0] += imgMov[0]
    else:
        cut[0] += (imgMov[0])*-1

    if (imgMov[1] > 0):
        cut[1] = rotCorner[1] - corner[1] + imgMov[1]
    else:
        cut[1] = rotCorner[1] - corner[1] - imgMov[1]

    cut[0] = adjust(cut[0])
    cut[1] = adjust(cut[1])

    #print "Image dir: ", img_list[index] imgList[index]
    print "Image: ", imgList[index]
    #print "Calib dir: ", calib_img[index]
    #print "center: ", center
    print "Traslate: [", imgMov[0], ", ", imgMov[1], "]"

    texto = str(imgMov[0])+","+str(imgMov[1])


    print "Rotate: ", rotation, "rads to deg:", rotationDeg
    #print "Corner: ", corner
    #print "after rotation: ", rotCorner[0], ",", rotCorner[1]
    print "Trim - left&rigth ", cut[0], " top&bot ", cut[1]

    texto = texto + ","+str(rotationDeg)+","+str(cut[0])+","+str(cut[1])+"\n"

    outfile = open(os.getcwd()+'/calibracion_camaras.txt', 'a')
    outfile.write(texto)
    outfile.close()

    print texto
    #workImg = cv2.imread(img_list[index],0)
    #rows,cols = workImg.shape
    #M = numpy.float32([[1,0,imgMov[0]],[0,1,imgMov[1]]])
    #dst = cv2.warpAffine(workImg,M,(cols,rows))
    #N = cv2.getRotationMatrix2D((cols/2,rows/2), rotationDeg, 1)
    #dst_N = cv2.warpAffine(dst,N,(cols,rows))
    #cv2.imwrite(calib_img[index], dst_N)

    index+=1



parametros = []
archivo = open(os.getcwd()+"/gif_settings.txt", "r")

for linea in archivo.readlines():
    if linea == "calibrated = 0\n" :
        nuevoDato = "calibrated = 1\n"
        parametros.append(nuevoDato)

    else:
        nuevoDato = linea
        parametros.append(nuevoDato)

texto_fichero=""

for linea in parametros:
    texto_fichero =texto_fichero+str(linea)

fechero=open(os.getcwd()+"/gif_settings.txt","w")
fechero.write(texto_fichero)
fechero.close()
