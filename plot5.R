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
VCSCC <- SCC[grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE),]
BaltimorePM <- merge(BaltimorePM,VCSCC,by="SCC")

#Plot the graph
png(filename='./plot5.png')
myplot <-ggplot(BaltimorePM,aes(factor(year),Emissions))+
        geom_bar(aes(fill=factor(year)),stat = "identity",width = 0.8)+
        theme_bw()+guides(fill=FALSE) +xlab(label = "Year")+
        ylab(label = expression("PM"[2.5]*" Emissions (Tons)"))+
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
print(myplot)
dev.off()