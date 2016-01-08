getwd()
setwd("C:/Users/Lisa/version-control/ExData_Plotting1")
filename <- "exdata-data-househousehold_Power_Consumption.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
  
}
if(!file.exists("household_power_consumption.txt")) {
  unzip(filename)
}

## Load Data into R
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

##subset data
epc <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(data)

## Date Conversion

datetime <- paste(as.Date(epc$Date), epc$Time)
epc$Datetime <- as.POSIXct(datetime)

epc$Global_active_power <- as.numeric(paste(epc$Global_active_power))
epc$Sub_metering_1 <- as.numeric(paste(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.numeric(paste(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.numeric(paste(epc$Sub_metering_3))

## Plot 3
with(epc, {
  plot(Sub_metering_1~Datetime, type = "l", 
       ylab = "Engergy sub metering", xlab="")
  lines(Sub_metering_2~Datetime, col = "Red")
  lines(Sub_metering_3~Datetime, col = "Blue")
})

legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

## Save into file
dev.copy(png, file = "plot3.png", height=480, width=480)
dev.off()
