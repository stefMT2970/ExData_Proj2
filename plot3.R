# coursera 04 Exploratory Data Analysis
# Project 2 assignment
# plot 3

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

# prepare data for Baltimore city
PM25byYear <- NEI %>%
              filter(fips=="24510") %>%
              select(Emissions, year, type) %>%
              group_by(year, type) %>%
              summarise_each(funs = "sum")

# plot data

png("plot3.png", width=640, height=480)

par(mfrow = c(1, 1))
qplot(year, Emissions, data = PM25byYear,
      color = type,
      geom=c("line"),
      size = I(1.1),
      main = expression('Total PM'[2.5]*' emissions per year and type, Baltimore city'),
      ylab = expression('PM'[2.5]*' emission'),
) 

dev.off()