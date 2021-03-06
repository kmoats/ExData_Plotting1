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

# Function plot2() generates plot2 and saves it to file plot2.png
plot2 <- function(){
        
        # Load power data using load_data() function
        powerdata <- load_data()
        
        # Open PNG device for plot2.png
        png(filename = "plot2.png", width = 480, height = 480, units = "px")
        
        # Generate plot2
        with(powerdata, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
        
        # Close the PNG file device
        dev.off()
}