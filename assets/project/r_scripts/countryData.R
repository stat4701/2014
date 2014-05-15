loadCountryData <- function(file) {
  data <- read.csv(file)
  return (data)
}

getMatchedCountries <- function(file, rounds) {
  data <- loadCountryData(file) #load in data from file name passed in
  countries <- subset(data, Round == rounds[1], select=c("Country"))
  countries <- levels(countries$Country)[countries$Country]
  #For each round, subset the data for just that round for each test
  #Get a list of those countries
  #Find the intersection of all of the countries as this gives us the matched countries over all rounds passed in
  for (i in rounds) { 
    pisa_countries <- subset(data, Round == i & Test == "PISA", select=c("Country"))
    timss_countries <- subset(data, Round == i & Test == "TIMSS", select=c("Country"))
    pisa_countries <- levels(pisa_countries$Country)[pisa_countries$Country]
    timss_countries <- levels(timss_countries$Country)[timss_countries$Country]
    both_countries <- intersect(pisa_countries, timss_countries)
    countries <- intersect(both_countries, countries)
  }
  return (countries)
}

generateColumnNames <- function(plot_by, content="all") {
  #Given the content areas (should be figured out programatically), and feature to plot by
  # assemble a list of the metrics we need (which are column names in the data frame)
  all_contents <- c("Num", "Alg", "Geom", "Data")
  appends <- c("", ".M", ".F")
  ret_content = vector()
  if (plot_by == "Gender Content") {
    for (i in appends) {
      ret_content <- c(ret_content, paste("Con.", content, i, ".TIMSS", sep=""))
    }
  }
  else if (plot_by == "Overall Content") {
    for (i in all_contents) {
      ret_content <- c(ret_content, paste("Con.", i, ".TIMSS", sep=""))
    }
  }
  return (ret_content)
}

getContent <- function(file, rounds, subject, countries) {
  #Data "munge" function to get the metrics we need in order to plot
  normed_data <- data.frame() #Create empty dataframe to hold results
  data <- loadCountryData(file) #load in data
  stats <- c("Mean", "Con.Num", "Con.Alg", "Con.Geom", "Con.Data")
  appends <- c("", ".M", ".F")
  for (i in rounds) {
    #For each round, subset the data to get only for this round and for the countries passed in
    matched_data <- subset(data, Round == i & Country %in% countries)
    standard <- standardizeScores(matched_data, subject) #normalize the scores from the subset
    normed_data <- rbind(normed_data, standard) #combine with results dataframe
  }
  return (normed_data)
}

shapeWide <- function(data, subject) {
  #Subset data for the subject passed in and reshape to wide format
  sub_data <- data[data$Subject == subject, ]
  reshaped <- reshape(sub_data, timevar="Test", idvar=c("Country", "Region", "Round", "Subject"), direction="wide")
  return (reshaped)
}

standardizeScores <- function(data, subject) {
  #After subsetting/putting in wide format, normalize all but first 4 columns and return
  reshaped <- shapeWide(data, subject)
  standard <- cbind(reshaped[,c(1:4)], scale(reshaped[, -c(1:4)]))
  return (standard)
}

plotCorrelations <- function(file, rounds, plot_by, subjectx="Math", subjecty="Math", statx="Mean.PISA", staty="Mean.TIMSS") {
  #Plots correlation between subject or statistic, for both male and female or just one
  require(ggplot2)
  countries <- getMatchedCountries(file, rounds)
  #Get data in correct format for both subjects
  normed_x_data <- getContent(file, rounds, subjectx, countries)
  normed_y_data <- getContent(file, rounds, subjecty, countries)
  #Set the name of the x and y metric based on the values passed in
  if (plot_by == "Gender") {
    test_split <- strsplit(statx, "\\.")
    xmetric <- paste(test_split[[1]][1], ".F.", test_split[[1]][2], ".x", sep="")
    ymetric <- paste(test_split[[1]][1], ".M.", test_split[[1]][2], ".y", sep="")
  }
  else {
    xmetric <- paste(statx, ".x", sep="")
    ymetric <- paste(staty, ".y", sep="")
  }
  chart_title <- paste("Correlation of", plot_by, subjectx, statx, "vs", subjecty, staty, "by Round", sep=" ")
  #Merge the two dataframes for x and y data, get the columns we want and name them
  round_df <- merge(normed_x_data, normed_y_data, by=c("Country", "Region", "Round"))
  round_df <- round_df[, c("Country", "Region", "Round", xmetric, ymetric)]
  names(round_df) <- c("Country", "Region", "Round", xmetric, ymetric)
  #Return a series of scatterplots grouped by region, with a regression line for each region
  #Split by round so each plot represents one round
  plt <- ggplot(round_df, aes_string(x=xmetric, y=ymetric, colour="Region", Group="Region")) + labs(title=chart_title)
  plt <- plt + geom_point(shape=19, size=2) + geom_abline(intercept = 0, slope = 1) + stat_smooth(method="lm", se=FALSE) + theme(aspect.ratio=1)
  return(plt + facet_wrap(~ Round, ncol=1))
}

