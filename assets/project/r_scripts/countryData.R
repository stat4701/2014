loadCountryData <- function(file) {
  data <- read.csv(file)
}

getMatchedCountries <- function(file, rounds) {
  data <- loadCountryData(file)
  countries <- subset(data, Round == rounds[1], select=c("Country"))
  countries <- levels(countries$Country)[countries$Country]
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

plotCorrelation <- function(file, rounds, subject, stat1="Mean.PISA", stat2="Mean.TIMSS", ext) {
  require(ggplot2)
  require(gridExtra)
  countries <- getMatchedCountries(file, rounds)
  #Get matched countries for each round
  normed_data <- getContent(file, rounds, subject, countries)
  normed_data <- reshape(normed_data, timevar="Metric_Name", idvar=c("Country", "Round", "Region"), direction="wide")
  plots <- list()
  num_columns = as.integer(sqrt(length(rounds)))
  correlations <- paste("Correlations in ", subject, " between ", stat1, " and ", stat2, " are:", sep="")
  for (i in rounds) {
    chart_title <- paste("Round", i, stat1, "vs", stat2, sep=" ")
    round_df <- normed_data[which(normed_data$Round == i), ]
    xmetric <- paste("Scaled_Score.", stat1, sep="")
    ymetric <- paste("Scaled_Score.", stat2, sep="")
    plt <- ggplot(round_df, aes_string(x=xmetric, y=ymetric, colour="Region"))
    this_plot <- list(plt + labs(title=chart_title) + geom_point(shape=19, size=5) + xlim(-2.5, 2.5) + ylim(-2.5, 2.5) + geom_abline(intercept = 0, slope = 1))
    plots <- c(plots, this_plot)
    correlation <- cor(cbind(round_df[, xmetric], round_df[, ymetric]))[1,2]
    prt_str <- paste("Round", i, "correlation between", stat1, "and", stat2, "is", correlation, sep=" ")
    correlations <- paste(correlations, prt_str, sep="\n")
  }
  plot_name <- createPlotName("cor", rounds, subject, paste(stat1, "_", stat2, sep=""), ext)
  png(plot_name, width=1000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=num_columns)))
  dev.off()
  return (correlations)
}

statRoundCompare <- function(file, round, subject, stat) {
  data <- loadCountryData(file)
  data <- matchedCountryData(data, round)
  shaped <- shapeWide(data, subject)
  standard <- standardizeScores(data, subject)
  agg <- aggMetric(shaped, standard, stat)
}

statMultiRoundCompare <- function(file, rounds, subject, stat) {
  #Gets country list for multiple rounds
  data <- loadCountryData(file)
  countries <- getMatchedCountries(file, rounds)
  #Get matched countries for each round
  normed_data <- list()
  for (i in rounds) {
    matched_data <- subset(data, Round == i & Country %in% countries)
    shaped <- shapeWide(matched_data, subject)
    standard <- standardizeScores(matched_data, subject)
    agg <- aggMetric(shaped, standard, stat)
    agg_list <- list(agg)
    normed_data <- c(normed_data, agg_list)
  }
  return (normed_data)
}

createPlotName <- function(plot_type, rounds, subject, extra, extension) {
  round_string <- "round"
  for (i in rounds) {
    round_string <- paste(round_string, i, sep="")
  }
  name <- paste(plot_type, "_", round_string, "_", subject, "_", extra, ".", extension, sep="")
  return (name)
}

plotMultiRound <- function(file, rounds, subject, stat, ext) {
  library(ggplot2)
  chart_title <- paste("Test Differential for", subject, stat, "in Scaled Scores by Country over Time", sep=" ")
  graph_df <- getMultiRound(file, rounds, subject, stat)
  plt <- ggplot(graph_df, aes(x=Round, y=PISA_Advantage, group=Country_List, colour=Country_List))
  plt + labs(title=chart_title) + geom_line()
  plot_name <- createPlotName("multi", rounds, subject, stat, ext)
  ggsave(plot_name)
}

