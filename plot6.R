# coursera 04 Exploratory Data Analysis
# Project 2 assignment
# plot 6

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
# the question is about motor vehicles, but no clear definition is
# provided. Check following URL for a legal defintion :
# http://www.law.cornell.edu/cfr/text/40/85.1703
# a simple option is to go for type==ON-ROAD directly in NEI.
# also filter on Baltimore and Los Angeles

PM25byYear <- NEI %>%
              filter(type=="ON-ROAD" & fips %in% c("24510", "06037")) %>%
              select(Emissions, fips, year) %>%
              group_by(fips, year) %>%
              summarise_each(funs = "sum")
              
PM25byYear$county <-factor(PM25byYear$fips, labels=c('Los Angeles', 'Baltimore'))

# plot data

png("plot6.png", width=640, height=480)

par(mfrow = c(1, 1))
qplot(year, Emissions, data = PM25byYear,
      geom=c("line"),
      color = county,
      size = I(1),
      main = expression('Total PM'[2.5]*' emissions per year for motor vehicles'),
      ylab = expression('PM'[2.5]*' emission'),
) + geom_point(size=4)

dev.off()