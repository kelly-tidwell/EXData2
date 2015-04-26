NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreNEI<-NEI[NEI$fips=="24510",]

aggregatedBaltimoreNEI<-aggregate(Emissions~year + type,BaltimoreNEI,sum)

library(ggplot2)

g<-ggplot(aggregatedBaltimoreNEI, 
          aes(year, Emissions, color = type)
          )+
    geom_line()+
    xlab("Year")+
    ylab("PM2.5 Emissions")+
    ggtitle("Baltimore City Total Emissions by Year")
dev.copy(png, file="Plot3.png")
dev.off()
