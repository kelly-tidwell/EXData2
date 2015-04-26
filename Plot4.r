NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalSCC = SCC[grepl("coal", SCC$Short.Name, ignore.case = TRUE), ]

merge<-merge(x=NEI, y=coalSCC, by = 'SCC')

merge.data <- aggregate(merge[, 'Emissions'], 
                       by = list(merge$year), sum)
colnames(merge.data)<-c('Year', 'Emissions')

library(ggplot2)

png(filename = 'plot4.png')
ggplot(data = merge.data, 
       aes(x = Year, y = Emissions)) + 
    geom_line(aes(group = 1, col = Emissions)) +  
    ggtitle(expression('Total Emissions of PM'[2.5])) + 
    ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
    geom_text(aes(label = round(Emissions, digits = 2)))     
dev.off()