plotAdvantage <- function(file, rounds, plot_by, subject, stat="Mean", test="TIMSS", gender="all") {
  #Plots the advantage (either on a test or by gender) for the statistic passed in
  require(ggplot2)
  countries <- getMatchedCountries(file, rounds)
  normed_data <- getContent(file, rounds, subject, countries) #Get data in needed format
  #Put together the name of the metrics we'll be subtracting to find out the difference between the two
  if (plot_by == "Test") {
    gen = ""
    if (gender != "all") {
      gen = paste(".", gender, sep="")
    }
    adv_val <- paste(stat, gen, ".PISA", sep="")
    other_val <- paste(stat, gen,".TIMSS", sep="")
    adv_metric <- paste("PISA ", gen, sep="")
  }
  else if (plot_by == "Gender") {
    adv_val <- paste(stat, ".M.", test, sep="")
    other_val <- paste(stat, ".F.", test, sep="")
    adv_metric <- paste("Male (", test, ")", sep="")
  }
  #Subset the data for only the columns we want, and add a column for the difference
  country_df <- normed_data[, c("Country", "Round", adv_val, other_val)]
  country_df$Advantage <- country_df[[adv_val]] - country_df[[other_val]]
  chart_title <- paste(adv_metric, "Advantage in", subject, stat, "Score over Time", sep=" ")
  #Return a plot of the difference by round for the metric we're looking at
  plt <- ggplot(country_df, aes(x=Round, y=Advantage, group=Country, colour=Country))
  return (plt + labs(title=chart_title) + geom_line())
}

plotMathContent <- function(file, rounds, plot_by, content="all") {
  #Plots details in the math content domains for TIMSS, either by gender or just overall
  require(ggplot2)
  constant_columns <- c("Country", "Region", "Round") #Columns we will not want to reshape
  countries <- getMatchedCountries(file, rounds)
  normed_data <- getContent(file, rounds, "Math", countries) #Get the data in the format we need
  num_columns = as.integer(sqrt(length(countries))) #The number of columns we want in our plot, keep as square as possible
  #Based on the parameter passed in, get a list of the metrics we want and create a title for the plot
  if (plot_by == "Gender Content") {
    lines <- c("Mean.PISA", "Mean.TIMSS", generateColumnNames(plot_by, content))
    chart_title <- paste("Gender Difference in", content, "domain", sep=" ")
  }
  else {
    lines <- c("Mean.PISA", "Mean.TIMSS", generateColumnNames(plot_by))
    chart_title <- "Country Scores by TIMSS Content Area"
  }
  #Subset data based on metric list found above, then reshape for plotting
  normed_data <- normed_data[, c(constant_columns, lines)]
  normed_data <- reshape(normed_data, varying=lines, v.names="Scaled_Score", times=lines, idvar=constant_columns, direction="long")
  names(normed_data) <- c("Country", "Region", "Round", "Metric_Name", "Scaled_Score")
  #Return a plot with the score for each metric, with one subplot per country
  plt <- ggplot(normed_data, aes(x=Round, y=Scaled_Score, group=Metric_Name, colour=Metric_Name)) + labs(title=chart_title) + geom_line()
  plt <- plt + labs(title=chart_title) + geom_line()
  return (plt + facet_wrap(~ Country, ncol=num_columns))
}

plotSubjects <- function(file, rounds, stat) {
  #Plot the advantage in PISA of each country by subject for the statistic passed in
  require(ggplot2)
  countries <- getMatchedCountries(file, rounds)
  #Get the data in the format we need, then add a column with the subject name
  normed_x_data <- getContent(file, rounds, "Math", countries)
  normed_x_data$Subject <- rep("Math", nrow(normed_x_data))
  normed_y_data <- getContent(file, rounds, "Science", countries)
  normed_y_data$Subject <- rep("Science", nrow(normed_y_data))
  normed_data <- rbind(normed_x_data, normed_y_data)
  #Create a string to hold the metric values we will later subtract to get our differences
  adv_val <- paste(stat,".PISA", sep="")
  other_val <- paste(stat, ".TIMSS", sep="")
  chart_title <- "Math vs Science over Time"
  #Add a column with the difference between the metrics
  normed_data$PISA_Advantage <- normed_data[[adv_val]] - normed_data[[other_val]]
  #Return a plot with the PISA advantage by subject, with subpots for each country
  plt <- ggplot(normed_data, aes(x=Round, y=PISA_Advantage, group=Subject, colour=Subject)) + labs(title=chart_title) + geom_line()
  return (plt + facet_wrap(~ Country, ncol=as.integer(sqrt(length(countries)))))
}