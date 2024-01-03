library(sqldf)
library(lubridate)

h <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

household <- sqldf("select * from h where Date = '1/2/2007' or Date = '2/2/2007'",
                   dbname = tempfile(),
                   file.format = list(header = TRUE, row.names = FALSE, sep = ";"))

household$DateTime <- dmy_hms(paste(household$Date, household$Time))

png(file="plot4.png", width=480, height=480)

par(mfcol = c(2,2))

# Top left plot
with(household, {
  plot(DateTime,
     Global_active_power,
     type = "l", 
     ylab = "Global Active Power",
     xlab = "")
})

# Bottom left plot
with(household, {
  plot(DateTime,
       Sub_metering_1, 
       type = "l",
       ylab = "Energy sub metering",
       xlab = "")
  lines(DateTime,
        Sub_metering_2, 
        type = "l",
        col = "red")
  lines(DateTime,
        Sub_metering_3, 
        type = "l",
        col = "blue")
  legend("topright", 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"),
         lty = c(1, 1, 1),
         bty = "n")
})

# Top right plot
with(household, {
  plot(DateTime,
       Voltage, 
       type = "l",
       ylab = "Voltage",
       xlab = "")
})

# Bottom right plot
with(household, {
  plot(DateTime,
       Global_reactive_power, 
       type = "l",
       xlab = "")
})
  
dev.off()
