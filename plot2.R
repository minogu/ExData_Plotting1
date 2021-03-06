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
## Print linear plot (using type = "l")
## Finally, close graphics device.

png("plot2.png", width = 480, height = 480)
with(dat_subset, plot(Date, Global_active_power, 
                      xlab = "",
                      ylab = "Global Active Power (kilowatts)",
                      type = "l"))
dev.off()
