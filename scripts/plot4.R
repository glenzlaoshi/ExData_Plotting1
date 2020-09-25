
## read the data file and store as a dataframe
# would save time to only import the values for the dates needed - maybe try this using sqlite?

#data <- read.csv("household_power_consumption.txt",sep=";")

data <- read.csv("household_power_consumption.txt",sep=";",colClasses=c("character","character","character","character","character","character","character","character","character"))

## convert columns to appropriate classes - better to do this while reading???

# create new datatime column for graphing time over multiple days
data$datetime <- paste(data$Date,data$Time)
data$datetime<-strptime(data$datetime,format="%d/%m/%Y %H:%M:%S")
# format data and time values (still necessary to subset data; could change subset to use datetime values instead
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
#data$Time<-times(data$Time)
# convert other values to numerics
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

## subset for needed dates

sub_data<-data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

## graph data subset

# open device for png
png(file="plot4.png")

# create an empty 4x4 plot window
par(mfrow=c(2,2),mar=c(4,4,2,2))
# add the first plot
plot(sub_data$datetime,sub_data$Global_active_power,type="l",ylab="Global Active Power",xlab="")
# add the second plot
plot(sub_data$datetime,sub_data$Voltage,type="l",ylab="Voltage",xlab="datetime")
# add the third plot (multiple data added using 'points' and 'legend' - had to look up how to make the legend without the box)
with(sub_data,plot(datetime,Sub_metering_1,main="",ylab="Energy sub metering",xlab="",type="l"))
points(sub_data$datetime,sub_data$Sub_metering_2,type="l",col="red")
points(sub_data$datetime,sub_data$Sub_metering_3,type="l",col="blue")
legend("topright",bty="n",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# add the fourth plot - ylab should probably be "Global Reactive Power" instead
plot(sub_data$datetime,sub_data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

# close graphics device
dev.off()
