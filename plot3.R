#following code reads the file
#skip and nrows allow selection of only the relevent data
#the header is lost when skip is used, therefore loaded separately
filename <- "household_power_consumption.txt"
header <- read.table(filename, header=TRUE, sep=";", nrows=1)
dat <- read.table(filename, sep=";", skip=66637, nrows=2880)
colnames(dat) <- colnames(header)

#following code pastes together the date and time columns and reassigns this to a time using strptime
dat$Time <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")

#followind code replaces the original date and time columns with the new one
dat <- dat[,2:length(colnames(dat))]

#opens the png device
png(file="plot1.png", width=480, height=480)

#plots Submetering 1 to 3 over time
plot(dat$Time, dat$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(dat$Time, dat$Sub_metering_2, type="l", col="Red")
points(dat$Time, dat$Sub_metering_3, type="l", col="Blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("Black", "Red", "Blue"),lty=1)

#writes out the file
dev.off()