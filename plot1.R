library(sqldf)
# load data
f <- file("../exdata-data-household_power_consumption/household_power_consumption.txt")
attr(f, "file.format") <- list(sep = ";", header=TRUE)
# Restrict to Feb 1-2, 2007
powerConsumption <- sqldf("SELECT * from f where Date='1/2/2007' or Date='2/2/2007'")
close(f)

# plot the histogram
png(filename="plot1.png", width = 480, height = 480)
hist(powerConsumption$Global_active_power, col="red",
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
