require(RCurl)
require(XML)
require(plyr)

library(ggplot2)


mps.doc<-htmlParse("http://www.peakbagger.com/pbgeog/histmetropop.aspx")
mps.tabs<-readHTMLTable(mps.doc, 
                        header=c("Rank", "Metro Area", "Pop")
                        )

file=file.create("C:/Users/Zhe.Xing/Documents/datavisizalation/edav-1/projects/darrenxing/citypop.csv")


header=data.frame("year","rank","city","pop")

write.table(header, 
            file="C:/Users/Zhe.Xing/Documents/datavisizalation/edav-1/projects/darrenxing/citypop.csv",
            append=TRUE,
            quote=FALSE,
            row.names=FALSE,
            col.name=FALSE,
            sep=",",
            qmethod=c("escape", "double")
)

for (i in 1:length(mps.tabs))
{
  if( nrow(mps.tabs[[i]])==22 )
  {
    a=subset(mps.tabs[[i]], V1!="Rank")
    #print(a)
    b=a[1, ]["V1"]
    #print(b)
    c=subset(a, V2!="<NA>")
   
    c["Year"]<-b

    #print(c)
    #d=c[, "V1"]
   
    
    c["Rank"]<-gsub("[.]", "", c[, "V1"])
    
    c["City"]<-gsub("[,]", "", c[, "V2"])
    # print(c)
    #c["V1"]<-NULL
    c=c[, c(4, 5, 6, 3)]
    #print(c)
    # names(c)[names(c)=="V2"]<-"City"
    names(c)[names(c)=="V3"]<-"Pop"
    
    
    write.table(c, 
                file="C:/Users/Zhe.Xing/Documents/datavisizalation/edav-1/projects/darrenxing/citypop.csv",
                append=TRUE,
                quote=FALSE,
                row.names=FALSE,
                col.name=FALSE,
                sep=",",
                qmethod=c("escape", "double")
                )
    
  }
}

d=read.csv(file="C:/Users/Zhe.Xing/Documents/datavisizalation/edav-1/projects/darrenxing/citypop.csv", header=TRUE)

e=ddply(d, ~year, summarize, "Population Total in 1000"=sum(pop))

plot(e, type='l')
title(main="US Top 20 Cities Total Population")



