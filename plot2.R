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
#generate the plot
png(filename = "plot2.png", width = 480, height = 480)
with(powerConsumption, plot(datetime,Global_active_power, type="l",
                            ylab="Global Active Power (kilowatts)",
                            xlab=""))
dev.off()

