## Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in
## motor vehicle emissions?

source("setup.R")

# Baltimore City, Maryland
emissions.md <- subset(NEI, fips=="24510" & type=="ON-ROAD")
# Los Angeles County, California
emissions.ca <- subset(NEI, fips=="06037" & type=="ON-ROAD")

emissions.data.md <- aggregate(emissions.md[, 'Emissions'], by=list(emissions.md$fips, emissions.md$year), sum)
colnames(emissions.data.md) <- c("Location", "year", "emissions")
emissions.data.md$Location[emissions.data.md$Location=="24510"] <- "Baltimore City"

emissions.data.ca <- aggregate(emissions.ca[, 'Emissions'], by=list(emissions.ca$fips, emissions.ca$year), sum)
colnames(emissions.data.ca) <- c("Location", "year", "emissions")
emissions.data.ca$Location[emissions.data.ca$Location=="06037"] <- "Los Angeles County"

emissions.data.ca <- ddply(emissions.data.ca, "Location", transform,  DeltaCol=Delt(emissions))
colnames(emissions.data.ca)[4] <- "pctchg"
emissions.data.md <- ddply(emissions.data.md, "Location", transform,  DeltaCol=Delt(emissions))
colnames(emissions.data.md)[4] <- "pctchg"

emissions.cities <- as.data.frame(rbind(emissions.data.md, emissions.data.ca))
emissions.cities$pctchg <- round(emissions.cities$pctchg*100, 2)
emissions.cities[is.na(emissions.cities)] <- 0

## save default margins
savemar <- par("mar")
## set plot margins
## bottom/left/top/right
par(mar=c(5.1, 6.1, 4.1, 6.1))

## set png graphics device options
png(filename='plot6.png', width=800, height=800, units="px")

## create plot
p <- ggplot(emissions.cities, aes(group=2, y=emissions, x=year, colour=Location)) +
        geom_point() +
        geom_smooth(span=0.5, fill=NA) +
        geom_text(aes(x=year, y=emissions, hjust=0.8, vjust=2.0, label=paste0(pctchg, "%"))) +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (kilotons)")) +
        xlab('Year') +
        ggtitle("Percent Change in Motor Vehicle Emission Levels\nfrom 1999 to 2008 Los Angeles County, CA and Baltimore, MD") +
        facet_grid(. ~ Location, margins=c(5.1, 6.1, 4.1, 6.1)) +
        theme(legend.position="top")

## explicitly print plot to png
print(p)

## close graphics device and write plot to file
dev.off()

## restore default margins
## set plot margins
par(mar=savemar)