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
BaltimoreEm <- aggregate(Emissions~year,BaltimorePM,FUN = sum)

#Plot the graph
png(filename='./plot2.png')
par(mar= c(5,5,4,1))
barplot(BaltimoreEm$Emissions, names.arg = BaltimoreEm$year, 
        xlab ="Year",ylab=expression(paste(PM[2.5]," Emissions (Tons)")),
        main =expression(paste("Total Emission ",PM[2.5]," From Baltimore,Maryland")))
dev.off()