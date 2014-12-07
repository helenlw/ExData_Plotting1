
Plot1 <- function(){

# Remove existing download file and text file if they already exist

if(file.exists("./DownLoad.zip")){
  file.remove("./DownLoad.zip")
}

if(file.exists("./household_power_consumption.txt")){
  file.remove("./household_power_consumption.txt")
}

# Download and unzip

fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "DownLoad.zip"
download.file(fileURL, destFile, method = "curl")
unzip("DownLoad.zip")

# Read in data and subset required days

PowerData <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

PowerDataSS <- PowerData[as.Date(PowerData$Date, "%d/%m/%Y") >= as.Date("01/02/2007","%d/%m/%Y") & as.Date(PowerData$Date, "%d/%m/%Y") <= as.Date("02/02/2007", "%d/%m/%Y"),]

# Create numeric fields and date time field
                         
PowerDataSS$Global_active_power <- as.numeric(as.character(PowerDataSS$Global_active_power))
PowerDataSS$Sub_metering_1 <- as.numeric(as.character(PowerDataSS$Sub_metering_1))
PowerDataSS$Sub_metering_2 <- as.numeric(as.character(PowerDataSS$Sub_metering_2))
PowerDataSS$Sub_metering_3 <- as.numeric(as.character(PowerDataSS$Sub_metering_3))
PowerDataSS$Voltage <- as.numeric(as.character(PowerDataSS$Voltage))
PowerDataSS$Global_reactive_power <- as.numeric(as.character(PowerDataSS$Global_reactive_power))
PowerDataSS$DateTime <- strptime(paste(PowerDataSS$Date, PowerDataSS$Time, sep = " "), format="%d/%m/%Y %H:%M:%S")

# Create plot

margins <- c(0.5,0.5,0.5,0.5)

# plot 1

png('plot1.png',width = 480, height = 480, units = "px", pointsize = 12)
hist(PowerDataSS$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

# Return Dataset


PowerDataSS


}