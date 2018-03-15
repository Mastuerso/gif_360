#!/usr/bin/env python
import sys
import cv2
import os
import math
import time
import numpy
import glob
from PIL import Image
ARGS = len(sys.argv)

print "*******************************"
print "Esta es la ruta del archovo: ", sys.argv[1]
print "*******************************"

ruta = sys.argv[1] + "/images"

calibracion = []
archivo = open(os.getcwd()+"/calibracion_camaras.txt", "r")
for linea in archivo.readlines():
    nuevoDato = linea
    calibracion.append(nuevoDato)

max_corte_x = 0
max_corte_y = 0
p=0
for cal in calibracion:
    valores = calibracion[p].split(",")
    if max_corte_x < int(valores[3]):
        max_corte_x = int(valores[3])

    if max_corte_y < int(valores[4]):
        max_corte_y = int(valores[4])
    p=p+1



lista_img =  os.listdir(ruta)
lista_img = sorted(lista_img)
max_corte_y = int(max_corte_y)
max_corte_x = int(max_corte_x)
print "max_corte_x: ", max_corte_x, "max_corte_y: ", max_corte_y

p=0
#os.makedirs(ruta+"/bkup/")
for imagenes in lista_img:

    try:
        valores = calibracion[p].split(",")
        workImg = cv2.imread(ruta+"/"+imagenes)
	#cv2.imwrite(ruta+"/bkup/"+str(imagenes), workImg)
        rows,cols = workImg.shape[:2]
        M = numpy.float32([[1,0,int(valores[0])],[0,1,int(valores[1])]])
        dst = cv2.warpAffine(workImg,M,(cols,rows))
	#cv2.imwrite(ruta+"/bkup/"+str(imagenes), dst)
        N = cv2.getRotationMatrix2D((cols/2,rows/2),float(valores[2]), 1)
        dst_N = cv2.warpAffine(dst,N,(cols,rows))
	#cv2.imwrite(ruta+"/bkup/"+str(imagenes), dst_N)

        cropped = dst_N[max_corte_y:-max_corte_y, max_corte_x:-max_corte_x]
	#cv2.imwrite(ruta+"/bkup/"+str(imagenes), cropped)
        cv2.imwrite(ruta+"/"+str(imagenes), cropped)
        p=p+1
    except :
        pass