library(dplyr)
library(corrplot)
#library(hms)
library(lubridate)
library(mgcv)

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
  ))

URUV_model$TIME_DROPPED <- period_to_seconds(lubridate::hms(URUV_model$TIME_DROPPED))
URUV_model$MONTH <- factor(URUV_model$MONTH, levels = c("JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE",
                                                      "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"))
URUV_model$SITE_TYPE <- factor(URUV_model$SITE_TYPE, levels = c("D", "E", "L"))
URUV_model$DESA <- factor(URUV_model$DESA)

URUV_model_cont <- URUV_model %>%
  select(-c('MONTH', 'WEATHER', 'DESA', 'SITENAME_COMBINE', 'TIDE_DIRECTION', "SITE_TYPE"))
  

idk <- cor(URUV_model_cont, method = "pearson", use="complete.obs")# cor(URUV_model_cont, method = c("pearson", "kendall", "spearman"), use="complete.obs")

corrplot(idk, type = 'upper', order = "hclust", 
         tl.col = "black", tl.srt = 45)

## The pearsons coeff for Tide height and time of day is -0.26546621 and time of day vs avg water depth is 0.14719866. Tide height vs water depth was 0.22811888. indicating not collinear which makes sense because high tide changed drastically throughout the day and high tide had a big month to month depth range.

# WARNING I THINK MONTH AND TIME DROPPED ARE COLLINEAR WHICH MAKES SENSE BECAUSE WE PRETTY MUCH HAD A DIFFERETN START TIME BASED ON TIDES EACH MONTH
plot(x = URUV_model$TIME_DROPPED, y = URUV_model$NO_ALLSPECIES)

# Now checking for linear relationships


# Responses: total maxn, total species, shannon diversity, simpson diversity
# Continuous predictors: Time of day, Vegitation, Tide Height, Month? (I'll probably consider this catgorical but will test anyways)


# l1_1 <- lm(MAXN_TOTAL ~ TIME_DROPPED, data = URUV_model) # not normal, non-linear
# l2_1 <- lm(NO_ALLSPECIES ~ TIME_DROPPED, data = URUV_model) # not normal, non-linear
# l3_1 <- lm(SHANNON_DIV ~ TIME_DROPPED, data = URUV_model) # not normal, non-linear
# 
# l1_2 <- lm(MAXN_TOTAL ~ VEGITATION, data = URUV_model)
# l1_3 <- lm(MAXN_TOTAL ~ TIDE_HEIGHT, data = URUV_model)
# l1_4 <- lm(MAXN_TOTAL ~ WATER_DEPTH_AVERAGE, data = URUV_model)
# l1_5 <- lm(MAXN_TOTAL ~ MONTH_NO, data = URUV_model)


m1 <- gam(MAXN_TOTAL ~
            s(TIME_DROPPED, bs = "cc") +   # cyclic smooth for time of day
            s(TIDE_HEIGHT) +
            s(VEGITATION) +
            # Month +                      
            s(SITE_TYPE, bs = 're') +               # ordered factor
            s(DESA, bs = 're') +                       # nominal factor
            as.factor(WEATHER),
          family = poisson(),                 # negative binomial for count data
          method = "REML",              #
          data = URUV_model)

summary(m1)


# NEXT STEPS: GO THROUGH DIAGNOSTICS
# HOW TO CONSIDER VIDEO TIME AND VISIBILITY?
# SOO NOTES ABOVE FOR OTHER TESTS
# DO MODELS FOR OTHER RESPONSE VARIABLES
































