##############
## This script uses data from the "Individual household electric power consumption Data Set” and creates
## a png file of a graph displaying all three sub meterings by date and time
##############

# Check if dataset exists
zipfilename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.txt"

if (!file.exists(filename)) { 
    
    # File doesn't exists. Check if zip file has been downloaded
    if (!file.exists(zipfilename)){
        fileURL <- paste("https://d396qusza40orc.cloudfront.net/", zipfilename)
        download.file(fileURL, zipfilename, method="curl")
    }
    
    # Extract dataset from zip file
    unzip(zipfilename)
    
} else {
    
    print("File already exists")
    
}

# Load dataset
df <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
dfSample <- df[(df$Date=="1/2/2007" | df$Date=="2/2/2007" ), ]


# Add Date/Time variable
dfSample$Date <- as.Date(dfSample$Date, format="%d/%m/%Y")
dfSample$DateTime <- strptime(paste(dfSample$Date, dfSample$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# Plot
png(file="plot3.png", height=480, width=480)
plot(dfSample$DateTime, dfSample$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering")
lines(dfSample$DateTime, dfSample$Sub_metering_2, col="red")
lines(dfSample$DateTime, dfSample$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()