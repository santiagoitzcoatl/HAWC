import sys, csv ,operator

data = csv.reader(open("C_10amp.csv"), delimiter=",")
sortedlist = sorted(data, key=lambda x:float(x[1]), reverse= True)    # 0 specifies according to first column we want to sort

#now write the sorte result into new CSV file
with open("C_10amp.csv", "wb") as f:
    fileWriter = csv.writer(f, delimiter=',')
    for row in sortedlist:
        fileWriter.writerow(row)
