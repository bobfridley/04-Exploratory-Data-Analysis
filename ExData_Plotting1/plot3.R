wd <- getwd()
# setwd("/Users/bobfridley/Documents/git/Exploratory-Data-Analysis/Course Project 1")

packages <- c("data.table", "reshape2", "dplyr")
loadp <- sapply(packages, library, character.only=TRUE, quietly=TRUE,
        warn.conflicts=FALSE, logical.return=TRUE, verbose=FALSE)

if (!all(loadp)) {
        stop("unable to load required packages")
}

dataDirectory <- "./data"
destFile <- "household_power_consumption.zip"
workFile <- "household_power_consumption.txt"
destFilePath <- paste(dataDirectory, destFile, sep = "/")

if (!file.exists(destFilePath)) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile=destFilePath, method="curl", mode="wb")
        unzip(destFilePath, exdir=dataDirectory)
}

print(list.files(dataDirectory, recursive=TRUE))

# function to calculate required memory to read file
required_memory <- function(rows, cols, number_type="numeric", available_memory=4) {
        if(number_type == "integer") {
                byte_per_number = 4
        } else if(number_type == "numeric") {
                byte_per_number = 8
        } else {
                stop(sprintf("Unknown number_type: %s", number_type))
        }
        
        estimate_size_in_bytes <- (rows * cols * byte_per_number)
        # Convert estimate_size_in_bytes to class "object_size"
        # Provides an estimate of the memory allocation
        # attributable to the object in bytes.
        class(estimate_size_in_bytes) <- "object_size"
        print(estimate_size_in_bytes, units="auto")
}

required_memory(2075259, 9, "numeric", 4)

# read data file
dfData <- read.table(file.path(dataDirectory, workFile), skip=66637,
        nrow=2879, sep=";", na.string="?", stringsAsFactors=FALSE, )

# rename columns
setnames(dfData, c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9"),
        c("Date", "Time", "Global_active_power", "Global_reactive_power",
          "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
          "Sub_metering_3"))

# convert Date
dfData$Date <- as.Date(dfData$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(dfData$Date), dfData$Time)
dfData$Datetime <- as.POSIXct(datetime)

# convert data frame to data table
dtData <- data.table(dfData)
rm(dfData)

# remove Date and Time columns
dtData[, Date:=NULL]
dtData[, Time:=NULL]

# rearrange columns
setcolorder(dtData, c("Datetime", "Global_active_power",
                      "Global_reactive_power", "Voltage", "Global_intensity",
                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# open new graphics device
quartz()

# Plot 3
with(dtData, {
        plot(Sub_metering_1~Datetime, type="l",
                ylab="Energy Sub Metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file=file.path(wd, "plot3.png"), height=480, width=480)
dev.off()

setwd(wd)