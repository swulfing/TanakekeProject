library(dplyr)
library(corrplot)
#library(hms)
library(lubridate)
library(mgcv)

# https://noamross.github.io/gams-in-r-course/chapter2
# SHOULD I PULL IN DAILY TEMPERATURE DATA
# MODEL TESTS: VIF (Variance Inflation Factor) after an initial model fit — VIF > 5–10 is a warning sign. 
#   always inspect each smooth's effective degrees of freedom (edf): if edf ≈ 1
#   Samples are pseudorepolicated in Desa and Habitat type. 

setwd('C:/Users/swulfing/Documents/GitHub/TanakekeProject/URUVS/Datasheets')
URUV_data <- read.csv('MasterRecordingData_clean.csv')


# TESTING FOR COLLINEARITY BETWEEN VARS
URUV_model <- URUV_data %>%
  select("MONTH", "DESA", "SITENAME_COMBINE",  "SITE_TYPE", "TIME_DROPPED", "VEGITATION", "VISIBILITY", "WEATHER", "TIDE_HEIGHT", "TIDE_DIRECTION", "WATER_DEPTH_AVERAGE", "TOTALTIME_ANALYSIS", "NO_ALLSPECIES", "NO_FISHSPECIES", "MAXN_TOTAL", "SHANNON_DIV", "SIMPSON_DIV" )%>%
  mutate(MONTH_NO = case_when(
    MONTH == "FEBRUARY" ~ 2,
    MONTH == "MARCH" ~ 3,
    MONTH == "APRIL" ~ 4,
    MONTH == "MAY" ~ 5,
    MONTH == "JUNE" ~ 6,
    MONTH == "JULY" ~ 7,
    MONTH == "AUGUST" ~ 8,
    MONTH == "SEPTEMBER" ~ 9,
  )) %>%
  mutate(WEATHER_CAT = case_when(
    WEATHER == "CLOUDY, JUST AFTER RAIN" ~ "CLOUDY",
    WEATHER == "SUNNY, NO RAIN, LIGHT CLOUDS" ~ "SUNNY",
    WEATHER == "SUNNY, RAINED EARLIER" ~ "SUNNY",
    WEATHER == "RAIN DURING RECORDING" ~ "RAINY",
    WEATHER == "SUNNY" ~ "SUNNY",
    WEATHER == "CLOUDY" ~ "CLOUDY",
    WEATHER == "DRIZZLE" ~ "RAINY",
    WEATHER == "SLIGHTLY CLOUDY" ~ "CLOUDY",
    WEATHER == "RAINY" ~ "RAINY",
  ))

URUV_model$TIME_DROPPED <- period_to_seconds(lubridate::hms(URUV_model$TIME_DROPPED))
URUV_model$MONTH <- factor(URUV_model$MONTH, levels = c("JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE",
                                                      "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"))
URUV_model$SITE_TYPE <- factor(URUV_model$SITE_TYPE, levels = c("D", "E", "L"))
URUV_model$WEATHER_CAT <- factor(URUV_model$WEATHER_CAT, levels = c("SUNNY", "CLOUDY", "RAINY"))
URUV_model$DESA <- factor(URUV_model$DESA)

URUV_model_cont <- URUV_model %>%
  select(-c('MONTH', 'WEATHER_CAT', 'WEATHER', 'DESA', 'SITENAME_COMBINE', 'TIDE_DIRECTION', "SITE_TYPE"))
  

idk <- cor(URUV_model_cont, method = "pearson", use="complete.obs")# cor(URUV_model_cont, method = c("pearson", "kendall", "spearman"), use="complete.obs")

corrplot(idk, type = 'upper', order = "hclust", 
         tl.col = "black", tl.srt = 45)

## The pearsons coeff for Tide height and time of day is -0.26546621 and time of day vs avg water depth is 0.14719866. Tide height vs water depth was 0.22811888. indicating not collinear which makes sense because high tide changed drastically throughout the day and high tide had a big month to month depth range.

# WARNING I THINK MONTH AND TIME DROPPED ARE COLLINEAR WHICH MAKES SENSE BECAUSE WE PRETTY MUCH HAD A DIFFERETN START TIME BASED ON TIDES EACH MONTH
# plot(x = URUV_model$TIME_DROPPED, y = URUV_model$NO_ALLSPECIES)

# Now checking for linear relationships


# Responses: total maxn, total species, shannon diversity, simpson diversity
# Continuous predictors: Time of day, Vegitation, Tide Height, Month? (I'll probably consider this catgorical but will test anyways)



# MAXNTOTAL MODELS --------------------------------------------------------


