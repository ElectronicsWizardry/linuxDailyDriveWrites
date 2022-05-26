#!/bin/env python3


def getSectorSize(drivePath):
    fullPath = "/sys/block/" + drivePath + "/queue/hw_sector_size"
    with open(fullPath) as sectorSizeFile:
        sectorSize = sectorSizeFile.read()
    return(sectorSize)




def readFile(path):
    diskArray = ['']
    with open(path) as diskStat:
        for line in diskStat:
            #print(line)
            diskArray.append(line.split())
    return(diskArray)

def getUptime(path):
    with open(path) as uptimeFile:
        for line in uptimeFile:
            uptimeArray = line.split()
    #print(uptimeArray)
    return(float(uptimeArray[0])/86400)

def printStats(procArray, uptime):
    print("{0:<6}{1:>10}{2:>20}{3:>20}{4:>20}".format("Drive", "GB Read", "GB Read/Day", "GB Written", "GB Written/Day"))

    for drive in range((len(procArray) - 1)):
        curDrive = procArray[drive + 1][2]
        try:
            curSectorSize = getSectorSize(curDrive)
            #print(curSectorSize)
            type(float(procArray[drive + 1][5]))
            dataRead = float(procArray[drive + 1][5]) * float(curSectorSize) * 0.00000000093132257462
            dataReadDaily = float(procArray[drive + 1][5]) * float(curSectorSize) * 0.00000000093132257462 / (float(uptime))  # assumes 512b sectors
            dataWritten = float(procArray[drive + 1][9]) * float(curSectorSize) * 0.00000000093132257462
            dataWrittenDaily = float(procArray[drive + 1][9]) * float(curSectorSize) * 0.00000000093132257462 / (float(uptime))  # assumes 512b sectors

            dataRead = round(dataRead, 5)
            dataReadDaily = round(dataReadDaily, 5)
            dataWritten = round(dataWritten, 5)
            dataWrittenDaily = round(dataWrittenDaily, 5)
            print("{0:<6}{1:>10}{2:>20}{3:>20}{4:>20}".format(curDrive, dataRead,dataReadDaily,dataWritten,dataWrittenDaily))
        except:
            pass
            #print(curDrive)
            #print("not found")
        #print(drive)



def main():
    #testDrive = input("what drive to test")
    #print(getSectorSize(testDrive))

    uptime = getUptime('/proc/uptime')
    procArray = readFile('/proc/diskstats')
    #print(procArray)
    #for i in range(len(procArray)):
    #    for j in range(len(procArray[i])):
    #        print(procArray[i][j])
    printStats(procArray, uptime)




if __name__ == '__main__':
    main()