getGenderData <- function(file, rounds, subject="Math", country) {
  #TODO fix subject
  #TODO gender and science (not contents)
  data <- loadCountryData(file)
  countries <- getMatchedCountries(file, rounds)
  normed_data <- data.frame()
  stats <- c("Num", "Alg", "Geom", "Data")
  for (i in rounds) {
    matched_data <- subset(data, Round == i & Country %in% countries)
    #shaped <- shapeWide(matched_data, subject)
    standard <- standardizeScores(matched_data, subject)
    agg <- aggContent(standard, "Mean.PISA")
    Statistic <- rep("All", nrow(agg))
    agg <- cbind.data.frame(agg, Statistic)
    agg_timss <- aggContent(standard, "Mean.TIMSS")
    Statistic <- rep("All", nrow(agg_timss))
    agg_timss <- cbind.data.frame(agg_timss, Statistic)
    agg <- rbind.data.frame(agg, agg_timss)
    for (j in stats) {
      agg_content <- data.frame()
      col_name <- paste("Con.", j, ".TIMSS", sep="")
      #print(head(standard,1))
      agg_content <- rbind.data.frame(agg_content, aggContent(standard, col_name))
      col_name <- paste("Con.", j, ".M.TIMSS", sep="")
      agg_content <- rbind.data.frame(agg_content, aggContent(standard, col_name))
      col_name <- paste("Con.", j, ".F.TIMSS", sep="")
      agg_content <- rbind.data.frame(agg_content, aggContent(standard, col_name))
      Statistic <- rep(j, nrow(agg_content))
      agg <- rbind.data.frame(agg, cbind.data.frame(agg_content, Statistic))
    }
    Round <- rep(i, nrow(agg))
    agg <- cbind(agg, Round)
    #agg_list <- list(agg)
    normed_data <- rbind.data.frame(normed_data, agg)
  }
  return (normed_data)
}

plotGenderTest <- function(file, rounds, subject, test, stat, ext) {
  require(ggplot2)
  require(gridExtra)
  countries <- getMatchedCountries(file, rounds)
  #Get matched countries for each round
  normed_data <- getContent(file, rounds, subject, countries)
  normed_data <- reshape(normed_data, timevar="Metric_Name", idvar=c("Country", "Round", "Region"), direction="wide")
  plots <- list()
  #TODO fix num_columns
  num_columns = as.integer(sqrt(length(rounds)))
  for (i in rounds) {
    #TODO add axis labels
    chart_title <- paste("Round", i, "M vs F", subject, stat, "in", test, sep=" ")
    xmetric <- paste("Scaled_Score.", stat, ".M.", test, sep="")
    ymetric <- paste("Scaled_Score.", stat, ".F.", test, sep="")
    round_df <- normed_data[which(normed_data$Round == i), ]
    round_df <- cbind.data.frame(round_df$Country, round_df$Region, round_df[,xmetric], round_df[,ymetric])
    names(round_df) <- c("Country", "Region", "Male", "Female")
    plt <- ggplot(round_df, aes(x=Male, y=Female, colour=Region))
    this_plot <- list(plt + labs(title=chart_title) + geom_point(shape=19, size=5) + xlim(-2.5, 2.5) + ylim(-2.5, 2.5) + geom_abline(intercept = 0, slope = 1))
    plots <- c(plots, this_plot)
  }
  plot_name <- createPlotName("gender_cor", rounds, paste(subject, stat, sep="_"), test, ext)
  png(plot_name, width=1000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=num_columns)))
  dev.off()
}

