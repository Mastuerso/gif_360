import sys
import cv2
import os
import math
import time
import numpy as np
from PIL import Image
import cv2
 


def parametros(nombre, texto_txt, dato_centro, centro_centro ):
    dato_xx= dato_centro

    nuevo_nombre = nombre

    imagen_nombre = str(nuevo_nombre)
    print "///////////////////////////////////////"
    print nombre
    print texto_txt
    print dato_centro
    print "///////////////////////////////////////"
    ruta = sys.argv[1]
    ruta = ruta+"/img_rotadas"

    original = cv2.imread(ruta+"/"+files)

    gris = cv2.cvtColor(original, cv2.COLOR_BGR2GRAY)

    gauss = cv2.GaussianBlur(gris, (5,5), 0)

    canny = cv2.Canny(gauss, 50, 150)

    (_, contornos,_) = cv2.findContours(canny.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        

    dato_x=[]
    dato_y=[]
    datos = []
    datos1 = []
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
        datos.append(int (nuevoDato_x))
        datos1.append(int(nuevoDato_y))

    

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



    texto_txt = texto_txt+str(mas_alto_y)+","+str(mas_bajo_y)+","+str(dato_xx)+","+str(centro_centro)+'\n'

    
    outfile = open(os.getcwd()+'/calibracion_camaras.txt', 'a') 
    outfile.write(texto_txt)
    outfile.close()
    print "e terminado"


    





 #ruta = os.getcwd()
ARGS = len(sys.argv)
print "*******************************"
print "Esta es la ruta del archovo: ", sys.argv[1]
print "*******************************"
ruta = sys.argv[1]
ruta = ruta+"/images"

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
    datos = []
    datos1 = []
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
        
        datos.append(int (nuevoDato_x))
        datos1.append(int(nuevoDato_y))


    dat=0

    #for datos in dato_x:
    #    original = cv2.circle(original,(int(dato_x[dat]),int(dato_y[dat])), 27, (0,0,255), -1)
    #    dat=dat+1

    #cv2.imwrite(ruta+"/"+files, original)

    print("He encontrado {} objetos".format(len(contornos)))


    print "estos son en x-- ", datos
    print "estos son en y-- ",datos1

    dato_centro = 0
    dato_centro_y=0
    dato_mayor = 0
    dato_mayor_y=0

    mas_alto_y=0
    mas_bajo_y=0


    # optiene maximo en x minimo en y

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
    
    if int(datos[0]) == int(datos[2]):
        if int(datos[1]) == int(datos[2]) :
            dato_centro = datos[2]
            dato_centro_y=datos1[2]

    if int(datos[0]) == int(datos[2]):
        if int(datos[1]) == int(datos[2]) :
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

    print "este es el centro de cada punto" ,dato_centro_y

    print"estos son los datos y ", m_y , "dati en x " , m_x , "mes el total == " , m_m

    print "dato en centro x " , datos[1]

    print "dato en centro y " , datos1[1]

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


    img = Image.open(ruta+"/"+files)
    imgrotate = img.rotate(grados)
    imgrotate.save(ruta_carpetas+"/img_rotadas/"+files)

    

    if b == 1:
        a=grados * -1
        grados = a
    

    cortar1  = grados*26
    cortar1 =int(cortar1)

    texto_txt = texto_txt+str(cortar1)+","
    time.sleep(1)
    parametros(files , texto_txt, dato_centro, datos[1])

    img2 = Image.open(ruta+"/"+files)

    x_xx, y_yy = img2.size
    caja = (cortar1, cortar1, (x_xx-cortar1) , (y_yy-cortar1))
    region = img2.crop(caja)  
    region.size   
    region.save(ruta_carpetas+"/calib_fin/"+files)
    



parametros = []
archivo = open(os.getcwd()+"/gif_settings.txt", "r")

for linea in archivo.readlines():
    if linea == "calibrated=0\n" :
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
