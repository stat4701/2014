#EDAV Blog post 3
#Clustering actor names
#Written by Devin Jones

#I had the datasets in memory



library(ggplot2)
library(sqldf)

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


#given a column name, creates columns for all subsets of column
get_uniques <- function(x){
  names_all<- x
  names_all <- paste(names_all,collapse = ", ")
  names_df <- data.frame(strsplit(names_all,", "))
  names(names_df) <- "names"
  unique_names <- unique(names_df$names)
  return(unique_names)
}

title_genre_actors <- movies_imdb[,c("Title","Genre","Actors")]
df <- merge(title_genre_actors, movies_imdb_prod, by = "Title")

columnname = "Actors"
#small_df <- df[,c("Title",columnname,"worldwide_raw",
#                  "earnings_ratio","Release.Date")]
unique_actors <- get_uniques(title_genre_actors$Actors) 
unique_actors <- data.frame(unique_actors)
colnames(unique_actors) <- "unique_l"

unique_df <- data.frame(unique_actors)

combo_df <- sqldf(paste("
                      SELECT * from
                      unique_df
                      join df on ",
                      columnname,
                      " like
                      ('%' || unique_l ||'%');
                      ", sep = ""), drv = "SQLite")

unique_genres <- get_uniques(movies_imdb$Genre)
unique_genres <- data.frame(unique_genres)
unique_genres <- unique_genres[unique_genres$unique_genres != 'Sci-Fi',]

genres_sql <- " "
for (i in 1:length(unique_genres)){
  genres_sql <- paste(genres_sql, " ,sum(" , unique_genres[i] ,") sum_",unique_genres[i], sep="")
}

actor_agg <- sqldf(paste("
                SELECT DISTINCT unique_l
                   ,avg(budget_raw) budget_avg
                   ,avg(earnings_ratio) er_avg
                   ", genres_sql,
                  " from combo_df
                  group by unique_l;
                   ",sep = ""),drv = "SQLite")

actor_cluster_data <- actor_agg
actor_cluster_data$unique_l <- NULL

#toggle these to explore:
actor_cluster_data$budget_avg <- log10(actor_cluster_data$budget_avg)
actor_cluster_data$er_avg <- log10(actor_cluster_data$er_avg)
#actor_cluster_data$budget_avg <- NULL
#actor_cluster_data$er_avg <- NULL


actor_clusters <- kmeans(actor_cluster_data, 10)
actor_agg <- cbind(actor_agg, actor_clusters$cluster)
colnames(actor_agg)[ncol(actor_agg)] <- "cluster"

actor_cluster_plot <- ggplot(actor_agg, aes(x=budget_avg, y=er_avg)) + 
  geom_point(colour = actor_agg$cluster)+
  scale_x_log10() +
  scale_y_log10() +
  ggtitle("Actors Clustered by Budget, Movie Earnings Ratio and Genre")+
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank())

cluster_plot<- function(actor_agg,genre){
  chart_title <- paste(genre," Actors",sep = "")
  actor_cluster_plot <- ggplot(actor_agg, aes(x=budget_avg, y=er_avg)) + 
      geom_point(colour = actor_agg$cluster)+
      scale_x_log10() +
      scale_y_log10() +
      ggtitle(chart_title)+
      theme(axis.line = element_line(colour = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank())
}



Q <- vector(mode="list", length=length(unique_genres))

for(i in 1:length(unique_genres)){
  temp_genre <- unique_genres[i]
  temp_data<-subset(actor_agg,actor_agg[[i+3]] > 0,)
  Q[[i]] <- cluster_plot(temp_data,temp_genre)
}


multiplot(Q[[1]],Q[[2]],Q[[3]],Q[[4]],Q[[5]],Q[[6]],Q[[7]],Q[[8]],Q[[9]],Q[[10]],Q[[11]],Q[[12]], cols=4)
summary(actor_agg)


