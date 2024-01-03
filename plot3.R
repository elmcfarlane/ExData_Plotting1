library(sqldf)
library(lubridate)

h <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

household <- sqldf("select * from h where Date = '1/2/2007' or Date = '2/2/2007'",
                   dbname = tempfile(),
                   file.format = list(header = TRUE, row.names = FALSE, sep = ";"))

household$DateTime <- dmy_hms(paste(household$Date, household$Time))

png(file="plot3.png", width=480, height=480)

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
         lty = c(1, 1, 1))
})

dev.off()
