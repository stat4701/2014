## Code reference 
## http://www.inside-r.org/howto/mining-twitter-airline-consumer-sentiment

library(twitteR)
library(ROAuth)
library(plyr)
library(stringr)
library(ggplot2)

setwd("C:/Users/mandeep/Desktop/ms4826")

## Twitter Authentication
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL = "https://api.twitter.com/oauth/access_token"
authURL = "https://api.twitter.com/oauth/authorize"
consumerKey = "XXXXXXXXXXXXXX"
consumerSecret = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
Cred <- OAuthFactory$new(consumerKey=consumerKey,
                         consumerSecret=consumerSecret,
                         requestURL=requestURL,
                         accessURL=accessURL, 
                         authURL=authURL)
Cred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl") )

save(Cred, file="twitter authentication.Rdata")
registerTwitterOAuth(Cred)

## Save certificate

load("twitter authentication.Rdata")
registerTwitterOAuth(Cred)

# Get only small subset of data
comp1.list <- searchTwitter('#Oracle', n=1000, cainfo="cacert.pem")  
comp1.df = twListToDF(comp1.list)  
write.csv(comp1.df, file='comp1.csv', row.names=F)

comp2.list <- searchTwitter('#IBM', n=1000, cainfo="cacert.pem")  
comp2.df = twListToDF(comp2.list)  
write.csv(comp2.df, file='comp2.csv', row.names=F)

comp3.list <- searchTwitter('#SAP', n=1000, cainfo="cacert.pem")  
comp3.df = twListToDF(comp3.list)  
write.csv(comp3.df, file='comp3.csv', row.names=F)

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')  
{  
  
  scores = laply(sentences, function(sentence, pos.words, neg.words) {  
    
    # clean up sentences 
    
    sentence = gsub('[[:punct:]]', '', sentence)  
    
    sentence = gsub('[[:cntrl:]]', '', sentence)  
    
    sentence = gsub('\\d+', '', sentence)  
    
    # and convert to lower case:  
    
    sentence = tolower(sentence)  
    
    # split into words. str_split is in the stringr package  
    
    word.list = str_split(sentence, '\\s+')  
    
    words = unlist(word.list)  
    
    # compare our words to the dictionaries of positive & negative terms  
    
    pos.matches = match(words, pos.words)  
    neg.matches = match(words, neg.words)  
    
    pos.matches = !is.na(pos.matches)  
    
    neg.matches = !is.na(neg.matches)  
    
    score = sum(pos.matches) - sum(neg.matches)  
    
    return(score)  
    
  }, pos.words, neg.words, .progress=.progress )  
  scores.df = data.frame(score=scores, text=sentences)  
  return(scores.df)  
} 
# The words array used to score sentiment
#Load sentiment word lists
hu.liu.pos = scan('C:/Users/mandeep/Desktop/ms4826/positive-words.txt', what='character', comment.char=';')
hu.liu.neg = scan('C:/Users/mandeep/Desktop/ms4826/negative-words.txt', what='character', comment.char=';')

pos.words = c(hu.liu.pos,'fast','speed','amazing')
neg.words = c(hu.liu.neg,'slow', 'wait','waiting', 'fail', 'disappointed')

#Import 3 csv
DatasetComp1 <- read.csv("comp1.csv")
DatasetComp1$text<-as.factor(DatasetComp1$text)

DatasetComp2 <- read.csv("comp2.csv")
DatasetComp2$text<-as.factor(DatasetComp2$text)

DatasetComp3 <- read.csv("comp3.csv")
DatasetComp3$text<-as.factor(DatasetComp3$text)

#Score all tweets 
Comp1.scores = score.sentiment(DatasetComp1$text, pos.words,neg.words, .progress='text')
Comp2.scores = score.sentiment(DatasetComp2$text, pos.words,neg.words, .progress='text')
Comp3.scores = score.sentiment(DatasetComp3$text, pos.words,neg.words, .progress='text')

Comp1.scores$Company = 'Oracle'
Comp2.scores$Company= 'IBM'
Comp3.scores$Company = 'SAP'

# Visualizing data
hist(Comp1.scores$score)
qplot(Comp1.scores$score)

hist(Comp2.scores$score)
qplot(Comp2.scores$score)

hist(Comp3.scores$score)
qplot(Comp3.scores$score)

all.scores = rbind(Comp1.scores, Comp2.scores, Comp3.scores)
ggplot(data=all.scores) + 
  geom_bar(mapping=aes(x=score, fill=Company), binwidth=1) +
  facet_grid(Company~.) + 
  theme_bw() + scale_fill_brewer() 

