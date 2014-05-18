import pandas as pd
import numpy
from collections import defaultdict
import itertools
import csv
import pickle
import matplotlib.pyplot as plt

BusAcad = pd.io.pickle.read_pickle('/Users/sunandakoduvayur/Documents/Certificate in Data Science/Machine Learning/Yelp Project/BusAcad')
columns = ['busID','busName','stars','reviewCount','categories']
#columbiaDF = pd.DataFrame(index = range(BusAcad.shape[0]), columns = columns)
countColumbia = 0

schoolsList = ['Brown University',
'California Institute of Technology',
'California Polytechnic State University',
'Carnegie Mellon University',
'Columbia University',
'Cornell University',
'Georgia Institute of Technology',
'Harvard University',
'Harvey Mudd College',
'Massachusetts Institute of Technology',
'Princeton University',
'Purdue University',
'Rensselaer Polytechnic Institute',
'Rice University',
'Stanford University',
'University of California - Los Angeles',
'University of California - San Diego',
'University of California at Berkeley',
'University of Illinois - Urbana-Champaign',
'University of Maryland - College Park',
'University of Massachusetts - Amherst',
'University of Michigan - Ann Arbor',
'University of North Carolina - Chapel Hill',
'University of Pennsylvania',
'University of Southern California',
'University of Texas - Austin',
'University of Washington',
'University of Waterloo',
'University of Wisconsin - Madison',
'Virginia Tech']

schoolCodes = ['Brown', 'Caltech','CPSU','CMU','Columbia','Cornell','GaTech','Harvard','Harvey-Mudd','MIT','Princeton','Purdue','RPI','Rice','Stanford','UCLA','UCSD','UC-Berkely','UIUC','UMCP','UMassAmherst', 'AnnArbor', 'UNC', 'UPenn', 'USC', 'UTAustin', 'UWash', 'Waterloo', 'Wisconsin-Madison', 'VTech']
# All businesses near Columbia University
SchoolDict = {}
counts = []
SchoolCount = defaultdict(list)
SchoolFood = {}
for school in schoolsList:
    SchoolDict[school] = pd.DataFrame(index = range(BusAcad.shape[0]), columns = columns)
    SchoolCount[school].append(0)
#SchoolCount = {Brown : 0.0, Caltech : 0.0, CPSU : 0.0, Carnegie : 0.0, Columbia, Cornell, GaTech, Harvard, HM, MIT, Princeton, Purdue, RPI, Rice, UCLA, UCSD, UCBerkeley, UIUC, UMCP, UMass, AnnArbor, UNC, UPenn, USC, UTAustin, UW, Waterloo, UWM, VTech ]
for i in range(BusAcad.shape[0]):
    for school in schoolsList :
        if school in BusAcad['schools'][i]:
            for column in columns : 
                SchoolDict[school][column][SchoolCount[school][0]] = BusAcad[column][i]
            SchoolCount[school][0] += 1

#Drop NaNs from the DF
for school in schoolsList:
    SchoolDict[school] = SchoolDict[school][pd.notnull(SchoolDict[school]['busName'])]
    SchoolCount[school][0] = SchoolDict[school].shape[0] # Assign the number of businesses in each school to first element in SchoolCount[school]
    SchoolFood[school] = pd.DataFrame(index = range(SchoolCount[school][0]), columns = columns)
#columbiaDF = columbiaDF[pd.notnull(columbiaDF['busName'])]

# Get max number of businesses among the schools
#maxBusSchool = max(SchoolCount.iteritems(), key = (lambda key: SchoolCount[key]))
#maxBus = SchoolCount[maxBusSchool]

#create a subset DF for food businesses in schools
for school in schoolsList:
    counter = 0
    for i in range(SchoolDict[school].shape[0]):
        for word in SchoolDict[school]['categories'][i]:
            if (word == 'Restaurants' or word == 'Food'):
                SchoolFood[school].iloc[counter,:] = SchoolDict[school].iloc[i, :] 
                counter = counter + 1
                break

for school in schoolsList:
    SchoolFood[school] = SchoolFood[school][pd.notnull(SchoolFood[school]['busName'])]
    SchoolCount[school].extend([0.0,0.0,0.0,0.0]) # the list corresponding to each 'school' key holds 1. # of businesses(all kinds) 2. # of cafes 3. num. of bars
                                          # 4. frac of cafes 5. frac of bars
