NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreNEI<-NEI[NEI$fips=="24510",]

aggregatedBaltimoreNEI<-aggregate(Emissions~year,BaltimoreNEI,sum)

barplot(aggregatedBaltimoreNEI$Emissions,
        names.arg=aggregatedBaltimoreNEI$year,
        main="Baltimore City Total Emissions by Year",
        xlab="Year",
        ylab="PM2.5 Emissions",
)
dev.copy(png, file="Plot2.png")
dev.off()
