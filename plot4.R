library(sqldf)
#load data
f <- file("../exdata-data-household_power_consumption/household_power_consumption.txt")
attr(f, "file.format") <- list(sep = ";", header=TRUE)
#restrict to Feb 1-2, 2007
powerConsumption <- sqldf("SELECT * from f where Date='1/2/2007' or Date='2/2/2007'")
#create a unified datetime field
powerConsumption$datetime <- strptime(paste(powerConsumption$Date, powerConsumption$Time, sep=" "),
                                      "%e/%m/%Y %H:%M:%S")
close(f)

#plot four plots in a 2x2 grid
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(powerConsumption, {
  plot(datetime, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(datetime, Voltage, type="l")
  plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(datetime,Sub_metering_2, col="red")
  lines(datetime,Sub_metering_3, col="blue")
  legend("topright", lty="solid", col=c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  plot(datetime, Global_reactive_power, type="l")
})

dev.off()