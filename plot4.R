# coursera 04 Exploratory Data Analysis
# Project 2 assignment
# plot 4

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
# get coal combustion from SCC
# no clear definition, let's go for a selection of words
# 'coal' and 'comb' in the short name of the SCC data frame
coal <- SCC %>%
        filter(grepl('coal', Short.Name, ignore.case=T)) %>%
        filter(grepl('comb', Short.Name, ignore.case=T)) %>%
        select(SCC)

# use this coal set as a filter
PM25byYear <- NEI %>%
              filter(SCC %in% coal$SCC) %>%
              select(Emissions, year) %>%
              group_by(year) %>%
              summarise_each(funs = "sum")

# plot data

png("plot4.png", width=640, height=480)

par(mfrow = c(1, 1))
qplot(year, Emissions, data = PM25byYear,
      geom=c("line"),
      color = I("red"),
      size = I(1),
      ylim = c(0, 600000),
      main = expression('Total PM'[2.5]*' emissions per year from coal combustion'),
      ylab = expression('PM'[2.5]*' emission'),
) + geom_point(size=3)

dev.off()