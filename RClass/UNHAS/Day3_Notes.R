#Download packages. Its clean coding to put all packages at the TOP of your rscript

library(dplyr)
library(lubridate)
library(ggplot2)
library(RColorBrewer) #Install different colors that can be used in ggplot

#with lubridate package
today()
now()


myDate <- "2024-09-13 11:18:24 CST"
class(myDate)

#baseR
myDate <- as.Date(myDate)
class(myDate)
str(myDate) #Only saves date. In order to save date and time, we have to use lubridate package


#Redefine myDate to be a string
myDate <- "2024-09-13 11:18:24 CST"
myDate <- as.POSIXlt(myDate)
str(myDate)



myDate2 <- "January 30, 25 10:15 PM"
myDate2 <- as.POSIXlt(myDate2) #runs an error

myDate2 <- as.POSIXlt(myDate2, format = "%B %d, %y %I:%M %p") #We need to give it a format from this website: https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strptime
str(myDate2)


#Extract information from date

year(myDate2)
month(myDate2)
day(myDate2)
hour(myDate2)
minute(myDate2)

#ACTIVITY: Read in the cleaned data from the data hygiene lesson.
  # Read in the date column as a date
  # Make a timeseries of the weights over time


#Step 1 read in the data 


myData <- read.csv("C:/Users/Sophi/Documents/GitHub/TanakekeProject/RClass/UNHAS/survey_data_spreadsheet_clean.csv")

View(myData)

class(myData$DATE_COLLECTED)
plot(x = myData$DATE_COLLECTED, y = myData$WEIGHT) #Will be an error because date is still in character format

#Need to change the datatype


myData$DATE_COLLECTED <- as.POSIXlt(myData$DATE_COLLECTED, format = "%d/%m/%Y")
class(myData$DATE_COLLECTED)
plot(x = myData$DATE_COLLECTED, y = myData$WEIGHT)



### GGPLOT LESSON

dat <- read.csv("https://raw.githubusercontent.com/ucdavis-bioinformatics-training/2018-September-Bioinformatics-Prerequisites/master/friday/lm_example_data.csv")


ggplot(dat, aes(x = temperature, y = expression)) #Set data and axis

#Now add points
ggplot(dat, aes(x = temperature, y = expression)) +
  geom_point() #Add points. Scatterplot

# Add a linear model
ggplot(dat, aes(x = temperature, y = expression)) +
  geom_point() +
  geom_smooth(method = 'lm') # Add a smoothing function. lm means we're using a linear model

# Add formatting
ggplot(dat, aes(x = temperature, y = expression)) +
  geom_point(color = "red") + #Change points to red
   geom_smooth(method = 'lm') +
   xlim(5,20) + #Change x and y axis
   ylim(0,15) +
  labs(title = "Expression of genes in response to treatment", x = "Temperature", y = "Expression") #Change the main title, x and y axis titles

# Changing the points to be a variable
ggplot(dat, aes(x = temperature, y = expression)) +
  geom_point(aes(color = treatment)) + #Change point colors to be a variable
  geom_smooth(method = 'lm') +
  xlim(5,20) + 
  ylim(0,15) +
  labs(title = "Expression of genes in response to treatment", x = "Temperature", y = "Expression")


#ACTIVTY: Pick two graphs that we would like to make from the cleaned date. We will add comoponents of gpplot so it ready for publication


# Boxplot basic
myData %>%
  ggplot( aes(x=SPECIES, y=WEIGHT, fill=SPECIES)) + #Changed the data inputs
  geom_boxplot() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("Species Weight")  + #Changed the title
  scale_fill_brewer(palette="Pastel1") +
  ylim(0,70)






