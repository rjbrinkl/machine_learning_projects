
# coding: utf-8

# In[7]:


from Precode2 import *
import numpy
import sys
import math
data = np.load('AllSamples.npy')

k1,i_point1,k2,i_point2 = initial_S2('9352') # please replace 0111 with your last four digit of your ID

print(k1)
print(i_point1)
print(k2)
print(i_point2)

dataClass = [0] * 300

def computeDist(x1, x2, y1, y2):
    temp = math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
    return temp

def computeClusters(data, centroids, numClusters, classList):
    clusterChanged = 0
    
    for i in range(len(data)):
        minDist = 9999
        currentClass = 10
        for j in range(numClusters):
            distToCenter = computeDist(data[i][0], centroids[j][0], data[i][1], centroids[j][1])
            if distToCenter < minDist:
                currentClass = j
                minDist = distToCenter
        if classList[i] != currentClass:
            clusterChanged = 1
            classList[i] = currentClass
    print ('change: ' + str(clusterChanged))
    return clusterChanged

def computeInitial(data, clusters, indecesList):
    
    distToCenters = [0] * 300
    
    for i in range(len(data)):
        sumDist = 0
        for j in range(len(clusters)):
            sumDist += computeDist(data[i][0], clusters[j][0], data[i][1], clusters[j][1])
        distToCenters[i] = sumDist/len(clusters)

    centerToAdd = distToCenters.index(max(distToCenters))
    
    while centerToAdd in indecesList:
        distToCenters[centerToAdd] = 0
        centerToAdd = distToCenters.index(max(distToCenters))
        
    print(distToCenters[centerToAdd])
    return centerToAdd

def computeCenters(data, clusters):
    sumC0x = 0
    sumC0y = 0
    sumC1x = 0
    sumC1y = 0
    sumC2x = 0
    sumC2y = 0
    sumC3x = 0
    sumC3y = 0
    for i in range(len(clusters)):
        if clusters[i] == 0:
            sumC0x = sumC0x + data[i][0]
            sumC0y = sumC0y + data[i][1]
        elif clusters[i] == 1:
            sumC1x = sumC1x + data[i][0]
            sumC1y = sumC1y + data[i][1]
        elif clusters[i] == 2:
            sumC2x = sumC2x + data[i][0]
            sumC2y = sumC2y + data[i][1]
        elif clusters[i] == 3:
            sumC3x = sumC3x + data[i][0]
            sumC3y = sumC3y + data[i][1]
    
    if clusters.count(0) != 0:
        centers[0][0] = sumC0x/clusters.count(0)
        centers[0][1] = sumC0y/clusters.count(0)
    if clusters.count(1) != 0:
        centers[1][0] = sumC1x/clusters.count(1)
        centers[1][1] = sumC1y/clusters.count(1)
    if clusters.count(2) != 0:
        centers[2][0] = sumC2x/clusters.count(2)
        centers[2][1] = sumC2y/clusters.count(2)
    if clusters.count(3) != 0:
        centers[3][0] = sumC3x/clusters.count(3)
        centers[3][1] = sumC3y/clusters.count(3)
        
def computeCenters2(data, clusters):
    sumC0x = 0
    sumC0y = 0
    sumC1x = 0
    sumC1y = 0
    sumC2x = 0
    sumC2y = 0
    sumC3x = 0
    sumC3y = 0
    sumC4x = 0
    sumC4y = 0
    sumC5x = 0
    sumC5y = 0
    for i in range(len(clusters)):
        if clusters[i] == 0:
            sumC0x = sumC0x + data[i][0]
            sumC0y = sumC0y + data[i][1]
        elif clusters[i] == 1:
            sumC1x = sumC1x + data[i][0]
            sumC1y = sumC1y + data[i][1]
        elif clusters[i] == 2:
            sumC2x = sumC2x + data[i][0]
            sumC2y = sumC2y + data[i][1]
        elif clusters[i] == 3:
            sumC3x = sumC3x + data[i][0]
            sumC3y = sumC3y + data[i][1]
        elif clusters[i] == 4:
            sumC4x = sumC4x + data[i][0]
            sumC4y = sumC4y + data[i][1]
        elif clusters[i] == 5:
            sumC5x = sumC5x + data[i][0]
            sumC5y = sumC5y + data[i][1]
    
    if clusters.count(0) != 0:
        centers2[0][0] = sumC0x/clusters.count(0)
        centers2[0][1] = sumC0y/clusters.count(0)
    if clusters.count(1) != 0:
        centers2[1][0] = sumC1x/clusters.count(1)
        centers2[1][1] = sumC1y/clusters.count(1)
    if clusters.count(2) != 0:
        centers2[2][0] = sumC2x/clusters.count(2)
        centers2[2][1] = sumC2y/clusters.count(2)
    if clusters.count(3) != 0:
        centers2[3][0] = sumC3x/clusters.count(3)
        centers2[3][1] = sumC3y/clusters.count(3)
    if clusters.count(4) != 0:
        centers2[4][0] = sumC4x/clusters.count(4)
        centers2[4][1] = sumC4y/clusters.count(4)
    if clusters.count(5) != 0:
        centers2[5][0] = sumC5x/clusters.count(5)
        centers2[5][1] = sumC5y/clusters.count(5)
  

