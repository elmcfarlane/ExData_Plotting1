library(sqldf)
library(ggplot2)

h <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

household <- sqldf("select * from h where Date = '1/2/2007' or Date = '2/2/2007'",
                   dbname=tempfile(),
                   file.format = list(header = TRUE, row.names = FALSE, sep = ":"))

household <- sapply(household, as.numeric)
household <- as.data.frame(household)

png(file="plot1.png", width=480, height=480)

ggplot(household, aes(x=Global_active_power)) +
  geom_histogram(color="black", fill="red", breaks=c(0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5)) +
  scale_x_continuous(breaks=c(0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5)) + 
  labs(title="Global Active Power", y="Frequency", x="Global Active Power (kilowatts)") +
  theme_classic() +
  scale_x_continuous(expand = c(0,0)) + 
  scale_y_continuous(expand = c(0,0)) +
  theme(plot.title = element_text(hjust = 0.5))

dev.off()
