---
layout: default
title: Introduction - Assignment 0
description: Who am I / Playing with city data
---

I'm an ex-social scientist who now works on understanding built environment data. I work mostly in Python and MySQL, though I use some PHP and JavaScript when I have to make things that have users.

I mentioned in class an interest in seeing the rankings with information about how many 'neighboring' cities in the top 20 there were for each city. I took a stab at it, with mild success. I learned a lot about Pandas in trying to do this, though, and had my first struggles with matplotlib. 

I wanted to share one line from my scraper fix, which I think is a more Pythonic approach to list concatenation: 
```{python}
[dict for dictlist in llist for dict in dictlist] #llist is my own idiom for 'list of lists'
```

In my neighbor-analysis attempt, I found a page of Lat/Long data for North Americna cities, and managed to scrape it interactively:
```
page = urllib2.urlopen('http://www.infoplease.com/ipa/A0001796.html')
soup = BeautifulSoup(page)
table_list = soup.findAll('table')
dataplus = table_list[0].find('table')
trs = dataplus.findAll('tr')
trs[2].get_text()
trs[2].get_text().split('\n')
trs[2].get_text().replace(",",'').split('\n')
splitlist = [x.get_text().replace(",",'').split('\n') for x in trs]
import pandas as pd
splitdict = {li[1]:pd.Series(li[2:6]) for li in splitlist}
mydf = pd.DataFrame(splitdict)
mydf.index
#nothing returned 
mydf.index = ['Lat min','Lat sec','Long min','Long sec']
#this is actually mislabeled and is degrees and minutes, not minutes and seconds, but I didn't realize for a while
dfLatLong = copy.deepcopy(mydf)  #clearer name for later, do a deepcopy in case I make some other variable called mydf
//dfLatLong = lat long DataFrame, 131 entries with 
// dfLatLong['Albany N.Y.']
//Lat min     42
//Lat sec     40
//Long min    73
//Long sec    45
//Name: Albany N.Y., dtype: object
#the list of cities I got Lat/Long for does not match the city rankings list (either in cities included or in spelling) so this will be a problem
>>> import pickle #I was running another session with the citydata csv
>>> pkl_file = open('cityset.pkl','rb') #in there I made a set of all city names and pickled it
>>> cityset = pickle.load(pkl_file) #now I load it into this session
>>> citylist = [x for x in cityset]
#so now we have a list of the city names as they appear in the population rankings data, citylist
```

I've punted on the list matching a little bit
a better solution would probably be easier if you use Google Maps API to get distances based on API convenient name searching/calculations
I did a match inspired by MySQL 'WHERE latlongname like CONCAT(left(citylistname,5), "%")'. Using the names from dfLatLong, lat5list contains the first 5 chars of each key to the latlong data:
```
>>> lat5list[5]
{u'Austin Tex.': u'Austi'}
```
I'll match with the value and return the key
```
matches = {}
for x in citylist:
    n5 = x[0:5] #trim the string you're searching
	templist = []
	for opt in lat5list:
	 if n5 in opt.values():
	  templist.append(opt.keys()) #return anything with a matching first 5 chars
	matches[x]=templist #the dict will accept anything from citylist and return a key to the dfLatLong
```
So now matches is a dict of citypop names to dfLatLong names. I matched both portlands and had to edit the match: {'Portland, ME': [u'Portland Maine']} 
 
Next, I make a DataFrame with columns that are city-specific series with entries in years when that city was in the top 20
```
for x in llist:
	dfCityTimeTriple[x[2]][x[0]] = [float(x[1]),float(x[3])]
```
Then I make some functions to handle the distance calculations necessary for this 'neighbors' analysis.
Since I have tuples of degrees and minutes for Lat/Long, I need to essentially put this on a sphere and then find arc distance and multiply by the radius of the Earth.
First convert to radians:
```
def degmintorad(deg,min):
 deg = float(deg)
 min = float(min)
 R = (pi/180) * (deg + min/60)
 return R
```

Another function, tuptoRad(datatuple) accepts a (deg,min) tuple and then calls demintorad, just wrapping all the functions so everything's easy to call.

```
from math import *

#the Haversine formula is used to calculate lat/long distances; I pulled this implementation (mostly) from StackOverflow:
def haversine(lontup1, lattup1,lontup2,lattup2):
    lon1, lat1, lon2, lat2 = map(tuptoRad, [lontup1, lattup1,lontup2,lattup2])
    # haversine formula 
    dlon = lon2 - lon1 
    dlat = lat2 - lat1 
    a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
    c = 2 * asin(sqrt(a)) 
    km = 6367 * c
    return km
``` 

I'm going to want a matrix of distances from city to city. Here's the concept:
distmat: get matrix of distances
for each city, we will fill in the column of distances to the city on each row
keys will be the citylist with citypop version
the objects inside 'matches' are totally unreasonable (you have to do matches['Philadelphia'][0][0]) because I constructed it by appending keys() and not individual keys
for each key:
 distmat[key][otherkey] = haversine(appropriate, lat, long, tuples)

