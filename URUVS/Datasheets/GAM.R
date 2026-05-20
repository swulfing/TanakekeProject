library(dplyr)
library(corrplot)
#library(hms)
library(lubridate)
library(mgcv)
library(gratia)
# https://noamross.github.io/gams-in-r-course/chapter2
# Qs for easton on document
  # Journal Ideas, can I use that UNH free open-access list or no?
      # https://quantmarineecolab.github.io/lab-manual/10-producing-quality-work.html#where-to-publish
  # SHOULD I PULL IN DAILY TEMPERATURE DATA
  # % canopy cover
  # Random effects on Desa and site type even though sampled an even amount (-1 lost datapoint)
  # Give quick intro to data and types

# BEFORE SUBMISSION
# Come up with some journal ideas - CHECK PROPOSAL
# HOW TO CONSIDER VIDEO TIME AND VISIBILITY?
# Test if to use time of day or month
# MODEL TESTS: VIF (Variance Inflation Factor) after an initial model fit — VIF > 5–10 is a warning sign. 
#   always inspect each smooth's effective degrees of freedom (edf): if edf ≈ 1
#   Samples are pseudorepolicated in Desa and Habitat type.
# Rerun all cleaning cause you changed some data
# CALLIE EMAIL

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

m1.2 <- gam(MAXN_TOTAL ~ # QQ PLOT TOO STEEP. TESTING OTHER DISTRIBUTIONS
              s(TIME_DROPPED, bs = "cc", k = 15) +   # cyclic smooth for time of day
              s(TIDE_HEIGHT, k = 15) +
              s(VEGITATION, k = 15) +
              # Month +
              s(SITE_TYPE, bs = 're') +               # ordered factor
              s(DESA, bs = 're') +                       # nominal factor
              as.factor(WEATHER_CAT),
            family = nb(),
            method = "REML",
            data = URUV_model)

# summary(m1.2)

gam.check(m1.2, rep = 500) # rep creates confidence intervals on QQ plot

# NOTES: 
# CHANGED MODEL TO NEG BINOMIAL BECAUSE THIS GREATLY IMPROVED THE QQ PLOT
# CHANGED K'S TO 15 TO INCREASE K INDEX TO ALMOST 1 (SOME ARE STILL SLIGHTLY BELOW 1 BUT NOT SIGNFICANTLY)
# WE'RE NOT SEEING A PERFECT FIT BECAUSE WE DO HAVE ONE OUTLIER DATAPOINT (SHOW HISTOGRAM OF DATA)
#     REMOVING THE OUTLIER FIXES THE RESIDUAL VS LINEAR PREDICTOR PLOT, BUT NOT REALLY THE RESPONSE VS FITTED VALUES PLOT
#     GREATLY INCREASING K IN EACH SPLINE DID NOT GREATLY IMPROVE DIAGNOSTICS. iT DID IMPROVE THE RESIDUAL VS LINEAR PREDICTOR PLOT BUT SIMILAR TO SIMPLY REMOVING THE OUTLIER


# DOES INCLUDING INTERACTION BETWEEN SITE AT DESA HELPS FITTING. THIS IMPROVED THE RESPONSE VS LINEAR PREDICTOR ISSUE BUT NOT RESPONSE VS FITTED VALUES AND OUR K INDEX IS PERFORMING POORER (ALL SPLINES LESS THAN 1). but once again, increasing k in this model didn't really improve anything
# Result of AIC shows we don't want interaction betwen desa and site type (2 df higher, 3 pt higher AIC criterion)

# Turning on select = TRUE for model selection

m1.3 <- gam(MAXN_TOTAL ~ 
              s(TIME_DROPPED, bs = "cc", k = 15) +   # cyclic smooth for time of day
              s(TIDE_HEIGHT, k = 15) +
              s(VEGITATION, k = 15) +
              # Month +
              s(SITE_TYPE, bs = 're') +               # ordered factor
              s(DESA, bs = 're') +                       # nominal factor
              as.factor(WEATHER_CAT),
            family = nb(),
            method = "REML",
            data = URUV_model,
            select = TRUE
            )


m1.3.1 <-  gam(MAXN_TOTAL ~ # testing model stuff. Still using 1.3 bc 1.3.1 doesn't outperform
                 s(TIME_DROPPED, bs = "cc", k = -1) +   # cyclic smooth for time of day
                 s(TIDE_HEIGHT, k = 15) +
                 s(VEGITATION, k = 15) +
                 # Month +
                 s(SITE_TYPE, bs = 're') +               # ordered factor
                 s(DESA, bs = 're') +                       # nominal factor
                 as.factor(WEATHER_CAT),
               family = nb(),
               method = "REML",
               data = URUV_model,
               select = TRUE)




# Check if no effect: EDF = 0ish, 
# p vals are test of null that there is flat fxn 
summary(m1.3)

# Check k index >=1, if not increase k on that spline
# Don't want a tiny pval
gam.check(m1.3, rep = 500)

# Plot partial effects
gratia::draw(m1.3, scales = 'fixed', overall_uncertainty = TRUE)

# Plot w 95% intervales
plot.gam(m1.3, seWithMean = TRUE)


# plot(m1.3, pages = 1, scheme = 2, shade = TRUE) Doesnt tell you anything plot.gam

# AIC(m1.3, m1.3.1)

# TOTAL SPECIES MODELS --------------------------------------------------------

m2.1 <- gam(NO_ALLSPECIES ~ 
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

gam.check(m2.1, rep = 500)

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