# m1.1 <- gam(MAXN_TOTAL ~ # QQ PLOT TOO STEEP. TESTING OTHER DISTRIBUTIONS
#             s(TIME_DROPPED, bs = "cc") +   # cyclic smooth for time of day
#             s(TIDE_HEIGHT) +
#             s(VEGITATION) +
#             # Month +                      
#             s(SITE_TYPE, bs = 're') +               # ordered factor
#             s(DESA, bs = 're') +                       # nominal factor
#             as.factor(WEATHER_CAT),
#           family = poisson(),                 
#           method = "REML",              
#           data = URUV_model)
# 
# summary(m1.1)
# 
# 
# plot(m1.1, pages = 1, all.terms = TRUE, shade = TRUE)
# 
# plot(m1.1, rug = TRUE, residuals = TRUE, pch = 1, cex = 1, shade = TRUE, seWithMean = TRUE, shift = coef(m1.1)[1])
# 
# gam.check(m1.1)

# m1.2 <- gam(MAXN_TOTAL ~ # QQ PLOT TOO STEEP. TESTING OTHER DISTRIBUTIONS
#               s(TIME_DROPPED, bs = "cc") +   # cyclic smooth for time of day
#               s(TIDE_HEIGHT) +
#               s(VEGITATION) +
#               # Month +                      
#               s(SITE_TYPE, bs = 're') +               # ordered factor
#               s(DESA, bs = 're') +                       # nominal factor
#               as.factor(WEATHER_CAT),
#             family = nb(),                 
#             method = "REML",              
#             data = URUV_model)
# 
# summary(m1.2)
# 
# 
# plot(m1.2, pages = 1, all.terms = TRUE, shade = TRUE)
# 
# plot(m1.2, rug = TRUE, residuals = TRUE, pch = 1, cex = 1, shade = TRUE, seWithMean = TRUE, shift = coef(m1.2)[1])
# 
# gam.check(m1.2)
#concurvity(m1.2, full = TRUE)
#concurvity(m1.2, full = FALSE)

m1.3 <- gam(MAXN_TOTAL ~ # QQ PLOT TOO STEEP. TESTING OTHER DISTRIBUTIONS
              s(TIME_DROPPED, bs = "cc") +   # cyclic smooth for time of day
              s(TIDE_HEIGHT) +
              s(VEGITATION) +
              # Month +                      
              SITE_TYPE +               # ordered factor
              DESA +                       # nominal factor
              as.factor(WEATHER_CAT),
            family = nb(),                 
            method = "REML",              
            data = URUV_model)

summary(m1.3)


plot(m1.3, pages = 1, all.terms = TRUE, shade = TRUE)

plot(m1.3, rug = TRUE, residuals = TRUE, pch = 1, cex = 1, shade = TRUE, seWithMean = TRUE, shift = coef(m1.3)[1])

gam.check(m1.3)
concurvity(m1.3, full = TRUE)

# NEXT STEPS: GO THROUGH DIAGNOSTICS
# HOW TO CONSIDER VIDEO TIME AND VISIBILITY?
# SOO NOTES ABOVE FOR OTHER TESTS
# DO MODELS FOR OTHER RESPONSE VARIABLES


# TOTAL SPECIES MODELS --------------------------------------------------------

m2.1 <- gam(NO_FISHSPECIES ~ 
                        s(TIME_DROPPED, bs = "cc") +   # cyclic smooth for time of day
                        s(TIDE_HEIGHT) +
                        s(VEGITATION) +
                        # Month +
                        s(SITE_TYPE, bs = 're') +               # ordered factor
                        s(DESA, bs = 're') +                       # nominal factor
                        as.factor(WEATHER_CAT),
                      family = poisson(),
                      method = "REML",
                      data = URUV_model)

summary(m2.1)


plot(m2.1, pages = 1, all.terms = TRUE, shade = TRUE)

plot(m2.1, rug = TRUE, residuals = TRUE, pch = 1, cex = 1, shade = TRUE, seWithMean = TRUE, shift = coef(m1)[1])

gam.check(m2.1)

# TOTAL SPECIES MODELS --------------------------------------------------------

m3.1 <- gam(SHANNON_DIV ~ 
              s(TIME_DROPPED, bs = "cc") +   # cyclic smooth for time of day
              s(TIDE_HEIGHT) +
              s(VEGITATION) +
              # Month +
              s(SITE_TYPE, bs = 're') +               # ordered factor
              s(DESA, bs = 're') +                       # nominal factor
              as.factor(WEATHER_CAT),
            family = poisson(),
            method = "REML",
            data = URUV_model)

summary(m3.1)


plot(m3.1, pages = 1, all.terms = TRUE, shade = TRUE)

plot(m3.1, rug = TRUE, residuals = TRUE, pch = 1, cex = 1, shade = TRUE, seWithMean = TRUE, shift = coef(m1)[1])

gam.check(m3.1)