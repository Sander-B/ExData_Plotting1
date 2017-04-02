###########################
# Download the .zip file. #
###########################

message("Downloading .zip file...")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exploratory-data-analysis-assignment1.zip")
dateDownloaded <- base::date()  # base to make sure we don't conflict with lubridate

################################
# Read out the relevant files. #
################################

message("Reading out individual .zip files...")

# read out household_power_consumption.txt.  This contains speaking names for all computed values.
power_consumption<-read.csv(unz("./exploratory-data-analysis-assignment1.zip", "household_power_consumption.txt"), sep=";", na.strings = "?")

###########################
# Get the relevant subset #
###########################

message("Extracting relevant dates...")

# Convert all dates to R-compatible dates
power_consumption$Date = as.Date(power_consumption$Date, "%d/%m/%Y")

# Extract the subset of 1 and 2 February 2007
pc_subset <- subset(power_consumption, Date==as.Date("1/2/2007", "%d/%m/%Y") | Date==as.Date("2/2/2007", "%d/%m/%Y"))

# Generate datetime by combining date and time. 
datetime <- strptime(paste(pc_subset$Date, pc_subset$Time), format="%Y-%m-%d %H:%M:%S")

##################
# Plot the graph #
##################

message("Plotting graph...")

# Open the png. Defaults of 480x480 pixels are OK. 
png("plot4.png")

# Set image frames. 
par(mfrow=c(2,2))

# plot the first graph. Note: weekdays in Dutch (do/vr/za = thu/fri/sat)
plot(datetime, pc_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power") 

# plot the second graph. Note: weekdays in Dutch (do/vr/za = thu/fri/sat)
plot(datetime, pc_subset$Voltage, type="l", xlab="datetime", ylab="Voltage") 

# plot the third graph outline. Note: weekdays in Dutch (do/vr/za = thu/fri/sat)
plot(datetime, pc_subset$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering") 

# plot the third graph individual sets. 
points(datetime, pc_subset$Sub_metering_1, type="l", col="black")
points(datetime, pc_subset$Sub_metering_2, type="l", col="red")
points(datetime, pc_subset$Sub_metering_3, type="l", col="blue")

# plot the third graph legend. Note: weekdays in Dutch (do/vr/za = thu/fri/sat)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")

# plot the fourth graph.
plot(datetime, pc_subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") 

# close the .png file. 
dev.off()