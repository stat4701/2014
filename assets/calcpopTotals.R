calcPopTotals <- function(gender="A", name="all") {
  #Calculates the population by state for the given gender and name
  #Defaults return data for all names and both genders
  dc <- getStateData("namesbystate", "DC", gender, name)
  poptotal <- getTotalByYear(dc)
  names(poptotal) <- "DC"
  for (state in state.abb) {
    dt <- getStateData("namesbystate", state, gender, name)
    state_dt <- getTotalByYear(dt)
    names(state_dt) <- state
    poptotal <- cbind(poptotal, state_dt)
  }
  return (poptotal)
}

plotName <- function(gender, name) {
  require(reshape)
  require(ggplot2)
  #If gender is both, we want to graphs the changes in percent by gender over time
  # so we get that data, otherwise we get the data for one name and given gender
  if (gender == "both") {
    name_percent = genderPercents(name)[[1]]
  }
  else {
    name_percent = namePercents(gender, name)
  }
  years <- row.names(name_percent)
  name_percent <- cbind(name_percent, years)
  #Reshape dataframe for plotting
  name_melted <- melt(name_percent, id = "years")
  names(name_melted) <- c("Year", "State", "Value")
  p <- ggplot(name_melted, aes(x=Year, y=Value, group=State, colour=State))
  return (p + geom_line())
}

namePercents <- function(gender, name) {
  #For given name and gender, return a dataframe with the percent by state
  # for that name for each year
  total <- calcPopTotals()
  name_total <- calcPopTotals(gender, name)
  name_percent <- name_total / total
  return (name_percent)
}

genderPercents <- function(name) {
  #For given name, return a dataframe with the percent female of total
  # for that name for each year
  total <- calcPopTotals()
  boy_total <- calcPopTotals("M", name)
  girl_total <- calcPopTotals("F", name)
  name_total <- boy_total + girl_total
  girl_percent <- girl_total / name_total
  total_percent <- name_total / total
  return (list(girl_percent, total_percent))
}

getStateData <- function(directory, state, gender="A", name="all") {
  #For a given state, loop through the rows in the state's file and return
  # the data for the passed in name and gender
  s <- paste(directory,"/",state,".TXT", sep ="")
  data <- read.table(s, sep=",")
  heads <- c("State", "Sex", "Year", "Name", "Frequency")
  names(data) <- heads
  if (name != "all") {
    data <- data[data$Name == name, ]
    data <- data[data$Sex == gender, ]
  }
  return (data)
}

getTotalByYear <- function(pop) {
  #Given a dataframe with row for each year, return dataframe with
  # sum by name and year
  data <- tapply(pop$Frequency, pop$Year, sum)
  all_data <- numeric(0)
  years <- as.character(1910:2012)
  for (i in 1910:2012) {
    if (as.character(i) %in% dimnames(data)[[1]]) {
      all_data <- c(all_data, data[[as.character(i)]])
    }
    else {
      all_data <- c(all_data, 0)
    }
  }
  data <- as.data.frame(all_data, row.names=years)
  return (data)
}
