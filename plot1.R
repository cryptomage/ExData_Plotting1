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
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
with(data, hist(Global_active_power, col = "red", 
                main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)", 
                breaks = 12, ylim = c(0, 1200)))
dev.off()