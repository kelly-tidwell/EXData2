NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

VSNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, VSNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"

library(ggplot2)

png("plot6.png")
g<-ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g<-g + facet_grid(.~fips)
g<-g + geom_bar(stat="identity")+
    xlab("Year")+
    ylab('Total M2.5 Emissions')+
    ggtitle('Total Emissions from motor vechicles in Baltimore City, MD and Los Angeles, CA')
print(g)
dev.off()
