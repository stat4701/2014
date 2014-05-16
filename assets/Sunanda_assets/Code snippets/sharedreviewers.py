import pandas as pd
import numpy
from collections import defaultdict
import itertools
import csv
import pickle
import matplotlib.pyplot as plt

BusAcad = pd.io.pickle.read_pickle('/Users/sunandakoduvayur/Documents/Certificate in Data Science/Machine Learning/Yelp Project/BusAcad')
SchoolFood = pickle.load( open( "SchoolFood.p", "rb" ) )
SchoolDict = pickle.load( open( "SchoolDict.p", "rb" ) )
reviewAcad = pd.io.pickle.read_pickle('/Users/sunandakoduvayur/Documents/Certificate in Data Science/Machine Learning/Yelp Project/reviewAcad')
del SchoolDict['University of Wisconsin - Madison']
#Create a dictionary whose keys are school names and whose values are lists that contain number of 5,4,3,2, and 1 star ratings
schoolStars = defaultdict(dict)
indexlist = [5,4,3,2,1]
for school in SchoolDict:
    for index in indexlist:
        schoolStars[school][index] = 0

for school in SchoolDict:
    for business in SchoolDict[school]['busID']:
        df = reviewAcad[reviewAcad.busID == business][['busID','stars']]
        for index in df.stars.value_counts().keys():
            schoolStars[school][index] = schoolStars[school][index] + df.stars.value_counts()[index] # assigns the number of reviews with a star rating 'index' to the dictionary in schoolStars[school] with the corresponding key and value

schoolStarsDF = pd.DataFrame.from_dict(schoolStars,orient ='index')
schoolStarsDF.reset_index(level=0,inplace=True)
schoolStarsDF.columns=['SchoolName','1star','2star','3star','4star','5star']
schoolStarsDF['sRCount'] = schoolStarsDF['aveBRCount'] = schoolStarsDF['aveBStars'] = 0.0
for school in SchoolDict:
    for i in range(schoolStarsDF.shape[0]):
        if schoolStarsDF.SchoolName[i] == school:
            schoolStarsDF['sRCount'][i] = SchoolDict[school].reviewCount.sum()
            schoolStarsDF['aveBRCount'][i] = float(SchoolDict[school].reviewCount.sum())/(SchoolDict[school]['busID'].nunique())
            schoolStarsDF['aveBStars'][i] = SchoolDict[school]['stars'].sum()/(SchoolDict[school]['busID'].nunique())
#plt.clf()
#f, axarr = plt.subplots(6,5)

