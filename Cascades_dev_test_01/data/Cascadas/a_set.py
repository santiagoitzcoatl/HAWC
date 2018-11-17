from datetime import datetime as dt
from os import path
import math as m
import numpy as np
import sys, csv

def setLimits():
    
    print("")
    print(">> {} -".format(dt.now().strftime('%Y%m%d @ %H:%M:%S')))
    
    path = "/Users/Santiago/_DATA/PROYECTOS/HAWC/ESCENA/test_05_model/data/Cascadas/"
    i = 1
    j = 8143
    
    while i < j:
        
        file = "C_"+str(i).zfill(5)+".csv"
        
        with open(path+file,"rb") as source:
            rdr= csv.reader( source )
            with open(path+"V_"+str(i).zfill(5)+".csv","wb") as result:
                wtr= csv.writer( result )
                for r in rdr:
                    wtr.writerow( (int(r[0]), float(r[1]), float(r[2]), float(r[5]), float(r[6])) )
        
        # sort
        data = csv.reader(open(path+"V_"+str(i).zfill(5)+".csv"), delimiter=",")
        
        # Tiempo
        sortedT = sorted(data, key=lambda x:float(x[1]))
        tArray = []
        for row in sortedT:
            tArray.append(row)
            
        with open(path+"V_"+str(i).zfill(5)+".csv", "wb") as t:
            fileWriter = csv.writer(t, delimiter=',')
            for row in sortedT:
                fileWriter.writerow(row)
        
        # Limits
        data = csv.reader(open(path+"V_"+str(i).zfill(5)+".csv"), delimiter=",")
        
        # Amplitude
        sortedA = sorted(data, key=lambda x:float(x[1]), reverse= True)
        aArray = []
        print (aArray)
        for row in sortedA:
            aArray.append(row)
            print (row)
        # X
        sortedX = sorted(sortedA, key=lambda x:float(x[3]), reverse= True)
        xArray = []
        for row in sortedX:
            xArray.append(row)
        # Y
        sortedY = sorted(sortedX, key=lambda x:float(x[4]), reverse= True)
        yArray = []
        for row in sortedY:
            yArray.append(row)
        
        # set limits
        maxA = aArray[0][1]
        minA = aArray[len(aArray)-1][1]
        maxX = xArray[0][1]
        minX = xArray[len(xArray)-1][3]
        maxY = yArray[0][2]
        minY = yArray[len(yArray)-1][4]
        
        print ("max amplitude: "+maxA)
        print ("min amplitude: "+minA)
        print ("max x position: "+maxX)
        print ("min x position: "+minX)
        print ("max y position: "+maxY)
        print ("min y position: "+minY)
        print ("- - - - - - - -")
        f = open(path+"L_"+str(i).zfill(5)+".csv",'w')
        #f.write(maxA+","+minA)
        f.write(maxA+","+minA+","+maxX+","+minX+","+maxY+","+minY)
        f.close()
        
        i += 1

if __name__=="__main__":
    setLimits()