pickle.dump(SchoolFood, open("SchoolFood.p", "wb"))
pickle.dump(SchoolDict, open("SchoolDict.p", "wb"))

# count number of coffeeshops/Bars/restaurants
cafesList = ['Coffee & Tea','Tea Rooms','Cafes','Cafeteria']
barsList = ['Bars','Nightlife','Breweries','Beer, Wine & Spirits','Wineries']

#countBars = countRest = countCafes = 0
for school in schoolsList:
    for i in range(SchoolFood[school].shape[0]):
        if any(word in SchoolFood[school]['categories'][i] for word in cafesList):
            SchoolCount[school][1] += 1.0
            SchoolCount[school][3] = SchoolCount[school][1]/SchoolFood[school].shape[0]
        elif any(word in SchoolFood[school]['categories'][i] for word in barsList):
            SchoolCount[school][2] += 1.0
            SchoolCount[school][4] = SchoolCount[school][2]/SchoolFood[school].shape[0]


#SchoolCountDF = pd.DataFrame(index = range(len(SchoolCount)), columns = ['School Name', 'Businesses', 'NumCafes','NumBars','FracCafes','FracBars'])
#rows = []
#for key in SchoolCount:
#    rows.append(key)
#    rows.extend(SchoolCount[key])
headers = ['School Name', 'Total Businesses', 'NumCafes','NumBars','FracCafes','FracBars']

LSchoolCount = SchoolCount.items() # Converting the dictionary to a list of lists like ['Virginia Tech', 500, x,y,z,g]
for i in range(len(LSchoolCount)):
    # keep school name as a separate list with a bigger list containing the numbers, this helps in keeping school names intact when doing itertools
    l2 = [([x] if isinstance(x,str) else x) for x in LSchoolCount[i]]
    # un-nest the lists
    LSchoolCount[i] = list(itertools.chain(*l2))
with open('/Users/sunandakoduvayur/Documents/Certificate in Data Science/Machine Learning/Yelp Project/Schools.csv','w') as f:
    f_csv = csv.writer(f)
    f_csv.writerow(headers)
    f_csv.writerows(LSchoolCount)

plt.clf()
f, axarr = plt.subplots(6,5)

