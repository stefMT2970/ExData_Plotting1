# project 1
# plot 1

## move to a working directory, modify setwd()
old_dir = getwd()
setwd("d:/dev/app/R/04_ExData")

## check if file exists first, then download and unzip
if(!file.exists("hpc.zip")) {
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = file_url, destfile = "hpc.zip")
unzip("./hpc.zip")
}

## Read the power file
hpc <- read.table(file = "./household_power_consumption.txt", 
                  sep = ";",
                  header = TRUE ,  
                  stringsAsFactors = FALSE)
## we only need 2 dates, subset
hpc_sel <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]

## for simplicity, get requested variable as separate vectors
gap <- as.numeric(hpc_sel$Global_active_power)

## paint the histogram
png("plot1.png", width=480, height=480)

par(mfrow=c(1,1))

hist(gap, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.off()
