library(sqldf)
library(lubridate)

h <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

household <- sqldf("select * from h where Date = '1/2/2007' or Date = '2/2/2007'",
                   dbname = tempfile(),
                   file.format = list(header = TRUE, row.names = FALSE, sep = ':'))

household$DateTime <- dmy_hms(paste(household$Date, household$Time))

png(file="plot2.png", width=480, height=480)

plot(household$DateTime,
     household$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.off()
