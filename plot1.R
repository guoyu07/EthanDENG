setwd("E:/Sola/R/Exploratory data/week1")

# raw data
power = read.table("household_power_consumption.txt", header = TRUE, sep = ";",stringsAsFactors=FALSE,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")

# subset from the raw data
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# reconstruct new variables: time and date
Com_Time <-paste(power$Date,power$Time)
power$date <- as.Date(power$Date,"%d/%m/%Y")
power$time <- strptime(Com_Time, "%d/%m/%Y %H:%M:%S")

# drop the Date and Time variable
power <- power[,c(-1,-2)]

attach(power)


png(filename="plot1.png",width=480,height=480,units="px",bg="transparent",restoreConsole = TRUE)
hist(Global_active_power,col="2",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()

detach()
