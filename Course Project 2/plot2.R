## Question 2/Plot 2
## Have total emissions from PM_2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

source("setup.R")

## subset data.frame including all years for
## Baltimore City, MD [fips == "24510"]
emissions <- subset(NEI, select=c(Emissions, year), fips=="24510")

## summarize emisions by year
emissions.pm25 <- tapply(emissions$Emissions, emissions$year, sum)

## set png graphics device options
png(filename='plot2.png', width=480, height=480, units="px")

## save default margins
savemar <- par("mar")
## set plot margins
## bottom/left/top/right
par(mar=c(5.1, 5.9, 4.1, 2.1))

## create plot
plot(names(emissions.pm25),
     emissions.pm25,
     type="l",
     xlab="Year",
     ylab=expression("Total" ~ PM[2.5] ~ "Emissions (kilotons)"),
     main=expression("Total Baltimore City, MD" ~ PM[2.5] ~ "Emissions by Year"),
     col="Blue")

## close graphics device and write plot to file
dev.off()

## restore default margins
## set plot margins
par(mar=savemar)