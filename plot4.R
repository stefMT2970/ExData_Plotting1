# project 1
# plot 4

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
## we only need 2 dates, subset and save in new temp data frame
hpc_sel <- hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"), ]

## for simplicity, get requested variables as separate vectors
gap <- as.numeric(hpc_sel$Global_active_power)
grp <- as.numeric(hpc_sel$Global_reactive_power)
voltage <- as.numeric(hpc_sel$Voltage)
temp_dt <- strptime(paste(hpc_sel$Date, hpc_sel$Time, sep=" "),
                    "%d/%m/%Y %H:%M:%S") 
sub1 <- as.numeric(hpc_sel$Sub_metering_1)
sub2 <- as.numeric(hpc_sel$Sub_metering_2)
sub3 <- as.numeric(hpc_sel$Sub_metering_3)


## paint the 4 plots, arranged in 2 by 2 grid layout
## note that dates are in Dutch locale
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(temp_dt, gap, 
     type="l", 
     xlab="", 
     ylab="Global Active Power")

plot(temp_dt, voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

plot(temp_dt, sub1, 
     type="l", 
     xlab ="",
     ylab="Energy sub metering")
lines(temp_dt, sub2, type="l", col="red")
lines(temp_dt, sub3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       lwd=1, 
       bty = "n",
       col=c("black", "red", "blue"))

plot(temp_dt, grp, 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()
