from datetime import datetime as dt
from os import path
import math as m
import numpy as np
import sys, csv

def setLimits():
    
    print("")
    print(">> {} -".format(dt.now().strftime('%Y%m%d @ %H:%M:%S')))
    
    path = "/Users/Santiago/_DATA/PROYECTOS/HAWC/ESCENA/test_05_model/data/Cascadas/"
    i = 10
    j = 20
    
    while i < j:
        
        file = "C_"+str(i)+".csv"
        
        with open(path+file,"rb") as source:
            rdr= csv.reader( source )
            with open(path+"C_"+str(i)+"-val.csv","wb") as result:
                wtr= csv.writer( result )
                for r in rdr:
                    wtr.writerow( (float(r[1]), float(r[5]), float(r[6])) )
        
        # sort
        data = csv.reader(open(path+"C_"+str(i)+"-val.csv"), delimiter=",")
        
        # Amp
        sortedAmp = sorted(data, key=lambda x:float(x[0]), reverse= True)    # 0 specifies according to first column we want to sort
        ampArray = []
        for row in sortedAmp:
            #fileWriter.writerow(row)
            ampArray.append(row)
        # X
        sortedX = sorted(sortedAmp, key=lambda x:float(x[1]), reverse= True)    # 0 specifies according to first column we want to sort
        xArray = []
        for row in sortedX:
            #fileWriter.writerow(row)
            xArray.append(row)
        # Y
        sortedY = sorted(sortedAmp, key=lambda x:float(x[2]), reverse= True)    # 0 specifies according to first column we want to sort
        yArray = []
        for row in sortedY:
            #fileWriter.writerow(row)
            yArray.append(row)
            
        
        maxAmp = ampArray[0][0]
        minAmp = ampArray[len(ampArray)-1][0]
        maxX = xArray[0][1]
        minX = xArray[len(xArray)-1][1]
        maxY = yArray[0][2]
        minY = yArray[len(yArray)-1][2]
        
        print ("max amp: "+maxAmp)
        print ("min amp: "+minAmp)
        print ("max x: "+maxX)
        print ("min x: "+minX)
        print ("max y: "+maxY)
        print ("min y: "+minY)
        print ("-")
        
        
        f = open(path+"C_"+str(i)+"-limits.csv",'w')
        
        f.write(maxAmp+","+minAmp+","+maxX+","+minX+","+maxY+","+minY)
        f.close()
        
        # Amp
        #with open(path+"C_"+str(i)+"-val.csv", "wb") as f:
        #    fileWriter = csv.writer(f, delimiter=',')
        #    ampArray = []
        #    for row in sortedlist:
                #fileWriter.writerow(row)
        #        ampArray.append(row)

        i += 1

if __name__=="__main__":
    setLimits()
