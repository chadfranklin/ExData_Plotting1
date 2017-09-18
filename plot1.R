##############
## This script uses data from the "Individual household electric power consumption Data Set” and creates
## a png file of a graph displaying frequency by global active power (kilowats)
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

# Plot
png(file="plot1.png", height=480, width=480)
hist(dfSample$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
