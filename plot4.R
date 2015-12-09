# Ensure the individual household electric power consumption data set from UCI is in your working directory

# read just data from the dates 2007-02-01 and 2007-02-02
hpc <- read.csv2("household_power_consumption.txt", skip=66636, nrows=2880,
                 stringsAsFactors = FALSE)
# add variable names
names(hpc) <-  c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                 "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 

# create a new vector with both Date and time of day
hpc$Date_Time <- paste(hpc$Date, hpc$Time)
# Format the Date/Time vector as a POSIXlt object
hpc$Date_Time <- strptime(hpc$Date_Time, "%d/%m/%Y %H:%M:%S")

# reorder data frame cols
hpc <- hpc[c(1:2, 10, 3:9)]
# convert measurement cols to numeric
for (i in 4:10) {
      hpc[,i] <- as.numeric(hpc[,i])
}

# Open a png graphical device, create the plot then shut the device off
png(file = "Plot4.png", height=480, width=480)
par(mfrow=c(2,2)) # set correct parameters, 2 rows and 2 columns of graphs
# add the top left plot
plot(hpc$Date_Time, hpc$Global_active_power, type='l', xlab="", 
     ylab="Global Active Power (kilowatts)")
# add the top right plot
plot(hpc$Date_Time, hpc$Voltage, type='l', xlab="datetime", ylab="Voltage")
# add the bottom left plot
plot(hpc$Date_Time, hpc$Sub_metering_1, col='black', type='l', xlab="", ylab="Energy sub metering")
lines(hpc$Date_Time, hpc$Sub_metering_2, col='red')
lines(hpc$Date_Time, hpc$Sub_metering_3, col='blue')
legend("topright", 40, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), bty='n', lwd=c(1.5, 1.5, 1.5), col=c("black", "red", "blue"), pt.cex=1, cex=0.7)
# add the bottom right plot
plot(hpc$Date_Time, hpc$Global_reactive_power, type='l', xlab="datetime", ylab="Global_reactive_power")
dev.off()

