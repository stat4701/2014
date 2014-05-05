source("countryData.R")

#Sample plot 1
plotCorrelation("country_data_3.csv", c(1,2,3), "Math", "Mean.PISA", "Mean.TIMSS", "png")

#Sample plot 2
plotMultiRound("country_data_3.csv", c(1,2,3), "Science", "Mean", "png")

#Sample plot 3
plotContent("country_data_3.csv", c(1,2,3), "Math", "png")

#Sample plot 4
plotGender("country_data_3.csv", c(1,2,3), "Math", "Norway", "png")