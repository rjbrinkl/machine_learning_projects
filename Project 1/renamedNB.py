
# coding: utf-8

# In[48]:


import numpy
import scipy.io
import math
import geneNewData
import scipy.stats

def main():
    myID='9352'
    geneNewData.geneData(myID)
    Numpyfile0 = scipy.io.loadmat('digit0_stu_train'+myID+'.mat')
    Numpyfile1 = scipy.io.loadmat('digit1_stu_train'+myID+'.mat')
    Numpyfile2 = scipy.io.loadmat('digit0_testset'+'.mat')
    Numpyfile3 = scipy.io.loadmat('digit1_testset'+'.mat')
    train0 = Numpyfile0.get('target_img')
    train1 = Numpyfile1.get('target_img')
    test0 = Numpyfile2.get('target_img')
    test1 = Numpyfile3.get('target_img')
    print([len(train0),len(train1),len(test0),len(test1)])
    print('Your trainset and testset are generated successfully!')
    
    imageSize = 28 * 28  #784
    
    ##Task 1
    featuresDig0 = extractFeatures(train0)
    featuresDig1 = extractFeatures(train1)
        
    ##Task 2
    featureMetrics = []
    
    meanFeature1Digit0 = sum(featuresDig0[0])/5000
    varFeature1Digit0 = numpy.var(featuresDig0[0])
    featureMetrics.append(meanFeature1Digit0)
    featureMetrics.append(varFeature1Digit0)
    
    meanFeature2Digit0 = sum(featuresDig0[1])/5000
    varFeature2Digit0 = numpy.var(featuresDig0[1])
    featureMetrics.append(meanFeature2Digit0)
    featureMetrics.append(varFeature2Digit0)
       
    meanFeature1Digit1 = sum(featuresDig1[0])/5000
    varFeature1Digit1 = numpy.var(featuresDig1[0])
    featureMetrics.append(meanFeature1Digit1)
    featureMetrics.append(varFeature1Digit1)
      
    meanFeature2Digit1 = sum(featuresDig1[1])/5000
    varFeature2Digit1 = numpy.var(featuresDig1[1])
    featureMetrics.append(meanFeature2Digit1)
    featureMetrics.append(varFeature2Digit1)
    
    ##Task 3
    testFeaturesDig0 = extractFeatures(test0)
    testFeaturesDig1 = extractFeatures(test1)
    
    normFeature1Dig0 = scipy.stats.norm(featureMetrics[0], math.sqrt(featureMetrics[1]))
    normFeature2Dig0 = scipy.stats.norm(featureMetrics[2], math.sqrt(featureMetrics[3]))
    normFeature1Dig1 = scipy.stats.norm(featureMetrics[4], math.sqrt(featureMetrics[5]))
    normFeature2Dig1 = scipy.stats.norm(featureMetrics[6], math.sqrt(featureMetrics[7]))
    
    predTest0 = []
    predTest1 = []
    
    for i in range(len(test0)):
        probDig0 = normFeature1Dig0.pdf(testFeaturesDig0[0][i]) * normFeature2Dig0.pdf(testFeaturesDig0[1][i]) * 0.5        
        probDig1 = normFeature1Dig1.pdf(testFeaturesDig0[0][i]) * normFeature2Dig1.pdf(testFeaturesDig0[1][i]) * 0.5
        
        if probDig0 > probDig1:
            predTest0.append(0)
        else:
            predTest0.append(1)

    for i in range(len(test1)):
        probDig0 = normFeature1Dig0.pdf(testFeaturesDig1[0][i]) * normFeature2Dig0.pdf(testFeaturesDig1[1][i]) * 0.5        
        probDig1 = normFeature1Dig1.pdf(testFeaturesDig1[0][i]) * normFeature2Dig1.pdf(testFeaturesDig1[1][i]) * 0.5
        
        if probDig0 > probDig1:
            predTest1.append(0)
        else:
            predTest1.append(1)
           
    ##Task 4
    countCorrect = 0
    for i in range(len(predTest0)):
        if predTest0[i] == 0:
            countCorrect += 1
    test0Acc = countCorrect/len(predTest0)
    
    countCorrect = 0
    for i in range(len(predTest1)):
        if predTest1[i] == 1:
            countCorrect += 1
    test1Acc = countCorrect/len(predTest1)
    
    print('dig 0 acc: ' + str(test0Acc))
    print('dig 1 acc: ' + str(test1Acc))
    
    pass

def extractFeatures(data):
    averagePix = []
    stdPix = []
    
    for i in range(len(data)):
        averagePix.append(numpy.mean(data[i]))
        stdPix.append(numpy.std(data[i]))
        
    features = []
    features.append(averagePix)
    features.append(stdPix)
    return features

    
    

if __name__ == '__main__':
    main()

