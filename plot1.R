### Exploratory Data Analysis
### Week 1 Project
### Plot 1

## Get the data from the web
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,mode="wb")
unzip(temp)

## Load the data set into the workspace
PowerData <- read.table("household_power_consumption.txt",header=TRUE,sep = ";",na.strings = "?")

## Create an aggregated Time Column - Force to POSIXct to enable Dplyr to be used.
PowerData$Time <- as.POSIXct(strptime(paste(PowerData$Date,PowerData$Time),"%d/%m/%Y %H:%M:%S"))

## convert the date column to a real date
PowerData$Date <- as.Date(PowerData$Date,"%d/%m/%Y")

## subset the data to Feb 2007
PowerDataFEB07 <- filter(PowerData,Date>=as.Date("2007-02-01"),Date<=as.Date("2007-02-02"))

## Create the plot and save as png in working directory
png(filename="./plot1.png", width = 480,height = 480, bg="white")
hist(PowerDataFEB07$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
