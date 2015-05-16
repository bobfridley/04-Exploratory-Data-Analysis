## Question 3/Plot 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad,
## nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999–2008 for Baltimore City? Which have seen increases in
## emissions from 1999–2008? Use the ggplot2 plotting system to make
## a plot answer this question.

source("setup.R")

## subset data.frame including all years for Baltimore City, MD
emissions <- subset(NEI, fips=="24510")

## change year to factor
emissions$year <- factor(emissions$year)

## set png graphics device options
png(filename='plot3.png', width=480, height=480, units="px")

## create plot
p <- ggplot(emissions, aes(year, Emissions, fill=type)) +
        geom_bar(position="stack", stat="identity") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (kilotons)")) +
        xlab("Year") +
        ggtitle("Total Baltimore City, MD" ~ PM[2.5] ~ "Emissions by Year")

## explicitly print plot to png
print(p)

## close graphics device and write plot to file
dev.off()