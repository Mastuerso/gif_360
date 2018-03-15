import sys
import shutil
import cv2
import os
import math
import time
import numpy as np
from PIL import Image


def parametrosf(nombre, texto_txt, dato_centro):

    dato_xx= dato_centro

    nuevo_nombre = str(nombre)

    imagen_nombre = str(nuevo_nombre)

    img = cv2.imread(ruta_carpetas+"/img_rotadas/"+nuevo_nombre)
    src = cv2.medianBlur(img, 5)
    src = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)

    circles = cv2.HoughCircles(src, cv2.HOUGH_GRADIENT, 1, 20,
                                param1=50, param2=30, minRadius=0, maxRadius=0)

    circles = np.uint16(np.around(circles))



    datos = []
    datos1 = []
    a=0

    for i in circles[0,:]:
        nuevoDato = i[0]
        nuevoDato1 = i[1]
        datos.append(nuevoDato)
        datos1.append(nuevoDato1)
        print nuevoDato1
        # dibujar circulo 
        cv2.circle(img, (i[0], i[1]), i[2], (0,255,0), 2)
        # dibujar centro
        cv2.circle(img, (i[0], i[1]), 2, (0,0,255), 3)




    dato_centro = 0
    dato_centro_y=0
    dato_mayor = 0
    dato_mayor_y=0

    mas_alto_y=0
    mas_bajo_y=0
    
 

    # optiene maximo en y minimo en y

    if datos1[0] > datos1[2]:
        if datos1[0] > datos1[1]:
            mas_bajo_y=datos1[0]

    if datos1[1] > datos1[2]:
        if datos1[1] > datos1[0]:
            mas_bajo_y=datos1[1]            

    if datos1[2] > datos1[0]:
        if datos1[2] > datos1[1]:
            mas_bajo_y=datos1[2]



    if datos1[0] < datos1[2]:
        if datos1[0] < datos1[1]:
            mas_alto_y=datos1[0]

    if datos1[1] < datos1[2]:
        if datos1[1] < datos1[0]:
            mas_alto_y=datos1[1]            

    if datos1[2] < datos1[0]:
        if datos1[2] < datos1[1]:
            mas_alto_y=datos1[2]


    

    # fin optiene maximo en y minimo en y



    texto_txt = texto_txt+str(mas_alto_y)+","+str(mas_bajo_y)+","+str(dato_xx)+'\n'

    
    outfile = open(os.getcwd()+'/calibracion_camaras.txt', 'a') 
    outfile.write(texto_txt)
    outfile.close()

    #cv2.imshow('detected circles', img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()




def ajustar(nombre):

    print"---------------"


    nuevo_nombre = nombre

    print nuevo_nombre

    imagen_nombre = str(nuevo_nombre)

    img = cv2.imread(ruta+"/"+nuevo_nombre)
    src = cv2.medianBlur(img, 5)
    src = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)

    circles = cv2.HoughCircles(src, cv2.HOUGH_GRADIENT, 1, 20,
                                param1=50, param2=15, minRadius=0, maxRadius=0)

    circles = np.uint16(np.around(circles))
    a =0
    for i in circles[0,:]:
        # dibujar circulo 
        cv2.circle(img, (i[0], i[1]), i[2], (0,255,0), 2)
        # dibujar centro
        cv2.circle(img, (i[0], i[1]), 2, (0,0,255), 3)
        a= a+1
  


    datos = []
    datos1 = []
    a=0

    for i in circles[0,:]:
        nuevoDato = i[0]
        nuevoDato1 = i[1]
        datos.append(nuevoDato)
        datos1.append(nuevoDato1)
        # dibujar circulo 
        cv2.circle(img, (i[0], i[1]), i[2], (0,255,0), 2)
        # dibujar centro
        cv2.circle(img, (i[0], i[1]), 2, (0,0,255), 3)




    dato_centro = 0
    dato_centro_y=0
    dato_mayor = 0
    dato_mayor_y=0

    mas_alto_y=0
    mas_bajo_y=0


    # optiene maximo en y minimo en y

    if datos1[0] > datos1[2]:
        if datos1[0] > datos1[1]:
            mas_bajo_y=datos1[0]

    if datos1[1] > datos1[2]:
        if datos1[1] > datos1[0]:
            mas_bajo_y=datos1[1]            

    if datos1[2] > datos1[0]:
        if datos1[2] > datos1[1]:
            mas_bajo_y=datos1[2]



    if datos1[0] < datos1[2]:
        if datos1[0] < datos1[1]:
            mas_alto_y=datos1[0]

    if datos1[1] < datos1[2]:
        if datos1[1] < datos1[0]:
            mas_alto_y=datos1[1]            

    if datos1[2] < datos1[0]:
        if datos1[2] < datos1[1]:
            mas_alto_y=datos1[2]


    

    # fin optiene maximo en y minimo en y

    # identificadores alineados entre si

    if datos[0] == datos[2]:
        if datos[1] == datos[2] :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]
    if datos[0] == datos[2]:
        if datos[1] == datos[2] :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]

    # fin identificadores alineados entre si

    #centro dato[2]
    if datos[0] > datos[2]:
        if datos[1]< datos[2] :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]
    if datos[0] < datos[2]:
        if datos[1]> datos[2] :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]

    #centro dato[2]

    #centro dato[0]
    if datos[2] > datos[0]:
        if datos[1]< datos[0] :
            dato_centro = datos[0]
            dato_centro_y=datos1[0]
    if datos[2] < datos[0]:
        if datos[1]> datos[0] :
            dato_centro = datos[0]
            dato_centro_y=datos1[0]

