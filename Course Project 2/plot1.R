## Question 1/Plot 1
## Have total emissions from PM2.5 decreased in the United States from 1999
## to 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source("setup.R")

## subset data.frame including years 1999, 2002, 2005, 2008
emissions <- subset(NEI, select=c(Emissions, year),
        year %in% c(1999, 2002, 2005, 2008))

## summarize emisions by year
emissions.pm25 <- aggregate(emissions$Emissions,
        by=list(emissions$year), FUN=sum)

## rename columns for readability
colnames(emissions.pm25) <- c("year", "emissions")

## add column of emissions converted to kilotons
emissions.pm25$pm25 <- round(emissions.pm25$emissions/1000, 2)

## set color palette for bars
mypalette <- brewer.pal(8, "Dark2")

## set png graphics device options
png(filename='plot1.png', width=480, height=480, units="px")

## save default margins
savemar <- par("mar")
## set plot margins
par(mar=c(5.1, 6.5, 4.1, 2.1))

## create barplot
barplot(emissions.pm25$pm25,
        names.arg=emissions.pm25$year,
        main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"),
        xlab="Year",
        ylab=expression("Total" ~ PM[2.5] ~ "Emissions (kilotons)"),
        col=mypalette)

## close graphics device and write plot to file
dev.off()

## restore default margins
## set plot margins
par(mar=savemar)