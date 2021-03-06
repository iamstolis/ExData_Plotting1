# Download and unzip the data file if necessary
if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
    unlink("household_power_consumption.zip")
}

# Load the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings="?")

# Use only the data from the specified days
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

# Merge date and time information into Date column
data$Date <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# The plot itself
plot(data$Date, pmax(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3), type="n", xlab="", ylab="Energy sub-metering")
points(data$Date, data$Sub_metering_1, type="l", col="black")
points(data$Date, data$Sub_metering_2, type="l", col="red")
points(data$Date, data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd="1", cex=0.75, y.intersp=0.5)

# Store the plot into PNG file
dev.copy(png, file ="plot3.png", width=480, height=480)
dev.off();
