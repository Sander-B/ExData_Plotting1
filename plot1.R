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

##################
# Plot the graph #
##################

message("Plotting graph...")

# Open the png. Defaults of 480x480 pixels are OK. 
png("plot1.png")

# plot the histogram. Customizations: red color for bars, custom title, custom x axis label. 
hist(pc_subset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# close the .png file. 
dev.off()