plotGenderDifference <- function(file, rounds, subject, test, stat, ext) {
  require(ggplot2)
  countries <- getMatchedCountries(file, rounds)
  #Get matched countries for each round
  normed_data <- getContent(file, rounds, subject, countries)
  normed_data <- reshape(normed_data, timevar="Metric_Name", idvar=c("Country", "Region", "Round"), direction="wide")
  male <- paste("Scaled_Score.", stat, ".M.", test, sep="")
  female <- paste("Scaled_Score.", stat, ".F.", test, sep="")
  country_df <- subset(normed_data, normed_data$Country %in% countries, select=c("Country", "Round", male, female))
  Male_Advantage <- country_df[[male]] - country_df[[female]]
  chart_title <- paste("Gender Difference in", test, subject, stat, "Score over Time", sep=" ")
  country_df <- cbind.data.frame(country_df, Male_Advantage)
  plt <- ggplot(country_df, aes(x=Round, y=Male_Advantage, group=Country, colour=Country))
  plt + labs(title=chart_title) + geom_line()
  plot_name <- createPlotName("gender_diff", rounds, paste(subject, stat, sep="_"), test, ext)
  ggsave(plot_name, width=8, height=5, units="in")
}

plotGender <- function(file, rounds, subject="Math", country, ext) {
  require(ggplot2)
  require(gridExtra)
  stats <- c("Num", "Alg", "Geom", "Data")
  normed_data <- getGenderData(file, rounds, subject)
  plots <- list()
  for (i in stats) {
    chart_title <- paste(country, i, "Content", sep = " ")
    #print(i)
    country_df <- normed_data[which(normed_data$Country == country & (normed_data$Statistic == "All" | normed_data$Statistic == i)), ]
    #print(head(country_df,1))
    plt <- ggplot(country_df, aes(x=Round, y=Scaled_Score, group=Metric_Name, colour=Metric_Name))
    this_plot <- list(plt + labs(title=chart_title) + geom_line())
    plots <- c(plots, this_plot)
  }
  plot_name <- createPlotName("gender_content", rounds, subject, country, ext)
  png(plot_name, width=3000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=2)))
  dev.off()
}

plotGenderSubjects <- function(file, rounds, subject="Math", stat, ext) {
  require(ggplot2)
  require(gridExtra)
  countries <- getMatchedCountries(file, rounds)
  normed_data <- getGenderData(file, rounds, subject)
  num_columns = as.integer(sqrt(length(countries)))
  plots <- list()
  for (i in countries) {
    chart_title <- paste(i, stat, "Content", sep = " ")
    #print(i)
    country_df <- normed_data[which(normed_data$Country == i & (normed_data$Statistic == "All" | normed_data$Statistic == stat)), ]
    #print(head(country_df,1))
    plt <- ggplot(country_df, aes(x=Round, y=Scaled_Score, group=Metric_Name, colour=Metric_Name))
    this_plot <- list(plt + labs(title=chart_title) + geom_line() + ylim(-2.5, 2.5))
    plots <- c(plots, this_plot)
  }
  plot_name <- createPlotName("gender_subject", rounds, subject, stat, ext)
  png(plot_name, width=3000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=num_columns)))
  dev.off()
}

getContent <- function(file, rounds, subject, countries) {
  normed_data <- data.frame()
  data <- loadCountryData(file)
  stats <- c("Mean", "Con.Num", "Con.Alg", "Con.Geom", "Con.Data")
  appends <- c("", ".M", ".F")
  for (i in rounds) {
    matched_data <- subset(data, Round == i & Country %in% countries)
    standard <- standardizeScores(matched_data, subject)
    agg <- aggContent(standard, "Mean.PISA")
    agg <- rbind.data.frame(agg, aggContent(standard, "Mean.M.PISA"))
    agg <- rbind.data.frame(agg, aggContent(standard, "Mean.F.PISA"))
    agg <- rbind.data.frame(agg, aggContent(standard, "StDev.PISA"))
    agg <- rbind.data.frame(agg, aggContent(standard, "StDev.TIMSS"))
    for (j in stats) {
      for (k in appends) {
        stat_name <- paste(j, k, ".TIMSS", sep="")
        agg <- rbind.data.frame(agg, aggContent(standard, stat_name))
      }
    }
    Round <- rep(i, nrow(agg))
    agg <- cbind(agg, Round)
    normed_data <- rbind.data.frame(normed_data, agg)
  }
  return (normed_data)
}

