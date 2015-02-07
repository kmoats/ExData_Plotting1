# Function load_data() loads the data from "household_power_consumption.txt"
load_data <- function() {
        
        # Read data from file into a table
        dat <- read.table("household_power_consumption.txt", sep = ";", header=TRUE, na.strings = "?", nrows = 100000)
        
        # Subset only the dates "1/2/2007" and "2/2/2007"
        dat <- dat[dat$Date == "1/2/2007" | dat$Date == "2/2/2007",]
        
        # Coerce the Date column to the Date class
        dat$Date <- as.Date(dat$Date, "%d/%m/%Y") 
        
        # Create a new column named datetime in the data table that combines the Date and Time columns
        dat$datetime <- paste(dat$Date, dat$Time, sep=" ")
        
        # Use strptime to coerce the datetime column to the Date-Time class
        dat$datetime <- strptime(dat$datetime, "%Y-%m-%d %H:%M:%S")
        
        return(dat)
}

# Function plot3() generates plot3 and saves it to file plot3.png
plot3 <- function(){
        
        # Load power data using load_data() function
        powerdata <- load_data()
        
        # Open PNG device for plot3.png
        png(filename = "plot3.png", width = 480, height = 480, units = "px")
        
        # Generate plot3
        with(powerdata, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", col = "black", type = "l"))
        with(powerdata, points(datetime, Sub_metering_2, xlab = "", ylab = "Energy sub metering", col = "red", type = "l"))
        with(powerdata, points(datetime, Sub_metering_3, xlab = "", ylab = "Energy sub metering", col = "blue", type = "l"))
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
        
        # Close the PNG file device
        dev.off()
}