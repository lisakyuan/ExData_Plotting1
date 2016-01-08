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

##Convert Ffactor Date to Numeric Data for Plotting.
epc$Global_active_power <- as.numeric(paste(epc$Global_active_power))
epc$Sub_metering_1 <- as.numeric(paste(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.numeric(paste(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.numeric(paste(epc$Sub_metering_3))
epc$Global_reactive_power <- as.numeric(paste(epc$Global_reactive_power))
epc$Voltage <- as.numeric(paste(epc$Voltage))

## Plot 4
par(mfrow = c(2, 2), mar=c(4, 4, 2, 1), omc=c(0, 0, 2, 0))

with(epc, 
     {
  plot(Global_active_power~Datetime, type="l", 
       ylab = "Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type = "l", 
       ylab = "Vottage", xlab = "")
  plot(Sub_metering_1~Datetime, type = "l", 
            ylab = "Engergy sub metering", xlab="")
       lines(Sub_metering_2~Datetime, col = "Red")
       lines(Sub_metering_3~Datetime, col = "Blue")
      legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, bty = "n",
         legend=c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab = "Global_reactive_power", xlab="")
})

## Save into file
dev.copy(png, file = "plot4.png", height=480, width=480)
dev.off()