First, here's a function that looks up the matching name and gets lat/long tuples:
```
def tryLocTup(citylistname):
	try:
		latkey = matches[citylistname][0][0]
		lattup = (dfLatLong[latkey][0],dfLatLong[latkey][1])
		lontup = (dfLatLong[latkey][2],dfLatLong[latkey][3])
		return (lattup,lontup)
	except:
		return (None,None)
```
I then made a function to fill the distance matrix, which I made with rows and columns derived from my list of citypop citynames; I put down numpy's not-a-number where appropriate so that I can use mathematical functions on the DataFrame.
```
def fillDistMat(distmat):
	for A in distmat.columns:
		(Alat,Alon) = tryLocTup(A)
		if not Alat:
			markNAN = 1
		else:
			markNAN = 0
		for B in distmat.columns:
			if markNAN == 0:
				(Blat,Blon) = tryLocTup(B)
				if not Blat:
					distmat[A][B] = np.nan
					continue
				distmat[A][B] = haversine(Alon,Alat,Blon,Blat)
			if markNAN == 1:
				distmat[A][B] = np.nan
```
Now the question of what we want to do with these distances:
Each year, we already have two figures (when a city is in the top 20): rank, population
 we should compute another number, "number of top-20 neighbors"
 a neighbor is determined by its distance from the city we are writing to (key A)
 the distance is found in distmat
 it is compared against a threshold
 first attempt: 
 the threshold is calculated from the sum of key A's distances across all cities on the list.
 first we should visualize this sum per city graph
 [![Distance sums per City](http://i.imgur.com/k8O2sl9.png)]
 Based on the portion of Miami's total distance that makes up the distance between Miami and Atlanta, I decided to go with .015 times the total distance from this city to other ranking cities for a varying neighbor threshold. These functions take advantage of Numpy/Pandas objects good handling of selecting elements based on conditionals.
```
def showNeighbors(cityname):
	return distmat[cityname][distmat[cityname] < distSumDict[cityname]*.015]

def getNeighborSet(cityname):
	return {x for x in showNeighbors(cityname).index.values}		#make a set instead of a list so that you can check for a city's presense in O(1) time
```
So for each year, we'll want to go through and get all ranking cities. For each city, we'll want to compare their neighborlist to that year's ranking list and store the number of matches as the 'ranking neighbor' count for that city-year pair.
Here's a function to get the list of ranking cities for a given year:
```
def getYearList(year):
	if type(year) is not str:
		year = str(year)
	yearlist = []
	for x in dfCityTimeTriple.columns:
	 if dfCityTimeTriple.loc[year][x]: #this .loc method is a Pandas slicing method, giving me the 'minor axis' slice of the rank/pop dataframe for a given year
	  yearlist.append(x)
	return yearlist
```
Here's a generic function to return the count of matching elements between two lists/sets:
```
def numAinB(A,B):
 k = 0
 for x in A:
  if x in B:
   k = k + 1
 return k
```
To prevent excessive calls to getNeighborSet, we can just store the neighbor sets (dynamic programming?)
```
dictNeighbors = {x:getNeighborSet(x) for x in distmat.columns} #distmat.columns is a citylist
```
Now we can write this into our dataframe that troublingly stores Python lists as elements:
```
def fillNeighborValues(dataframe):
	for year in dataframe.index.values:
		yearRankedList = getYearList(year)
		for city in yearRankedList:
			dataframe[city][year].append(numAinB(dictNeighbors[city],yearRankedList)-1)
```
Since we stored these lists as elements, we need to pull ranks/pops/neighbor counts into separate dataframes.
I ran code that looks like this:
```
for a in dfCityTimeTriple.columns:
	for b in dfCityTimeTriple.index.values:
		try:
			dfCityNei[a][b] = dfCityTimeTriple[a][b][2]
		except:
			continue
```			
Then there was another correction to make to make empty strings into np.NaN and switch ints to floats:
```
for a in dfCityNei.columns:
	for b in dfCityNei.index.values:
		if type(dfCityNei[a][b]) is int:
			dfCityNei[a][b] = float(dfCityNei[a][b])
			continue
		if type(dfCityNei[a][b]) is str:
			dfCityNei[a][b] = np.nan
```
So, with dfCityRank containing ranking and dfCityNei containing neighbor counts, here's a function to plot a city's rankings, sized according to number of ranking neighbors:
```
def plotRankNeiSize(cityname, argColor='b'):
	xvals = [x for x in dfCityRank[cityname].index.values]
	plt.scatter(range(20),dfCityRank[cityname],s=(dfCityNei[cityname]+1)*50,label=cityname, color='k', alpha=.7, facecolor=argColor)
	plt.plot(range(20),dfCityRank[cityname])
	plt.ylim(20,0) 							#flips the y axis to have 0 at the top
	plt.xticks(range(0,20,3),[xvals[i] for i in range(0,20,3)])
	start = 0
	for val in dfCityRank[cityname]:		#I'd like to put the name of the city on the first node where it appears
		if val is np.nan:					#I do this by finding the index of the first non-nan value
			start = start + 1 				#note that I'm a bad student and am doing linear search!
		else:
			break							#break in case it started out with a value and then dropped off the rankings
	plt.text(start,dfCityRank[cityname][start],cityname)
	ax = plt.gca()							#gca is 'get current axis'
	box = ax.get_position()
	ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])
	ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
```
This graph is most interesting if you plot several cities, so this fxn accepts a list of cities and plots each in a different color before creating the display:
```
def plotMultRankNei(citynamelist):
	colorlist = ['b','g','r','c','m','y']		#some colors to iterate through
	n = len(citynamelist)				
	if n > 6:
		return "Try 6 or fewer cities"
	for i in range(n):
		plotRankNeiSize(citynamelist[i],argColor=colorlist[i])
	plt.show()
```
Here's an example output; you can see a little bit of the 'rising rank, rising neighbor count' effect, but the distance-based scaling threshold didn't really come out very fair — East Coast cities are just so much closer to eachother than cities from the rest of the country. 
[![Rankings sized by Neighbor Count](http://i.imgur.com/ewIXFZB.png)](http://i.imgur.com/ewIXFZB.png)
You can also see some of the troubles I had with matplotlib — why is only one city in the legend? 
