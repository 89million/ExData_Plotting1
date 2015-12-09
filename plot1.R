# Ensure the individual household electric power consumption data set from UCI is in your working directory
# read just data from the dates 2007-02-01 and 2007-02-02
hpc <- read.csv2("household_power_consumption.txt", skip=66636, nrows=2880,
                 stringsAsFactors = FALSE)

# add variable names
names(hpc) <-  c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                 "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 

# Open a png graphical device, create the plot then shut the device off
png(file = "Plot1.png", height=480, width=480)
hist(as.numeric(hpc$Global_active_power), col='red', xlab="Global Active Power(kilowatts)", ylab = "Frequency",
     main = "Global Active Power")
dev.off()