#---
    if datos[2] == datos[0]:
        if datos[1]> datos[0] :
            dato_centro = datos[0]
            dato_centro_y=datos1[0]

    if datos[2] == datos[0]:
        if datos[1]< datos[0] :
            dato_centro = datos[1]
            dato_centro_y=datos1[1]

    if datos[1] == datos[0]:
        if datos[2]> datos[0] :
            dato_centro = datos[0]
            dato_centro_y=datos1[0]

    if datos[1] == datos[0]:
        if datos[2]< datos[0] :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]


    if datos[1] == datos[2]:
        if datos[2]> datos[0]:
            dato_centro = datos[0]
            dato_centro_y=datos1[0]

    if datos[1] == datos[2]:
        if datos[2]< datos[0] :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]

#---
    #centro dato[0]

    #centro dato[1]
    if datos[0] > datos[1]:
        if datos[2]< datos[1] :
            dato_centro = datos[1]
            dato_centro_y=datos1[1]

    if datos[0] < datos[1]:
        if datos[2]> datos[1] :
            dato_centro = datos[1]
            dato_centro_y=datos1[1]

    #centro dato[1]

    #punto mayor
    if datos[0] < datos[2]:
        if datos[1]< datos[2] :
            dato_mayor = datos[2]
            dato_mayor_y=datos1[2]

    if datos[2] < datos[0]:
        if datos[1]< datos[0] :
            dato_mayor = datos[0]
            dato_mayor_y=datos1[0]

    if datos[0] < datos[1]:
        if datos[2]< datos[1] :
            dato_mayor = datos[1]
            dato_mayor_y=datos1[1]

    if datos[0] == datos[1]:
        if datos[2] == datos[1] :
            dato_mayor = datos[1]
            dato_mayor_y=datos1[1]

    # fin punto mayor

    resultado = int(dato_mayor-dato_centro)
    #print resultado
    resultado =float(resultado)/10
    #print resultado



    m_y = float(dato_centro_y)-dato_mayor_y
    m_x = float(dato_mayor)-dato_centro
    m_m =0
    if m_y != 0 :
        if m_x != 0 :
            m_m = float(m_y)/m_x

    print"estos son los datos y ", m_y , "dati en x " , m_x , "mes el total == " , m_m

    print "el dato mas alto ", mas_alto_y

    print "el dato mas bajo ", mas_bajo_y

    radianes = float(math.atan(m_m))
    b=0

    if radianes < 0:
        radianes = radianes * -1
        b=1

    grados = float(radianes) * 180

    grados = float (grados)/3.14

    if grados != 0 :
        grados = 90.00 - grados

    if b == 1:
        a=grados * -1
        grados = a
    

    print "radianes --> ",radianes

    print "angulos --> ", grados

    texto_txt = str(grados)+","

    img = Image.open(ruta+"/"+nuevo_nombre)
    imgrotate = img.rotate(grados)
    imgrotate.save(ruta_carpetas+"/img_rotadas/"+imagen_nombre)

    

    if b == 1:
        a=grados * -1
        grados = a
    

    cortar1  = grados*10
    cortar1 =int(cortar1)

    texto_txt = texto_txt+str(cortar1)+","
    
    parametrosf(files , texto_txt, dato_centro)

    time.sleep(5)
    img2 = Image.open(ruta+"/"+nuevo_nombre)

    x_xx, y_yy = img2.size
    caja = (cortar1, cortar1, (x_xx-cortar1) , (y_yy-cortar1))
    region = img2.crop(caja)  
    #region.size   
    region.save(ruta_carpetas+"/calib_fin/"+imagen_nombre)
    img2.close()
    region.close()

    #cv2.imshow('detected circles', img)
    #cv2.waitKey(0)
    #cv2.destroyAllWindows()

#ruta = os.getcwd()
ARGS = len(sys.argv)
print "*******************************"
print "Esta es la ruta del archovo: ", sys.argv[1]
print "*******************************"
ruta = sys.argv[1]
ruta = ruta+"/images"

lista =  os.listdir(ruta)
lista = sorted(lista)

ruta_carpetas = sys.argv[1]

try: 
    os.remove(os.getcwd()+'/calibracion_camaras.txt')
except:
    pass

try: 
    shutil.rmtree(ruta_carpetas+"/img_rotadas") 
    os.mkdir(ruta_carpetas+"/img_rotadas")
except:
        
    os.mkdir(ruta_carpetas+"/img_rotadas")

try: 
    shutil.rmtree(ruta_carpetas+"/calib_fin") 
    os.mkdir(ruta_carpetas+"/calib_fin")
except:
        
    os.mkdir(ruta_carpetas+"/calib_fin")
    
    
 


for files in lista:
    try:
        img = Image.open(ruta+"/"+files)
        img.close()
    except :
        shutil.rmtree(ruta_carpetas+"/img_rotadas") 
        shutil.rmtree(ruta_carpetas+"/calib_fin") 
        break
    ajustar(files)
    print"---------------"

parametros = []
archivo = open(os.getcwd()+"/gif_settings.txt", "r")
for linea in archivo.readlines():
    if linea == "calibrated=0\n" :
        print "encontre linea que voy a modifica"
        nuevoDato = "calibrated=1\n"
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

print"----------------------------------------"
print texto_fichero
print"----------------------------------------"