plotSubjectCorrelation <- function(file, rounds, stat1="Mean.PISA", stat2="Mean.TIMSS", ext) {
  require(ggplot2)
  require(gridExtra)
  countries <- getMatchedCountries(file, rounds)
  #Get matched countries for each round
  normed_math_data <- getContent(file, rounds, "Math", countries)
  normed_math_data <- reshape(normed_math_data, timevar="Metric_Name", idvar=c("Country", "Round", "Region"), direction="wide")
  normed_science_data <- getContent(file, rounds, "Science", countries)
  normed_science_data <- reshape(normed_science_data, timevar="Metric_Name", idvar=c("Country", "Round", "Region"), direction="wide")
  plots <- list()
  #TODO fix num_columns
  num_columns = as.integer(sqrt(length(rounds)))
  correlations <- paste("Correlations between Math ", stat1, " and Science ", stat2, " are:", sep="")
  for (i in rounds) {
    #TODO add axis labels
    chart_title <- paste("Round", i, stat1, "vs", stat2, sep=" ")
    xmetric <- paste("Scaled_Score.", stat1, sep="")
    ymetric <- paste("Scaled_Score.", stat2, sep="")
    round_math_df <- normed_math_data[which(normed_math_data$Round == i), ]
    round_science_df <- normed_science_data[which(normed_science_data$Round == i), ]
    round_df <- cbind.data.frame(round_math_df$Country, round_math_df$Region, round_math_df[,xmetric], round_science_df[,ymetric])
    names(round_df) <- c("Country", "Region", "Math", "Science")
    plt <- ggplot(round_df, aes(x=Math, y=Science, colour=Region))
    this_plot <- list(plt + labs(title=chart_title) + geom_point(shape=19, size=5) + xlim(-2.5, 2.5) + ylim(-2.5, 2.5) + geom_abline(intercept = 0, slope = 1))
    plots <- c(plots, this_plot)
    correlation <- cor(cbind(round_df$Math, round_df$Science))[1,2]
    prt_str <- paste("Round", i, "correlation between", stat1, "and", stat2, "is", correlation, sep=" ")
    correlations <- paste(correlations, prt_str, sep="\n")
  }
  plot_name <- createPlotName("subject_cor", rounds, stat1, stat2, ext)
  png(plot_name, width=1000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=num_columns)))
  dev.off()
  return (correlations)
}

plotContent <- function(file, rounds, subject="Math", ext) {
  require(ggplot2)
  require(gridExtra)
  #TODO add meas and fix vector
  #TODO fix subject
  countries <- getMatchedCountries(file, rounds)
  #Get matched countries for each round
  normed_data <- getContent(file, rounds, subject, countries)
  content_list <- c("Mean.PISA", "Mean.TIMSS")
  if (subject == "Math") {
    content_list <- c(content_list, "Con.Num.TIMSS", "Con.Alg.TIMSS", "Con.Geom.TIMSS", "Con.Data.TIMSS")
  }
  plots <- list()
  num_columns = as.integer(sqrt(length(countries)))
  for (i in countries) {
    chart_title <- paste(i, "Content", sep = " ")
    country_df <- normed_data[which(normed_data$Country == i & normed_data$Metric_Name %in% content_list), ]
    plt <- ggplot(country_df, aes(x=Round, y=Scaled_Score, group=Metric_Name, colour=Metric_Name))
    this_plot <- list(plt + labs(title=chart_title) + geom_line() + ylim(-2.5, 2.5))
    plots <- c(plots, this_plot)
  }
  plot_name <- createPlotName("content", rounds, subject, "by_country", ext)
  png(plot_name, width=3000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=num_columns)))
  dev.off()
}

aggContent <- function(norm_data, stat) {
  #col_name <- paste(stat, ".", test, sep="")
  agg_data <- cbind.data.frame(levels(norm_data$Country)[norm_data$Country], norm_data$Region, norm_data[[stat]])
  metric <- rep(stat, nrow(agg_data))
  agg_data <- cbind.data.frame(agg_data, metric)
  names(agg_data) <- c("Country", "Region", "Scaled_Score", "Metric_Name")
  return (agg_data)
}

