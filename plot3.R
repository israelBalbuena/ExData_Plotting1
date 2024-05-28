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


with(data, plot(complete_date, Sub_metering_1, "l", xaxt ="n", xlab="",
                ylab="Energy sub metering"))
axis(1, at = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 00:00:00"), 
               ymd_hms("2007-02-03 00:00:00")), labels = c("Thu","Fri", "Sat"))
lines(data$complete_date, data$Sub_metering_2, col="red")
lines(data$complete_date, data$Sub_metering_3, col="blue")
legend(ymd_hms("2007-02-02 12:00:00"), 39.5,
                          legend = c("Sub_metering_1","Sub_metering_2",
                                     "Sub_metering_3"), 
                                      cex = 0.5, col=c("black","red","blue"),
                                      lty=c(1,1,1))


dev.copy(png,"plot3.png")

dev.off()

