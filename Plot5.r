NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

BaltimoreMotorNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

aggregatedByYear<- aggregate(Emissions~year, BaltimoreMotorNEI, sum)

library(ggplot2)

png("plot5.png")
g<-ggplot(aggregatedByYear, aes(factor(year), Emissions))
g<-g + geom_bar(stat="identity")+
    xlab("Year")+
    ylab('Total M2.5 Emissions')+
    ggtitle('Total Emissions from on road motor vechicles in Baltimore City')
print(g)
dev.off()
