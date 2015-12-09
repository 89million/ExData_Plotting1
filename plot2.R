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
png(file = "Plot2.png", height=480, width=480)
plot(hpc$Date_Time, hpc$Global_active_power, type='l', xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()

