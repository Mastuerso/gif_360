import sys
import shutil
import cv2
import os
import math
import time
import numpy as np
from PIL import Image

ARGS = len(sys.argv)

print "*******************************"
print "Esta es la ruta del archovo: ", sys.argv[1]
print "*******************************"


calibracion = []
archivo = open(os.getcwd()+"/calibracion_camaras.txt", "r")
for linea in archivo.readlines():
    nuevoDato = linea
    calibracion.append(nuevoDato)

recortar = 0


#ruta = os.getcwd()
ruta = sys.argv[1]
ruta = ruta+"/images"

ruta_carpeta = sys.argv[1] + "/images_fin"


try: 
    shutil.rmtree(ruta_carpeta) 
    os.mkdir(ruta_carpeta)
except:
        
    os.mkdir(ruta_carpeta)



lista_img =  os.listdir(ruta)
lista_img = sorted(lista_img)

p=0

for imagenes in lista_img:
    
    try:
        valores = calibracion[p].split(",")

        img = Image.open(ruta+"/"+imagenes)

        imgrotate = img.rotate(float(valores[0]))
        imgrotate.save(ruta_carpeta+"/"+imagenes)
        p=p+1
    except :
        pass


p=0
aux = 0
aux2 = 0
for imagenes in lista_img:
    try:
        valores = calibracion[p].split(",")

        img = Image.open(ruta_carpeta+"/"+imagenes)

        x_xx, y_yy = img.size
        aux = x_xx
        
        caja = (0,int(valores[2])-75 , x_xx ,int(valores[3])+150)
        region = img.crop(caja) 
        region.size   
        region.save(ruta_carpeta+"/"+imagenes)

        p=p+1   
    except :
        pass


p=0
for val in calibracion :
    valores = calibracion[p].split(",")
    if int(valores[5]) < int(aux):
        aux =valores[5]
    p=p+1

p=0
for val in calibracion :
    valores = calibracion[p].split(",")
    if int(valores[5]) > int(aux2):
        aux2 =valores[5]
    p=p+1

print "este es el valor mas alejado a la derecha de totas la imagenes--> ", aux," --- " ,aux2

dato_x=[]
dato_y=[]
img_size=0
img_ancho=0

for imagenes in lista_img:
    try:
        img = Image.open(ruta_carpeta+"/"+imagenes)
        x, y = img.size
        img_ancho=x
        img_size = y
        nuevoDato_x = x
        nuevoDato_y= y
        dato_x.append(nuevoDato_x)
        dato_y.append(nuevoDato_y)    
    except :
        pass




for dato in dato_y:
    if int(dato) < int(img_size):
        img_size = dato
#print img_size ,"/////"
for imagenes in lista_img:
    try:
        img = Image.open(ruta_carpeta+"/"+imagenes)
        new_width  = img_ancho
        new_height = img_size
        img = img.resize((new_width, new_height), Image.ANTIALIAS)
        img.save(ruta_carpeta+"/"+imagenes)        
    except :
        pass

for cal in calibracion:
    valo = cal.split(",")
    if int(recortar) < int(valo[1]):
        recortar = valo[1]


for imagenes in lista_img:
    try:
        img = Image.open(ruta_carpeta+"/"+imagenes)
        x, y = img.size
        caja = (int(recortar),(int(recortar)/2) , x-int(recortar) ,y-int(recortar) )
        region = img.crop(caja) 
        region.size   
        region.save(ruta_carpeta+"/"+imagenes)
    except :
        pass    

p=0
valor_en_x=0
for imagenes in lista_img:
    try:
        valores = calibracion[p].split(",")

        if int(valores[4]) > int(valor_en_x) :
            valor_en_x= int(valores[4])
        p=p+1
    except :
        pass

p=0

for imagenes in lista_img:
    try:
        valores = calibracion[p].split(",")
        nuevo_x =int(valor_en_x) - int(valores[4])
        nuevo_x = nuevo_x * (-1)


        
        img = Image.open(ruta_carpeta+"/"+imagenes)
        x, y = img.size
        val_x = x/2
        val_x = val_x - int(valores[4])
        val_t=0

        if val_x < 0:
            val_t = val_x *(-1)
        if val_x > 0 :
            val_t =val_x *(-1)

        valor_pp = int(x) - int(aux2)
        print "----------///*** ", valor_pp
        valor_recortar = int(valores[5]) - int(aux)
        valor_recortar_y = int(aux) + int(valor_pp)
        print "estos son los eje x en recortar ---//",valor_recortar_y
        print "estos son los eje x en recortar ---//",valor_recortar 

        print "--->", val_x ," ** ", val_t
        
        par = y
        par =  par % 2

        if par == 1:
            y=y-1

        par2 = x-val_x
        par2 = par2 + val_x

        par2 = par2 % 2
        if par2 == 1 :
            x=x-1
        par3 = valor_recortar_y % 2
        if par3 == 1 :
            valor_recortar_y =valor_recortar_y-1
        
        #caja = (val_t,0 , x-val_x ,y )
        img = Image.open(ruta_carpeta+"/"+imagenes)
        caja = (valor_recortar,0 , x+valor_recortar ,y )
        region = img.crop(caja) 
        region.size   
        region.save(ruta_carpeta+"/"+imagenes)

        img2 = Image.open(ruta_carpeta+"/"+imagenes)
        caja2 = (0,0 , valor_recortar_y ,y )
        region2 = img2.crop(caja2) 
        region2.size   
        region2.save(ruta_carpeta+"/"+imagenes)


        p=p+1
    except :
        pass




    
print"******"

shutil.copytree(ruta,sys.argv[1]+"/images_original" )
shutil.rmtree(ruta) 
shutil.copytree(ruta_carpeta,sys.argv[1]+"/images" )
shutil.rmtree(ruta_carpeta)

print dato
print "mas grande es " , recortar
print "valor mas grande en x centro" , valor_en_x
print "el dato mas peque?o es", img_size ,img_ancho
print"****** "


    