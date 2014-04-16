---
title: Mandeep's Blog Post 2
description: Sentiment Analysis for Oracle, IBM and SAP using Twitter data
tags: blogpost
---

The intent behind this blog post is to learn how to do sentiment analysis on companies based on Twitter data.

[Source: Sample Example](http://www.inside-r.org/howto/mining-twitter-airline-consumer-sentiment) 

Here's a breakdown of what I did for this blog post:

1\. I learned the different steps involved in making API calls and collected the data in separate .csv file for comparable entities.

This step was easy given the sample examples online on how to setup Twitter developer keys and I was able to retrieve data using APIs both in python and R. Eventually, I did all my work in R as I wanted to visualize data in R as well.
This is how you setup the connection to Twitter:
```{r chunkLabel}
Cred <- OAuthFactory$new(consumerKey=consumerKey,
                         consumerSecret=consumerSecret,
                         requestURL=requestURL,
                         accessURL=accessURL, 
                         authURL=authURL)
Cred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl") )
save(Cred, file="twitter authentication.Rdata")
registerTwitterOAuth(Cred)
```

2\. Call the Twitter function with the hastag and conver the list to a dataframe
```{r chunkLabel}
comp1.list <- searchTwitter('#Oracle', n=1000, cainfo="cacert.pem")  
comp1.df = twListToDF(comp1.list)  
write.csv(comp1.df, file='comp1.csv', row.names=F)
```

3\. Use a list of positive and negative words to calculate a sentiment score on the dataset and use hist function to visualize the histogram
```{r chunkLabel}
Comp1.scores = score.sentiment(DatasetComp1$text, pos.words,neg.words, .progress='text')
hist(Comp1.scores$score)
```

4\. [Source code in R](https://github.com/msingh4674/edav/tree/gh-pages/assets/msingh4674-1/blog p2.R)  Complete source code of the R script.

Use ggplot to compare histogram of sentiment scores for the three companies
```{r chunkLabel}
all.scores = rbind(Comp1.scores, Comp2.scores, Comp3.scores)
ggplot(data=all.scores) + # ggplot works on data.frames, always
  geom_bar(mapping=aes(x=score, fill=Company), binwidth=1) +
  facet_grid(Company~.) + # make a separate plot for each hashtag
  theme_bw() + scale_fill_brewer() # plain display, nicer colors
```

![Plot](https://github.com/msingh4674/edav/tree/gh-pages/assets/msingh4674-1/sentiment comparison.png)

Future Improvements

I really enjoyed the talk by Pablo Barbera and that give me a lot of new ideas for improving this sentiment analysis. 
Some of the new packages and the functionality he showed such as applying logisitc regression and filtering out the noise 
from the tweets will help me to improve the code. 



