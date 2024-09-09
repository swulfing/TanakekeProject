library(lubridate)
library(dplyr)

today()

now()


myDate <- as.Date("2015-10-19 10:15")   
str(myDate)

timeDate <- as.POSIXct("2015-10-19 10:15")   
str(timeDate)

timeDatelt<- as.POSIXlt("2015-10-19 10:15")  
str(timeDatelt)


dateInfo <- as.POSIXct("January 30, 25") #Doesn't work
dateInfo <- as.POSIXct("January 30, 25 10:15 PM", format = "%B %d, %y %I:%M %p")
str(dateInfo)

#Exracting information from 
year(dateInfo)
month(dateInfo)
day(dateInfo)
hour(dateInfo)
minute(dateInfo)

# df <- data.frame(date = as.Date("2021-01-01") - 0:99,
#                  sales = runif(100, 10, 500) + seq(50, 149)^2)
# write.csv(df, "C:/Users/Sophi/Documents/GitHub/TanakekeProject/RClass/UNHAS/dateTime.csv")







# Activity: Download the dates dataset. Each group picks a different column to fix the dates and graph a time series
dateData <- read.csv("C:/Users/Sophi/Documents/GitHub/TanakekeProject/RClass/UNHAS/dateTime.csv")

# Try a time series alone
plot(x = dateData$date3, y = dateData$sales, type = 'l')

class(dateData$date3)

#Must change the datatype

dateData$date <- as.POSIXct(dateData$date3, format = "%A, %B %d, %Y")

class(dateData$date)

plot(x = dateData$date3, y = dateData$sales, type = 'l')





# Activity: Use dplyr and graphing to extract the show the monthly average across all of the years

monthlyAverage <- dateData %>%
  mutate(month = month(date)) %>%
  group_by(month) %>%
  summarize(mean = mean(sales))

monthlyAverage
barplot(height = monthlyAverage$mean, names.arg = monthlyAverage$month)
