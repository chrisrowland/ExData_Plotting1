### Exploratory Data Analysis
### Week 1 Project
### Plot 4

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
png(filename="./plot4.png", width = 480,height = 480, bg="white")
par(mfrow=c(2,2)) # Set up a 2 by 2 grid, adding to row wise
with(PowerDataFEB07,{
  plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power")
  plot(Time,Voltage,type="l",xlab="datetime")
  plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering") #Blank
    points(Time,Sub_metering_1,type="l",col="black") #add series
    points(Time,Sub_metering_2,type="l",col="red") #add series
    points(Time,Sub_metering_3,type="l",col="blue") #add series
    legend("topright",lty=1,cex=0.5,col=c("black","blue","red"),legend=c("Energy sub metering 1","Energy sub metering 2","Energy sub metering 3"))
  plot(Time,Global_reactive_power,type="l",xlab="datetime")
})
dev.off()
