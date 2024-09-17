#Upload packages
library(dplyr)


#Setting a working directory
getwd()
setwd("C:/Users/Sophi/Documents/GitHub/TanakekeProject/RClass/UNHAS")

#Upload our gapminder data
gapminder_data <- read.csv("gapminder.csv")

View(gapminder_data)

summary(gapminder_data)

# Boxplot different country's life exp.

#BaseR boxplot
boxplot(lifeExp ~country, data = gapminder_data)


#Filter Function in dplyr to only look at specific countries

SEAsia <- gapminder_data %>%
  filter(country %in% c("Indonesia", "Malaysia", "Singapore")) #Filter out rows depending on information

View(SEAsia)


boxplot(lifeExp ~ country, data = SEAsia)


#Looking at Indonesia Data
Indonesia_Data <- gapminder_data %>%
  filter(country == "Indonesia")

#Create a line graph

plot(x = Indonesia_Data$year, y = Indonesia_Data$lifeExp, type = 'l')

# group_by() and summarize()

plot(x = gapminder_data$gdpPercap, y = gapminder_data$lifeExp)

# Get average life expectancy AND average gdp per country

lifeExpectancyData <- gapminder_data %>%
  group_by(country) %>%
  summarize(AvgLife = mean(lifeExp), Avggdp = mean(gdpPercap))
  
View(lifeExpectancyData)  

# Scatterplot
plot(x = lifeExpectancyData$Avggdp, y = lifeExpectancyData$AvgLife)  
 
 
  
# mutate()

gdpSEAsia <- SEAsia %>%
  group_by(country) %>%
  summarize(AvgLife = mean(lifeExp), Avggdp = mean(gdpPercap))
View(gdpSEAsia)  


barplot(height = gdpSEAsia$Avggdp, names.arg = gdpSEAsia$country, horiz = TRUE, xlim = c(0, 20000))


#Change USD to IDR

gdpSEAsia_IDR <- gdpSEAsia %>%
  mutate(gdpIDR = Avggdp * 15.491)

View(gdpSEAsia_IDR)

barplot(height = gdpSEAsia_IDR$gdpIDR, names.arg = gdpSEAsia_IDR$country)


# Select and Rename 

populasiDunia <- gapminder_data %>%
  select(country, year, pop) %>%
  rename(negara = country,
         tahun = year,
         populasi = pop)
  
  

#Write a csv file

write.csv(populasiDunia, "data Populasi.csv")



### STATISTICS IN R
dat <- read.csv("https://raw.githubusercontent.com/ucdavis-bioinformatics-training/2018-September-Bioinformatics-Prerequisites/master/friday/lm_example_data.csv")


#Descriptive stats to show distributions

hist(dat$expression)

hist(dat$expression, breaks = 20)

# Boxplot

boxplot(expression ~ treatment, data = dat)

# ANOVA IN R
one.way_ANOVA <- lm(expression ~ treatment, data = dat)
#Using a categorical variable (treatment) with a continuous (expression)

one.way_ANOVA <- aov(expression ~ treatment, data = dat)

summary(one.way_ANOVA)


#Linear Models
linearModel <- lm(expression ~ temperature, data = dat)
# Looking at two continuous variables (expression vs temperature)
summary(linearModel)

plot(x= dat$temperature, y = dat$expression)
abline(lm(expression~temperature, data = dat))


plot(linearModel)



