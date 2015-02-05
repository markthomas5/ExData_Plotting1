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

#plots a histogram of global active power
hist(dat$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="Red", ylim=range(0,1200))

#writes out the file
dev.off()