plotSubjects <- function(file, rounds, stat, country="all", ext) {
  #TODO same axis for all plots
  #TODO remove legend, fix up chart titles
  require(ggplot2)
  require(gridExtra)
  math_df <- getMultiRound(file, rounds, "Math", stat)
  science_df <- getMultiRound(file, rounds, "Science", stat)
  Subject <- rep("Math", nrow(math_df))
  math_df <- cbind.data.frame(math_df, Subject)
  Subject <- rep("Science", nrow(science_df))
  science_df <- cbind.data.frame(science_df, Subject)
  subject_df <- rbind.data.frame(math_df, science_df)
  plots <- list()
  if (country == "all") {
    countries <- getMatchedCountries(file, rounds)
    for (i in countries) {
      chart_title <- paste(i, "Math vs Science over Time", sep = " ")
      country_df <- subject_df[which(subject_df$Country_List == i), ]
      plt <- ggplot(country_df, aes(x=Round, y=PISA_Advantage, group=Subject, colour=Subject))
      this_plot <- list(plt + labs(title=chart_title) + geom_line())
      plots <- c(plots, this_plot)
    }
    num_columns = as.integer(sqrt(length(countries)))
  }
  else {
    chart_title <- paste(country, "Math vs Science over Time", sep = " ")
    country_df <- subject_df[which(subject_df$Country_List == country), ]
    plt <- ggplot(country_df, aes(x=Round, y=PISA_Advantage, group=Subject, colour=Subject))
    this_plot <- list(plt + labs(title=chart_title) + geom_line())
    plots <- c(plots, this_plot)
    num_columns = 1
  }
  plot_name <- createPlotName("subjects", rounds, stat, country, ext)
  png(plot_name, width=3000, height=2000, units="px")
  do.call(grid.arrange, c(plots, list(ncol=num_columns)))
  dev.off()
}

getMultiRound <- function(file, rounds, subject, stat) {
  data_list <- statMultiRoundCompare(file, rounds, subject, stat)
  #Initialize variables
  Round <- vector()
  PISA_Advantage <- vector()
  Country_List <- vector()
  count <- 1
  for (i in rounds) {
    round_data <- data_list[[count]]
    Round <- c(Round, rep(rounds[count], nrow(round_data)))
    PISA_Advantage <- c(PISA_Advantage, as.numeric(levels(round_data[,4])[round_data[,4]]) - as.numeric(levels(round_data[,6])[round_data[,6]]))
    Country_List <- c(Country_List, levels(round_data$Country)[round_data$Country])
    count <- count + 1
  }
  graph_df <- cbind.data.frame(Round, PISA_Advantage, Country_List)
}

aggMetric <- function(data, norm_data, stat) {
  pisa <- paste(stat, ".PISA", sep="")
  timss <- paste(stat, ".TIMSS", sep="")
  agg_data <- as.data.frame(cbind(levels(data$Country)[data$Country], levels(data$Region)[data$Region], data[[pisa]], norm_data[[pisa]], data[[timss]], norm_data[[timss]]))
  names(agg_data) <- c("Country", "Region", pisa, "PISA normed", timss, "TIMSS normed")
  return (agg_data)
}

shapeWide <- function(data, subject) {
  sub_data <- data[data$Subject == subject, ]
  reshaped <- reshape(sub_data, timevar="Test", idvar=c("Country", "Region", "Round", "Subject"), direction="wide")
}

standardizeScores <- function(data, subject) {
  reshaped <- shapeWide(data, subject)
  #print (head(reshaped, 1))
  standard <- cbind(reshaped[,c(1:4)], scale(reshaped[, -c(1:4)]))
}

matchedCountryData <- function(data, round) {
  #given round, return vectors with those countries
  pisa <- subset(data, Round == round & Test == "PISA", select = "Country")
  pisa_countries <- levels(pisa$Country)[pisa$Country]
  timss <- subset(data, Round == round & Test == "TIMSS", select = "Country")
  timss_countries <- levels(timss$Country)[timss$Country]
  matches <- intersect(pisa_countries, timss_countries)
  matched_data <- subset(data, Round == round & Country %in% matches)
}