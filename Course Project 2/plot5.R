## Question 5
## How have emissions from motor vehicle sources changed from 1999–2008
## in Baltimore City?

source("setup.R")

## change year to factor
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

## subset data.frame for Baltimore City and motor vehicle sources
emissions.onroad <- subset(NEI, fips=="24510" & type=="ON-ROAD")

## summarize emissions by year
emissions.onroad <- aggregate(emissions.onroad$Emissions,
        by=list(emissions.onroad$year), sum)
## rename columns for readability
colnames(emissions.onroad) <- c("year", "emissions")

## set png graphics device options
png(filename='plot5.png', width=480, height=480, units="px")

## save default margins
savemar <- par("mar")
## set plot margins
## bottom/left/top/right
par(mar=c(5.1, 3.1, 4.1, 3.1))

## create plot
p <- ggplot(data=emissions.onroad, aes(year, emissions)) +
        geom_bar(aes(fill=year), stat="identity") +
        guides(fill=F) + 
        ggtitle("Total Emissions\nfrom Motor Vehicle Sources in Baltimore City, MD") + 
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (kilotons)")) +
        xlab('Year') +
        theme(legend.position='none') + 
        geom_text(aes(label=round(emissions, 2), size=2, hjust=0.5, vjust=2))

## explicitly print plot to png
print(p)

## close graphics device and write plot to file
dev.off()

## restore default margins
## set plot margins
par(mar=savemar)