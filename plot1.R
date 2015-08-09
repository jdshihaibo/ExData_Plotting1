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
png(filename="plot1.png", width=480, height=480)
hist(data[,"Global_active_power"],col="red", ann=FALSE)
title(main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
