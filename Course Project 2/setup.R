## save current working directory
wd <- getwd()
## set working directory for project
setwd("/Users/bobfridley/Documents/Coursera/04 - Exporatory-Data-Analysis/Course-Project-2/R-wd")

## load required libraries
library(RColorBrewer)
library(ggplot2)
library(plyr)
library(tidyr)
library(quantmod)

## directory/file info
data.dir <- "../exdata-data-NEI_data"
data.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
data.file <- "exdata-data-NEI_data.zip"
data.file.nei <- "summarySCC_PM25.rds"
data.file.scc <- "Source_Classification_Code.rds"
data.path.nei <- paste(data.dir, data.file.nei, sep = "/")
data.path.scc <- paste(data.dir, data.file.scc, sep = "/")
data.file.path <- paste(data.dir, data.file, sep = "/")

## check for existance of data directory
if (!file.exists(data.dir)) {
        dir.create(data.dir, mode="0777")
}

## check for existance of uncompressed data files
if (!file.exists(data.path.nei) | !file.exists(data.path.scc)) {
        ## check for existance of compressed data file
        if (!file.exists(data.file.path)) {
                download.file(data.url, destfile=data.file.path,
                        method="curl", mode="wb")
        }

        ## uncompress data file
        unzip(paste(data.dir, data.file, sep = "/"), exdir=data.dir)
}

## check for existance of NEI data.frame object
if (!c("NEI") %in% objects()) {
        NEI <- readRDS(data.path.nei)
}

if (!c("SCC") %in% objects()) {
        SCC <- readRDS(data.path.scc)
}

str(NEI)
## 'data.frame':   6497651 obs. of  6 variables:
##  $ fips     : chr  "09001" "09001" "09001" "09001" ...
##  $ SCC      : chr  "10100401" "10100404" "10100501" "10200401" ...
##  $ Pollutant: chr  "PM25-PRI" "PM25-PRI" "PM25-PRI" "PM25-PRI" ...
##  $ Emissions: num  15.714 234.178 0.128 2.036 0.388 ...
##  $ type     : chr  "POINT" "POINT" "POINT" "POINT" ...
##  $ year     : int  1999 1999 1999 1999 1999 1999 1999 1999 1999 1999 ...

str(SCC)
## 'data.frame':   11717 obs. of  15 variables:
##  $ SCC                : Factor w/ 11717 levels "10100101","10100102",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ Data.Category      : Factor w/ 6 levels "Biogenic","Event",..: 6 6 6 6 6 6 6 6 6 6 ...
##  $ Short.Name         : Factor w/ 11238 levels "","2,4-D Salts and Esters Prod /Process Vents, 2,4-D Recovery: Filtration",..: 3283 3284 3293 3291 3290 3294 3295 3296 3292 3289 ...
##  $ EI.Sector          : Factor w/ 59 levels "Agriculture - Crops & Livestock Dust",..: 18 18 18 18 18 18 18 18 18 18 ...
##  $ Option.Group       : Factor w/ 25 levels "","C/I Kerosene",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Option.Set         : Factor w/ 18 levels "","A","B","B1A",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ SCC.Level.One      : Factor w/ 17 levels "Brick Kilns",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ SCC.Level.Two      : Factor w/ 146 levels "","Agricultural Chemicals Production",..: 32 32 32 32 32 32 32 32 32 32 ...
##  $ SCC.Level.Three    : Factor w/ 1061 levels "","100% Biosolids (e.g., sewage sludge, manure, mixtures of these matls)",..: 88 88 156 156 156 156 156 156 156 156 ...
##  $ SCC.Level.Four     : Factor w/ 6084 levels "","(NH4)2 SO4 Acid Bath System and Evaporator",..: 4455 5583 4466 4458 1341 5246 5584 5983 4461 776 ...
##  $ Map.To             : num  NA NA NA NA NA NA NA NA NA NA ...
##  $ Last.Inventory.Year: int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Created_Date       : Factor w/ 57 levels "","1/27/2000 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Revised_Date       : Factor w/ 44 levels "","1/27/2000 0:00:00",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Usage.Notes        : Factor w/ 21 levels ""," ","includes bleaching towers, washer hoods, filtrate tanks, vacuum pump exhausts",..: 1 1 1 1 1 1 1 1 1 1 ...

## restore saved working directory
setwd(wd)