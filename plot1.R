library(pacman)

p_load(tidyverse, lubridate)


data <- read_delim("household_power_consumption.txt", 
                   delim = ";", escape_double = FALSE, 
                   col_types = cols(Date = col_character(), 
                   Time = col_character(), Global_active_power = col_double(), 
                   Global_reactive_power = col_double(), 
                   Voltage = col_double(), Global_intensity = col_double(), 
                   Sub_metering_1 = col_double(), Sub_metering_2 = col_double()), 
                   trim_ws = TRUE) %>% 
        filter(Date %in%c("1/2/2007","2/2/2007")) %>%  
        mutate(complete_date =  dmy_hms(paste(Date,Time))  )


with(data, hist(Global_active_power, xlab="Global Active Power (kilowatts)", 
                                      main= "Global Active Power",col="red"))

dev.copy(png, "plot1.png")

dev.off()


