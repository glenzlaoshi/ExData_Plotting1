
# import the chron library to use 'times' to deal with formatting the times - turns out to be unnecessary for these graphs, but left it here for future reference
library(chron)

## read the data file and store as a dataframe

data <- read.csv("household_power_consumption.txt",sep=";",colClasses=c("character","character","character","character","character","character","character","character","character"))

# convert columns to appropriate classes - better to do this while reading???

data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Time<-times(data$Time)
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

# subset for needed dates

sub_data<-data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

## graph data subset
# open device for png
png(file="plot1.png")

# create the graph - histogram of 'Global Active Power' with appropriate labels
hist(sub_data$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")

# close the graphics device
dev.off()
