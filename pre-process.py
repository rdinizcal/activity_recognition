def main():
    timestamps = list()
    measurements = list(list())

    lines = list(list())

    with open("sensorLog.txt") as f:
        for line in f:
            sline = line.split()

            # clean unwanted measurements
            if (sline[1] == "GYR" or sline[1] == "ACC"): 
                lines.append([sline[0],sline[1],sline[2],sline[3],sline[4]])

    for i in range(len(lines)):
        if(i < len(lines)-1 and lines[i][0] == lines[i+1][0]):
            timestamps.append(lines[i][0])
            measurements.append([lines[i][1],lines[i][2],lines[i][3],lines[i][4]])
            measurements.append([lines[i+1][1],lines[i+1][2],lines[i+1][3],lines[i+1][4]])
    
    f = open("output.txt", "w")
    for ts in timestamps: f.write(str(ts) + " ")
    f.write("\n")
    for m in measurements: 
        if(str(m[0])=="ACC"): 
            f.write(str(m[1]) + " ") 
    f.write("\n")
    for m in measurements: 
        if(str(m[0])=="ACC"): 
            f.write(str(m[2]) + " ") 
    f.write("\n")
    for m in measurements: 
        if(str(m[0])=="ACC"): 
            f.write(str(m[3]) + " ") 
    f.write("\n")
    for m in measurements: 
        if(str(m[0])=="GYR"): 
            f.write(str(m[1]) + " ") 
    f.write("\n")
    for m in measurements: 
        if(str(m[0])=="GYR"): 
            f.write(str(m[2]) + " ") 
    f.write("\n")
    for m in measurements: 
        if(str(m[0])=="GYR"): 
            f.write(str(m[3]) + " ") 
    f.write("\n")


    #for m in measurements: 
    #    if(str(m[0])=="GYR"): 
    #        f.write(str(m[0]) + " " + str(m[1]) + " " + str(m[2]) + " " + str(m[3]) + "\n") 

    f.close()

if __name__== "__main__":
    main()