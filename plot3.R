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

#Retrive Baltimore data and sum the emission by each year
BaltimorePM <- subset(NEI,fips=="24510")

#Plot the graph by using ggplot2
png(filename='./plot3.png')
myplot <-ggplot(BaltimorePM,aes(factor(year),Emissions,fill=type))+
        facet_grid(.~type)+geom_bar(stat="identity")+
        theme_bw()+guides(fill=FALSE)+
        xlab(label = "Year")+
        ylab(label = expression("PM"[2.5]*" Emissions (Tons)"))+
        labs(title=expression("PM"[2.5]*" Emissions from Baltimore City in 1999-2008 by Source Type"))
print(myplot)
dev.off()