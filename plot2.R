# load household_power_comsuption.txt
data <- read.table(file="household_power_consumption.txt", sep=";", skip=66637,nrows=2880, 
                   col.names = colnames(read.table(file="household_power_consumption.txt", nrow=1, header=TRUE, sep=";")))

# filter 
data[, 3:9] <- apply(data[, 3:9], 2, function(x) as.numeric(x))

# format dates
dates <- data$Date
dates <- gsub("1/2/2007", "01/02/2007", dates)
dates <- gsub("2/2/2007", "02/02/2007", dates)
times <- data$Time
x <- paste(dates, times)
data$DateTime <- strptime(x, format="%d/%m/%Y %H:%M:%S")

# define png file
png(file="plot2.png", width=480, height=480, units="px")

# create graphic 
plot(data[, c(10, 3)], type="l", xlab="", ylab="Global Active Power (kilowatts)")

# close png file
dev.off()