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
Bm_CaPM <- subset(NEI,fips=="24510"|fips== "06037")
VCSCC <- SCC[grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE),]
plotdata <- merge(Bm_CaPM,VCSCC,by="SCC")
plotdata$fips <- factor(plotdata$fips, labels = c("Los Angeles County","Baltimore City"))

#make a plot by using ggplot2
png(filename='./plot6.png')
myplot<-ggplot(plotdata,aes(factor(year),Emissions,fill=fips))+
        facet_grid(.~fips)+
        geom_bar(aes(fill=factor(year)),stat = "identity",width = 0.8)+
        theme_bw()+guides(fill=FALSE) +xlab(label = "Year")+
        ylab(label = expression("PM"[2.5]*" Emissions (Tons)"))+
        labs(title=expression("PM"[2.5]*" Motor Vehicle  Emissions in Baltimore & Los Angles"))
print(myplot)
dev.off()