centers = [[i_point1[0], i_point1[1]]]
print(type(centers))
print (centers)

indecesOfCenters = []

while len(centers) < k1:

    newCenter = computeInitial(data, centers, indecesOfCenters)

    centers.append([data[newCenter][0], data[newCenter][1]])
    indecesOfCenters.append(newCenter)

for i in range(len(data)):
    minDist = 9999
    currentClass = 10
    for j in range(k1):
        distToCenter = computeDist(data[i][0], centers[j][0], data[i][1], centers[j][1])
        if distToCenter < minDist:
            currentClass = j
            minDist = distToCenter
    dataClass[i] = currentClass
    
changed = 1
while changed == 1:
    
    computeCenters(data, dataClass)
    
    changed = computeClusters(data, centers, k1, dataClass)
    
print(centers)

sseK1 = 0
for i in range(len(dataClass)):
    if dataClass[i] == 0:
        sseK1 += computeDist(data[i][0], centers[0][0], data[i][1], centers[0][1])**2
    if dataClass[i] == 1:
        sseK1 += computeDist(data[i][0], centers[1][0], data[i][1], centers[1][1])**2
    if dataClass[i] == 2:
        sseK1 += computeDist(data[i][0], centers[2][0], data[i][1], centers[2][1])**2
    if dataClass[i] == 3:
        sseK1 += computeDist(data[i][0], centers[3][0], data[i][1], centers[3][1])**2
        
print (sseK1)

centers2 = [[i_point2[0], i_point2[1]]]

indecesOfCenters2 = []

while len(centers2) < k2:

    newCenter2 = computeInitial(data, centers2, indecesOfCenters2)

    centers2.append([data[newCenter2][0], data[newCenter2][1]])
    indecesOfCenters2.append(newCenter2)

dataClass2 = [0] * 300

for i in range(len(data)):
    minDist = 9999
    currentClass = 10
    for j in range(k2):
        distToCenter = computeDist(data[i][0], centers2[j][0], data[i][1], centers2[j][1])
        if distToCenter < minDist:
            currentClass = j
            minDist = distToCenter
    dataClass2[i] = currentClass
    
changed = 1
while changed == 1:
    
    computeCenters2(data, dataClass2)
    
    changed = computeClusters(data, centers2, k2, dataClass2)

sseK2 = 0
for i in range(len(dataClass2)):
    if dataClass2[i] == 0:
        sseK2 += computeDist(data[i][0], centers2[0][0], data[i][1], centers2[0][1])**2
    if dataClass2[i] == 1:
        sseK2 += computeDist(data[i][0], centers2[1][0], data[i][1], centers2[1][1])**2
    if dataClass2[i] == 2:
        sseK2 += computeDist(data[i][0], centers2[2][0], data[i][1], centers2[2][1])**2
    if dataClass2[i] == 3:
        sseK2 += computeDist(data[i][0], centers2[3][0], data[i][1], centers2[3][1])**2
    if dataClass2[i] == 4:
        sseK2 += computeDist(data[i][0], centers2[4][0], data[i][1], centers2[4][1])**2
    if dataClass2[i] == 5:
        sseK2 += computeDist(data[i][0], centers2[5][0], data[i][1], centers2[5][1])**2
        
print (sseK2)