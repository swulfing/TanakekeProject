library(ggplot2)

dat <- read.csv("https://raw.githubusercontent.com/ucdavis-bioinformatics-training/2018-September-Bioinformatics-Prerequisites/master/friday/lm_example_data.csv")

#Make a scatterplot

# Syntax:
#   ggplot(DATA, aes(x = xaxis, y = yaxis)) +
#     geom_point() #What kind of plot you want to make
ggplot(dat, aes(x=temperature, y=expression)) +
  geom_point() 

# Plotting a regression like yesterday
ggplot(dat, aes(x=temperature, y=expression)) +
  geom_point() + 
  geom_smooth(method = 'lm') # Saying we're creating a linear model

#Changing axis limits
ggplot(dat, aes(x=temperature, y=expression)) +
  geom_point() + 
  geom_smooth(method = 'lm') +
  ylim(0,15) +
  xlim(5,20)

#Changing axis titles
ggplot(dat, aes(x=temperature, y=expression)) +
  geom_point() + 
  geom_smooth(method = 'lm') +
  ylim(0,15) +
  xlim(5,20) +
  labs(title = "Temperature Vs Gene Expression", y="Expression", x="Temperature") #don't need to specify titles

# Changing colors of points
ggplot(dat, aes(x=temperature, y=expression)) +
  geom_point(col="red", size=3) + 
  geom_smooth(method = 'lm') +
  ylim(0,15) +
  xlim(5,20) +
  labs(title = "Temperature Vs Gene Expression", y="Expression", x="Temperature")

# Changing colors of points based on treatmen
ggplot(dat, aes(x=temperature, y=expression)) +
  geom_point(aes(col=treatment)) + 
  geom_smooth(method = 'lm') +
  ylim(0,15) +
  xlim(5,20) +
  labs(title = "Temperature Vs Gene Expression", y="Expression", x="Temperature")

# Activity: Lets pick another graph we'd like to make with the dataset we cleaned and fixed the dates and lets make three graphs ready for publication 


##### back to slides ---------------------------------------


#Mapping in R
# Go through this tutorial and change for IN: https://r-graph-gallery.com/330-bubble-map-with-ggplot2.html


#Basically a demonstration on how you adapt code to fit your needs

# Libraries
library(ggplot2)
library(dplyr)

# Get the world polygon and extract UK
library(giscoR)
Indonesia <- gisco_get_countries(country = "Indonesia", resolution = 1)

# Get a data frame with longitude, latitude, and size of bubbles (a bubble = a city)
library(maps)
data <- world.cities %>%
  filter(country.etc == "Indonesia")


# Left chart
ggplot() +
  geom_sf(data = Indonesia, fill = "grey", alpha = 0.3) +
  geom_point(data = data, aes(x = long, y = lat)) +
  theme_void() 

data %>%
  arrange(pop) %>%
  mutate(name = factor(name, unique(name))) %>%
  ggplot() +
  geom_sf(data = Indonesia, fill = "grey", alpha = 0.3) +
  geom_point(aes(x = long, y = lat, size = pop, color = pop), alpha = 0.9) +
  scale_size_continuous(range = c(1, 12)) +
  scale_color_viridis_c(trans = "log") +
  theme_void() +
  theme(legend.position = "none")