axarr[0,0].scatter(SchoolFood['Brown University']['reviewCount'], SchoolFood['Brown University']['stars'])
axarr[0,0].set_title('Brown')
axarr[0,0].set_ylabel('Stars')
axarr[0,1].scatter(SchoolFood['California Institute of Technology']['reviewCount'], SchoolFood['California Institute of Technology']['stars'])
axarr[0,1].set_title('CalTech')
axarr[0,2].scatter(SchoolFood['California Polytechnic State University']['reviewCount'], SchoolFood['California Polytechnic State University']['stars'])
axarr[0,2].set_title('CPSU')
axarr[0,3].scatter(SchoolFood['Carnegie Mellon University']['reviewCount'], SchoolFood['Carnegie Mellon University']['stars'])
axarr[0,3].set_title('Carnegie')
axarr[0,4].scatter(SchoolFood['Columbia University']['reviewCount'], SchoolFood['Columbia University']['stars'])
axarr[0,4].set_title('Columbia')
axarr[1,0].scatter(SchoolFood['Cornell University']['reviewCount'], SchoolFood['Cornell University']['stars'])
axarr[1,0].set_title('Cornell')
axarr[1,1].scatter(SchoolFood['Georgia Institute of Technology']['reviewCount'], SchoolFood['Georgia Institute of Technology']['stars'])
axarr[1,1].set_title('GaTech')
axarr[1,2].scatter(SchoolFood['Harvard University']['reviewCount'], SchoolFood['Harvard University']['stars'])
axarr[1,2].set_title('Harvard')
axarr[1,3].scatter(SchoolFood['Harvey Mudd College']['reviewCount'], SchoolFood['Harvey Mudd College']['stars'])
axarr[1,3].set_title('Harvey Mudd')
axarr[1,4].scatter(SchoolFood['Massachusetts Institute of Technology']['reviewCount'], SchoolFood['Massachusetts Institute of Technology']['stars'])
axarr[1,4].set_title('MIT')
axarr[2,0].scatter(SchoolFood['Princeton University']['reviewCount'], SchoolFood['Princeton University']['stars'])
axarr[2,0].set_title('Princeton')
axarr[2,1].scatter(SchoolFood['Purdue University']['reviewCount'], SchoolFood['Purdue University']['stars'])
axarr[2,1].set_title('Purdue')
axarr[2,2].scatter(SchoolFood['Rensselaer Polytechnic Institute']['reviewCount'], SchoolFood['Rensselaer Polytechnic Institute']['stars'])
axarr[2,2].set_title('RPI')
axarr[2,3].scatter(SchoolFood['Rice University']['reviewCount'], SchoolFood['Rice University']['stars'])
axarr[2,3].set_title('Rice')
axarr[2,4].scatter(SchoolFood['Stanford University']['reviewCount'], SchoolFood['Stanford University']['stars'])
axarr[2,4].set_title('Stanford')
axarr[3,0].scatter(SchoolFood['University of California - Los Angeles']['reviewCount'], SchoolFood['University of California - Los Angeles']['stars'])
axarr[3,0].set_title('UCLA')
axarr[3,1].scatter(SchoolFood['University of California - San Diego']['reviewCount'], SchoolFood['University of California - San Diego']['stars'])
axarr[3,1].set_title('UCSD')
axarr[3,2].scatter(SchoolFood['University of California at Berkeley']['reviewCount'], SchoolFood['University of California at Berkeley']['stars'])
axarr[3,2].set_title('UCBerkeley')
axarr[3,3].scatter(SchoolFood['University of Illinois - Urbana-Champaign']['reviewCount'], SchoolFood['University of Illinois - Urbana-Champaign']['stars'])
axarr[3,3].set_title('UIUC')
axarr[3,4].scatter(SchoolFood['University of Maryland - College Park']['reviewCount'], SchoolFood['University of Maryland - College Park']['stars'])
axarr[3,4].set_title('UCMP')
axarr[4,0].scatter(SchoolFood['University of Massachusetts - Amherst']['reviewCount'], SchoolFood['University of Massachusetts - Amherst']['stars'])
axarr[4,0].set_title('UMassAmherst')
axarr[4,1].scatter(SchoolFood['University of Michigan - Ann Arbor']['reviewCount'], SchoolFood['University of Michigan - Ann Arbor']['stars'])
axarr[4,1].set_title('Ann Arbor')
axarr[4,2].scatter(SchoolFood['University of North Carolina - Chapel Hill']['reviewCount'], SchoolFood['University of North Carolina - Chapel Hill']['stars'])
axarr[4,2].set_title('UNC')
axarr[4,3].scatter(SchoolFood['University of Pennsylvania']['reviewCount'], SchoolFood['University of Pennsylvania']['stars'])
axarr[4,3].set_title('Upenn')
axarr[4,4].scatter(SchoolFood['University of Southern California']['reviewCount'], SchoolFood['University of Southern California']['stars'])
axarr[4,4].set_title('USC')
axarr[5,0].scatter(SchoolFood['University of Texas - Austin']['reviewCount'], SchoolFood['University of Texas - Austin']['stars'])
axarr[5,0].set_title('UTAustin')
axarr[5,1].scatter(SchoolFood['University of Washington']['reviewCount'], SchoolFood['University of Washington']['stars'])
axarr[5,1].set_title('UWash')
axarr[5,2].scatter(SchoolFood['University of Waterloo']['reviewCount'], SchoolFood['University of Waterloo']['stars'])
axarr[5,2].set_title('Waterloo')
#axarr[5,3].scatter(SchoolFood['University of Wisconsin - Madison']['reviewCount'], SchoolFood['University of Wisconsin - Madison']['stars'])
#axarr[5,3].set_title('Wisc-Mad')
axarr[5,4].scatter(SchoolFood['Virginia Tech']['reviewCount'], SchoolFood['Virginia Tech']['stars'])
axarr[5,4].set_title('Virginia Tech')

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

axarr[5,4].set_xlabel('Review Count')
f.subplots_adjust(hspace=1)
for i in range(6):
    for k in range(5):
        axarr[i,k].set_ylim(0.5,5.5)
        axarr[i,k].set_xlim(0,500)
        axarr[i,k].set_yticks([1,3,5])
        axarr[i,k].set_xticks([100,300,500])
plt.savefig("Figure_Ratingdist.png")
plt.show()
#axarr[0, 3].
#axarr[0, 3].
#axarr[0, 4].
#axarr[0, 4].
#axarr[0, 5].
#axarr[0, 5].
#axarr[1, 0].
#axarr[1, 0].
#axarr[1, 1].
#axarr[1, 1].

#axarr[1, 1].scatter(x, y ** 2)
#axarr[1, 1].set_title('Axis [1,1]')

