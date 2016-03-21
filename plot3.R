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
png(file="plot3.png", width=480, height=480, units="px")

# create graphic 
png(file="plot3.png", width=480, height=480, units="px")
with(data, { op <- par(cex=.64)
             plot(data[, c(10,7)], type="l", col="black", ylim=range(data[,7:9]), ylab="", xlab="")
             par(new = TRUE)
             plot(data[, c(10,8)], type="l", col="red", ylim=range(data[,7:9]), ylab="", xlab="")
             par(new = TRUE)
             plot(data[, c(10,9)], type="l", col="blue", ylim=range(data[,7:9]), ylab="", xlab="")
             title(ylab="Energy sub metering", xlab="")
             legend("topright", legend=colnames(data)[7:9], lty=1, col=c("black", "red", "blue"), 
                    text.font=2)
             par(op)})

# close png file
dev.off()