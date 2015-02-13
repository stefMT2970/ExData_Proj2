# coursera 04 Exploratory Data Analysis
# Project 2 assignment
# plot 1

# set a working directory to your taste
# download from the web, unzip
library(ggplot2)
library(lattice)
library(dplyr)
oldwd <- getwd()
setwd("d:/dev/app/R/04_ExData")
dir()
if(!file.exists("exdata-data-NEI_data.zip")) {
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url = file_url, destfile = "exdata-data-NEI_data.zip")
  unzip("./exdata-data-NEI_data.zip")
}

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# prepare data
PM25byYear <- NEI %>%
              select(Emissions, year) %>%
              group_by(year) %>%
              summarise_each(funs = "sum")

# plot data
# nice version (for the show)
par(mfrow = c(1, 1))
qplot(year, Emissions, data = PM25byYear,
      geom=c("point", "smooth"),
      method = ("lm"),
      main = expression('Total PM'[2.5]*' emissions per year trend'),
      ylab = expression('PM'[2.5]*' emission'),
) 

# base version
png("plot1.png", width=480, height=480)
 
with( PM25byYear, {
  plot(year, Emissions,
        type = "b",
        col = "red",
        pch = 18,
        main = expression('Total PM'[2.5]*' emissions per year trend'),
        ylab = expression('PM'[2.5]*' emission')
        ) 
})

dev.off()