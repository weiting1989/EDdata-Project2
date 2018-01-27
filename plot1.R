
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

#Split and sum the emission by each year
emission <- aggregate(Emissions ~ year,NEI, FUN=sum)

#plot the graph and store in png.
png(filename='./plot1.png')
barplot(emission$Emissions/10^6, names.arg = emission$year, 
        xlab ="Year",
        ylab=expression("PM"[2.5]*" Emissions (10^6 Tons)"),
        main =expression("Total Emission PM"[2.5]*" From All US Source"))
dev.off()