#axarr[0,0].bar([1,2,3,4,5], schoolStarsDF['Brown University']['stars'])
#axarr[0,0].set_title('Brown')
#axarr[0,0].set_ylabel('Stars')
#axarr[0,1].scatter(SchoolFood['California Institute of Technology']['reviewCount'], SchoolFood['California Institute of Technology']['stars'])
#axarr[0,1].set_title('CalTech')
#axarr[0,2].scatter(SchoolFood['California Polytechnic State University']['reviewCount'], SchoolFood['California Polytechnic State University']['stars'])
#axarr[0,2].set_title('CPSU')
#axarr[0,3].scatter(SchoolFood['Carnegie Mellon University']['reviewCount'], SchoolFood['Carnegie Mellon University']['stars'])
#axarr[0,3].set_title('Carnegie')
#axarr[0,4].scatter(SchoolFood['Columbia University']['reviewCount'], SchoolFood['Columbia University']['stars'])
#axarr[0,4].set_title('Columbia')
#axarr[1,0].scatter(SchoolFood['Cornell University']['reviewCount'], SchoolFood['Cornell University']['stars'])
#axarr[1,0].set_title('Cornell')
#axarr[1,1].scatter(SchoolFood['Georgia Institute of Technology']['reviewCount'], SchoolFood['Georgia Institute of Technology']['stars'])
#axarr[1,1].set_title('GaTech')
#axarr[1,2].scatter(SchoolFood['Harvard University']['reviewCount'], SchoolFood['Harvard University']['stars'])
#axarr[1,2].set_title('Harvard')
#axarr[1,3].scatter(SchoolFood['Harvey Mudd College']['reviewCount'], SchoolFood['Harvey Mudd College']['stars'])
#axarr[1,3].set_title('Harvey Mudd')
#axarr[1,4].scatter(SchoolFood['Massachusetts Institute of Technology']['reviewCount'], SchoolFood['Massachusetts Institute of Technology']['stars'])
#axarr[1,4].set_title('MIT')
#axarr[2,0].scatter(SchoolFood['Princeton University']['reviewCount'], SchoolFood['Princeton University']['stars'])
#axarr[2,0].set_title('Princeton')
#axarr[2,1].scatter(SchoolFood['Purdue University']['reviewCount'], SchoolFood['Purdue University']['stars'])
#axarr[2,1].set_title('Purdue')
#axarr[2,2].scatter(SchoolFood['Rensselaer Polytechnic Institute']['reviewCount'], SchoolFood['Rensselaer Polytechnic Institute']['stars'])
#axarr[2,2].set_title('RPI')
#axarr[2,3].scatter(SchoolFood['Rice University']['reviewCount'], SchoolFood['Rice University']['stars'])
#axarr[2,3].set_title('Rice')
#axarr[2,4].scatter(SchoolFood['Stanford University']['reviewCount'], SchoolFood['Stanford University']['stars'])
#axarr[2,4].set_title('Stanford')
#axarr[3,0].scatter(SchoolFood['University of California - Los Angeles']['reviewCount'], SchoolFood['University of California - Los Angeles']['stars'])
#axarr[3,0].set_title('UCLA')
#axarr[3,1].scatter(SchoolFood['University of California - San Diego']['reviewCount'], SchoolFood['University of California - San Diego']['stars'])
#axarr[3,1].set_title('UCSD')
#axarr[3,2].scatter(SchoolFood['University of California at Berkeley']['reviewCount'], SchoolFood['University of California at Berkeley']['stars'])
#axarr[3,2].set_title('UCBerkeley')
#axarr[3,3].scatter(SchoolFood['University of Illinois - Urbana-Champaign']['reviewCount'], SchoolFood['University of Illinois - Urbana-Champaign']['stars'])
#axarr[3,3].set_title('UIUC')
#axarr[3,4].scatter(SchoolFood['University of Maryland - College Park']['reviewCount'], SchoolFood['University of Maryland - College Park']['stars'])
#axarr[3,4].set_title('UCMP')
#axarr[4,0].scatter(SchoolFood['University of Massachusetts - Amherst']['reviewCount'], SchoolFood['University of Massachusetts - Amherst']['stars'])
#axarr[4,0].set_title('UMassAmherst')
#axarr[4,1].scatter(SchoolFood['University of Michigan - Ann Arbor']['reviewCount'], SchoolFood['University of Michigan - Ann Arbor']['stars'])
#axarr[4,1].set_title('Ann Arbor')
#axarr[4,2].scatter(SchoolFood['University of North Carolina - Chapel Hill']['reviewCount'], SchoolFood['University of North Carolina - Chapel Hill']['stars'])
#axarr[4,2].set_title('UNC')
#axarr[4,3].scatter(SchoolFood['University of Pennsylvania']['reviewCount'], SchoolFood['University of Pennsylvania']['stars'])
#axarr[4,3].set_title('Upenn')
#axarr[4,4].scatter(SchoolFood['University of Southern California']['reviewCount'], SchoolFood['University of Southern California']['stars'])
#axarr[4,4].set_title('USC')
#axarr[5,0].scatter(SchoolFood['University of Texas - Austin']['reviewCount'], SchoolFood['University of Texas - Austin']['stars'])
#axarr[5,0].set_title('UTAustin')
#axarr[5,1].scatter(SchoolFood['University of Washington']['reviewCount'], SchoolFood['University of Washington']['stars'])
#axarr[5,1].set_title('UWash')
#axarr[5,2].scatter(SchoolFood['University of Waterloo']['reviewCount'], SchoolFood['University of Waterloo']['stars'])
#axarr[5,2].set_title('Waterloo')
#axarr[5,3].scatter(SchoolFood['University of Wisconsin - Madison']['reviewCount'], SchoolFood['University of Wisconsin - Madison']['stars'])
#axarr[5,3].set_title('Wisc-Mad')
#axarr[5,4].scatter(SchoolFood['Virginia Tech']['reviewCount'], SchoolFood['Virginia Tech']['stars'])
#axarr[5,4].set_title('Virginia Tech')

#x = SchoolFood['Brown University']['reviewCount']
#y = SchoolFood['Brown University']['stars']
#temp =0
#for i in range(6):
 #   for j in range(5):
        
        #else:
        #   temp = 0
  #      x = i + j +temp
   #     axarr[i,j].scatter(SchoolFood[schoolsList[x]]['reviewCount'],SchoolFood[schoolsList[x]]['stars'])
    #    axarr[i,j].set_title(schoolCodes[x])
     #   if j==4: 
      #     temp = 4*(i+1)
    #axarr[i,j].set_ylabel('Stars')
#plt.savefig("Figure_Ratingdist2.png")
#plt.show()

#axarr[5,4].set_xlabel('Review Count')
#f.subplots_adjust(hspace=1)
#for i in range(6):
#    for k in range(5):
#        axarr[i,k].set_ylim(0.5,5.5)
#        axarr[i,k].set_xlim(0,500)
#        axarr[i,k].set_yticks([1,3,5])
#        axarr[i,k].set_xticks([100,300,500])
#plt.savefig("Figure_Ratingdist.png")
#plt.show()




MajorCat = ['Active Life','Arts & Entertainment','Arts and Entertainment','Automotive','Beauty & Spas','Beauty and Spas','Education','Event Planning & Services','Event Planning and Services','Financial Services','Food','Health & Medical','Health and Medical','Home Services','Hotels & Travel','Hotels and Travel','Local Flavor','Local Services','Mass Media','Nightlife','Pets','Professional Services','Public Services & Government','Public Services and Government','Real Estate','Religious Organizations','Restaurants','Shopping']      