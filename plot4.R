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

# Function plot4() generates plot4 and saves it to file plot4.png
plot4 <- function(){
        
        # Load power data using load_data() function
        powerdata <- load_data()
        
        # Open PNG device for plot4.png
        png(filename = "plot4.png", width = 480, height = 480, units = "px")
        
        # Generate plot4
        par(mfrow=c(2,2))
        with(powerdata, {
                
                # Top-left plot
                plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
                
                # Top-right plot
                plot(datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")                
                
                # Bottom-left plot
                plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", col = "black", type = "l")
                points(datetime, Sub_metering_2, xlab = "", ylab = "Energy sub metering", col = "red", type = "l")
                points(datetime, Sub_metering_3, xlab = "", ylab = "Energy sub metering", col = "blue", type = "l")
                legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
                
                # Bottom-right plot
                plot(datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
        })
        
        # Close the PNG file device
        dev.off()
}