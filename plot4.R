#load ggplot2 library
library(ggplot2)

#Download source file and unzip it.
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipName <- "./FNEI_data.zip"
if(!file.exists(zipName))
{
        download.file(dataUrl,zipName)
        unzip(zipName)
}

#Read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Coal combustion related sources
coalscc <- SCC[grepl("coal",SCC$Short.Name,ignore.case = TRUE),]
mergeData<-merge(NEI,coalscc,by = "SCC")
plotdata<-aggregate(Emissions~year,mergeData,FUN = sum)

#Plot the graph
png(filename='./plot4.png')
myplot<-ggplot(plotdata,aes(factor(year),Emissions)) +
        geom_bar(aes(fill=factor(year)),stat="identity",width=.8) +
        theme_bw()+guides(fill=FALSE) +
        xlab(label = "Year")+
        ylab(label = expression("PM"[2.5]*" Emissions (Tons)"))+
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
print(myplot)
dev.off()
