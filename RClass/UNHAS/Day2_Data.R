library(dplyr)

# CALL DATASHEET BY SETTING WORKING DIRECTORY

getwd()
setwd("C:/Users/Sophi/Documents/GitHub/TanakekeProject/RClass/UNHAS")

gapminder <- read.csv("gapminder.csv")

#OR

gapminder <- read.csv("C:/Users/Sophi/Documents/GitHub/TanakekeProject/RClass/UNHAS/gapminder.csv")

View(gapminder)

# GRAPHING boxplot and line DPLYR filter ----------------------------------------------------------------
# Boxplot gdp per capita. Then filter by country
boxplot(lifeExp ~ country, data = gapminder)

# DPLYR just looking at specific countries
SEAsia <- gapminder %>%
  filter(country %in% c("Indonesia", "Malaysia", "Singapore"))

boxplot(pop ~ country, data = SEAsia)


#Look at line graph

Indonesia <- gapminder %>%
  filter(country == "Indonesia")

plot(x = Indonesia$year, y = Indonesia$lifeExp, type = 'l') 


# SHOW HOW TO EXTRACT A GRAPH

# GRAPHING scatterplot DPLYR group by and summarize ----------------------------------------------------------------

plot(x = gapminder$gdpPercap, y = gapminder$lifeExp)

lifeExpectancyData <- gapminder %>%
  group_by(country) %>%
  summarize(AvgLife = mean(lifeExp), Avggdp = mean(gdpPercap)) #look at the file we just made

View(lifeExpectancyData)


plot(x = lifeExpectancyData$Avggdp, y = lifeExpectancyData$AvgLife)




# GRAPHING scatterplot DPLYR mutate ----------------------------------------------------------------

gdpSEAsia <- SEAsia %>%
  group_by(country) %>%
  summarise(AvgLife = mean(lifeExp), Avggdp = mean(gdpPercap))

barplot(height = gdpSEAsia$Avggdp, names.arg = gdpSEAsia$country)

gdpSEAsia_IDR <- gdpSEAsia %>%
  mutate(gdpIDR = Avggdp * 15491)
  

barplot(height = gdpSEAsia_IDR$gdpIDR, names.arg = gdpSEAsia_IDR$country)



# GRAPHING export csv file DPLYR select and rename ----------------------------------------------------------------

# Our boss wants population over time of each country. But they only speak indonesian

poplasiDunia <- gapminder %>%
  select(country, year, pop) %>%
  rename(negara = country,
         tahun = year,
         poplasi = pop)

write.csv(poplasiDunia,"dataPoplasi.csv")


#### Return to code

# Statistics in R ----------------------------------------------------------------

dat <- read.csv("https://raw.githubusercontent.com/ucdavis-bioinformatics-training/2018-September-Bioinformatics-Prerequisites/master/friday/lm_example_data.csv") #You can also read csv data directly off of the internet

#What is this datasheet? What are all of the variables and what kind are they


#Statistics to show distributions

# Histogram

hist(dat$expression)

hist(dat$expression, breaks = 20)


# Boxplots also show data distributions
boxplot(expression ~ treatment, data = dat)

# ANOVAS and LMs

one.way_ANOVA <- lm(expression ~ treatment, data = dat)
summary(one.way_ANOVA)

# Linear Models

linearModel <- lm(expression ~ temperature, data = dat) #What is the difference between these two codes
summary(linearModel)


plot(x = dat$temperature, y = dat$expression)
abline(lm(expression ~ temperature, data = dat))


#diagnostics
plot(linearModel)







