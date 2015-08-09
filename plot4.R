## read data from file
data <- read.csv("household_power_consumption.txt", sep=";", colClasses = "character")
## get data of two dates
data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"),]
## convert data and remove NA
for (column in 3:dim(data)[2]) {
  data[, column] <- as.numeric(data[, column])
}
data = na.omit(data)

data[,"DateTime"] <- as.POSIXct(strptime(paste(data$Date,data$Time), format="%d/%m/%Y %T"))

## construct plot and save
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

## sub plot 1
plot(data$DateTime,data[,"Global_active_power"],type="n", ann=FALSE)
title(main="", xlab="", ylab="Global Active Power (kilowatts)")
lines(data$DateTime,data[,"Global_active_power"])

## sub plot 2
plot(data$DateTime,data[,"Voltage"],type="n", ann=FALSE)
title(main="", xlab="datetime", ylab="Voltage")
lines(data$DateTime,data[,"Voltage"])

## sub plot 3
plot(data$DateTime,data[,"Sub_metering_1"],type="n",ann=FALSE)
title(main="", xlab="", ylab="Energy sub metering")
lines(data$DateTime,data[,"Sub_metering_1"])
lines(data$DateTime,data[,"Sub_metering_2"],col="red")
lines(data$DateTime,data[,"Sub_metering_3"],col="blue")
legend(x="topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

## sub plot 4
plot(data$DateTime,data[,"Global_reactive_power"],type="n", ann=FALSE)
title(main="", xlab="datetime", ylab="Global_reactive_power")
lines(data$DateTime,data[,"Global_reactive_power"])

dev.off()