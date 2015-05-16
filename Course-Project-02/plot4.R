## Question 4
## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

source("setup.R")

## change year to factor
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

## Get emissions from coal combustion-related sources
data.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=T), ]

## Merge NEI and SCC (filtered by coal emissions)
data.merge <- merge(NEI, data.coal, by='SCC')

## Sum coal emissions in merged dataset
emissions.coal <- aggregate(data.merge[, 'Emissions'], by=list(data.merge$year), sum)

## Rename columns for readability
colnames(emissions.coal) <- c('Year', 'Emissions')

## Add column for sum of Emissions
emissions.coal$pm25 <- round(emissions.coal$Emissions/1000, 2)

## set png graphics device options
png(filename='plot4.png', width=480, height=480, units="px")

## create plot
p <- ggplot(data=emissions.coal, aes(Year, pm25)) + 
        geom_line(aes(group=1, col=pm25)) +
        geom_point(aes(size=2, col=pm25)) + 
        ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emissions by Year")) + 
        ylab(expression("Total" ~ PM[2.5] ~ "Coal Emissions (kilotons)")) + 
        geom_text(aes(label=pm25, size=2, hjust=0.5, vjust=1.8)) + 
        theme(legend.position='none') +
        scale_colour_gradient(low='blue', high='red')

## explicitly print plot to png
print(p)

## close graphics device and write plot to file
dev.off()