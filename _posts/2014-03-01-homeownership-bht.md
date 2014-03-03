---
layout: post
title: Graphing U.S. Homeownership
description: An update to a Wikipedia graphic
tags: blogpost1
---

I revised and updated a graph on the Wikipedia article, "Homeownership in the United States."

The old graphic was not deeply flawed, but it seemed like it could be cleaner, more informative, and more up to date.

![The old graph](https://upload.wikimedia.org/wikipedia/commons/5/57/US_Homeownership_Overall_2009.png)

The data were easy to come by and easy to work with. My processing of it involved the following functions, which I use frequently and keep in my general purpose Python utility:

```python
def list2csv(mylist,fn,header=[]):
  import csv

  with open(fn+".csv", 'wb') as f:
    spamWriter = csv.writer(f)
    if len(header) > 0:
      spamWriter.writerow(header)
    for x in mylist:
      spamWriter.writerow(x)

  return fn+".csv"


def csv2list(fn, encoding='utf-8',delim=',',quot='"'):
  import csv

  Blist = []
  with open(fn, "rU") as Bcsv:
    if quot == '"':
      Breader = csv.reader(Bcsv, delimiter=delim)
    else:
      Breader = csv.reader(Bcsv, delimiter=delim,quoting=quot)
    for row in Breader:
      Blist.append(row)
    return Blist
```
I used csv2list to read in the Census data, which was easily sanitized "manually" in Excel. I stored it in my conventional list of lists, 'llist'.

From llist, I made a melted version of the data that broke the quarterly dates into numerical representation:

```python
melt = []
for x in llist:
 for i in range(1,5):
  melt.append(([float(x[0])+(.25*(i-1)),float(x[i])]))
```

It was straightforward to then list2csv the data into a csv and read the CSV in R.

I read this data into a dataframe called `qrt`. I then wanted to add recession bars, so, my first attempt was this:

```R
qrt$reces[with(qrt,Date>1969.5 & Date < 1971)] <- 1
qrt$reces[with(qrt,Date>1973.5 & Date < 1975.5)] <- 1
qrt$reces[with(qrt,Date>1979.9 & Date < 1980.65)] <- 1
qrt$reces[with(qrt,Date>1981.4 & Date < 1983)] <- 1
qrt$reces[with(qrt,Date>1990.4 & Date < 1991.6)] <- 1
qrt$reces[with(qrt,Date>2001.4 & Date < 2002)] <- 1
```

I picked these non-quarterly dates in order to have a 0 and 1 column for my quarterly data marking whether that quarter was a recession.

I couldn't figure out how to graph the bars using only that 0 and 1 column, and following an example from RBloggers, I tried this approach instead:

```R
recessions.df <- read.table(textConnection(
"Peak, Trough
1969.75, 1971
1973.75, 1975.50
1980, 1980.75
1981.5, 1983.00
1990.5, 1991.5
2001.5, 2002.00
2007.75, 2009.75"), sep=',', header=TRUE)
```

This left me with an independent dataframe for recessions data that allowed me to construct geom_rects. 

The final step I was interested in was coloring the recessions bars to encode the change in rate during that recession.

I was able to do so by adding a column to recessions.df that contained the output of this function, applied to each row:

```R
recesDiff <- function(row) {
  sDate <- row[1]
  eDate <- row[2]
  return (qrt$Rate[qrt$Date==eDate] - qrt$Rate[qrt$Date==sDate])
}
```

This function was sucessful because I had 'harmonized' the recession data to a quarterly resolution, allowing it to find a homeownership rate for each start/end point. 

After a good bit of tinkering with ggplot, I was able to make the graph I wanted with this call:

```R
ggplot() + geom_rect(data=recessions.df, aes(xmin = Peak, xmax = Trough, ymin = 60, ymax =Inf,fill=diff),alpha=.2) 
+ theme_bw() + theme(axis.text=element_text(size=13),axis.title=element_text(size=16,face="bold"),plot.title=element_text(size=21,face="bold"),legend.title=element_text(size=14)) 
+ scale_fill_gradient2(name="Change in Homeownership \nRate During Recession") 
+ geom_line(data=qrt,aes(x=Date,y=Rate),size=1.6,color='darkgray') 
+ labs(x="Year",y="Homeownership Rate",title="United States Homeownership Rate") 
+ scale_x_continuous(breaks=seq(1966,2014,4)) + scale_y_continuous(breaks=seq(60,80,1))
```

Resulting in:

![My graph](https://upload.wikimedia.org/wikipedia/commons/d/de/Historic_U.S._Homeownership_Rate%2C_as_of_2014.svg)

The graph is now in the Wikimedia columns and can be seen [under the 'Historical' section of the Homeownership in the United States Wikipedia article!](https://en.wikipedia.org/wiki/Homeownership_in_the_United_States#Historical)

