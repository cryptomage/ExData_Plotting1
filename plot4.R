library("data.table", lib.loc="~/R/win-library/3.4")

setwd("~/exploratory-data-analysis")

data <- fread(input = "household_power_consumption.txt", 
              header = TRUE, 
              sep = ";", na = "?")

# subset data
data <- data[(Date == "1/2/2007" | Date == "2/2/2007"), ]

# convert time and date fields
DateTime <- strptime(paste(data$Date, data$Time), 
                     format="%d/%m/%Y %H:%M:%S")
# bind datetime column to data
data <- cbind(data, DateTime)

# plot
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

with(data, plot(data$DateTime, Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)"))
with(data, lines(DateTime, Global_active_power, col = "black"))

with(data, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(data, lines(DateTime, Voltage, col = "black"))

with(data, plot(DateTime, Sub_metering_1, type = "l", 
     col = "black", xlab = "", ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_1, col = "black"))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", bty = "n", 
       col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

with(data, plot(DateTime, Global_reactive_power, type = "l", 
     col = "black", xlab = "datetime", ylab = colnames(data)[3]))
with(data, lines(DateTime, Global_reactive_power, col = "black"))
dev.off()