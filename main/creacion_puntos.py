import sys
import cv2
import os
import math
import time
import numpy as np
from PIL import Image
import cv2
 
 #ruta = os.getcwd()
ARGS = len(sys.argv)
print "*******************************"
print "Esta es la ruta del archovo: ", sys.argv[1]
print "*******************************"
radio = int(sys.argv[2])
ruta = sys.argv[1]
ruta = ruta+"/images"

lista =  os.listdir(ruta)
lista = sorted(lista)


for files in lista:
    print"---------------"
    print files    
    
    try:
        img = Image.open(ruta+"/"+files)
        img.close()
    except :
        break


    original = cv2.imread(ruta+"/"+files)

    gris = cv2.cvtColor(original, cv2.COLOR_BGR2GRAY)

    gauss = cv2.GaussianBlur(gris, (5,5), 0)

    canny = cv2.Canny(gauss, 50, 150)

    (_, contornos,_) = cv2.findContours(canny.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    

    dato_x=[]
    dato_y=[]


    for ass in contornos:
        
        p=0
        j=1
        eje_x=0
        eje_y=0

        
        valor = str(ass)
        valor = valor.replace("[[[ ", "")
        valor = valor.replace("]]]", "")    
        valor = valor.replace("]]", "")
        valor = valor.replace("[[ ", "")
        valor = valor.replace("[[", "")
        valor = valor.replace("[", "")
        valor = valor.replace("]", "")
        valor = valor.replace("  ", " ")
        
        valor = valor.replace("\n", "")
        valor = valor.split(' ')

        tamano_arreglo=float(len(valor))


        for val in valor:
            try:
                        
                eje_x=eje_x+int(valor[p])
                p=p+2
            except :
                
                pass

        for val in valor:
            try:
                eje_y=eje_y+int(valor[j])
                j=j+2
            except :
                pass


        nuevoDato_x = eje_x / (tamano_arreglo/2)
        nuevoDato_y= eje_y / (tamano_arreglo/2)
        dato_x.append(nuevoDato_x)
        dato_y.append(nuevoDato_y)   


    dat=0
    for datos in dato_x:
        original = cv2.circle(original,(int(dato_x[dat]),int(dato_y[dat])), radio, (0,0,255), -1)
        dat=dat+1

    cv2.imwrite(ruta+"/"+files, original)

    print("He encontrado {} objetos".format(len(contornos)))
    
    cv2.drawContours(original,contornos,-1,(0,0,255), 2)
    cv2.waitKey(0)
    print"---------------"
