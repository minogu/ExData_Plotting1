## First, load dplyr and lubridate packages

library(dplyr)
library(lubridate)

## Read content of source file. Filter only first 2 days of Feb 2007, then
## change Date variable from character to date/time type (reading time part 
## from Time column), finally remove Time column. Store the result in 
## data_subset variable and remove the original big data frame.

dat <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", 
                na.strings = "?")
dat_subset <- dat %>% filter(dmy(Date) %within% interval(dmy("01.02.2007"), 
                                                         dmy("02.02.2007"))) %>%
  mutate(Date = dmy_hms(paste(Date, Time))) %>%
  select(-Time)
rm(dat)

## Set graphics device to png.
## Divide area into 2x2 to accomodate 4 plots.
## Print all 4 plots.
## Finally, close graphics device.

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(dat_subset, plot(Date, Global_active_power, xlab = "",
                      ylab = "Global Active Power", type = "l"))
with(dat_subset, plot(Date, Voltage, xlab = "datetime", ylab = "Voltage",
                      type = "l"))
with(dat_subset, plot(Date, Sub_metering_1, xlab = "",
                      ylab = "Energy sub metering", type = "l"))
with(dat_subset, points(Sub_metering_2 ~ Date, col = "red", type = "l"))
with(dat_subset, points(Sub_metering_3 ~ Date, col = "blue", type = "l"))
legend("topright", legend = c("Sub_meter_1", "Sub_meter_2", "Sub_meter_3"),
       col = c("black", "red", "blue"), lwd = 1, bty = "n")
with(dat_subset, plot(Date, Global_reactive_power, xlab = "datetime",
                      ylab = "Global_reactive_power", type = "l"))
dev.off()