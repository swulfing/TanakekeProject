library(dplyr)
library(corrplot)
#library(hms)
library(lubridate)
library(mgcv)
library(gratia)
library(knitr)
library(kableExtra)
library(ggplot2)
library(brms)
# https://noamross.github.io/gams-in-r-course/chapter2
# Qs for easton on document
# Journal Ideas, can I use that UNH free open-access list or no?
# https://quantmarineecolab.github.io/lab-manual/10-producing-quality-work.html#where-to-publish
# SHOULD I PULL IN DAILY TEMPERATURE DATA
# % canopy cover
# Random effects on Desa and site type even though sampled an even amount (-1 lost datapoint)
# Give quick intro to data and types

# BEFORE SUBMISSION
# Give some overall goal explanation
# Send AIS Crab vids
# Come up with some journal ideas - CHECK PROPOSAL
# MODEL TESTS: VIF (Variance Inflation Factor) after an initial model fit — VIF > 5–10 is a warning sign. 
#   always inspect each smooth's effective degrees of freedom (edf): if edf ≈ 1
# CALLIE EMAIL


setwd('C:/Users/swulfing/Documents/GitHub/TanakekeProject/URUVS/Datasheets')
URUV_data <- read.csv('MasterRecordingData_clean.csv')

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

# Fixing time variables and making factors
URUV_model$TIME_DROPPED <- period_to_seconds(lubridate::hms(URUV_model$TIME_DROPPED))
URUV_model$MONTH <- factor(URUV_model$MONTH, levels = c("JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE",
                                                        "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"))
URUV_model$SITE_TYPE <- factor(URUV_model$SITE_TYPE, levels = c("D", "E", "L"))
URUV_model$WEATHER_CAT <- factor(URUV_model$WEATHER_CAT, levels = c("SUNNY", "CLOUDY", "RAINY"))
URUV_model$DESA <- factor(URUV_model$DESA)

URUV_model_cont <- URUV_model %>%
  select(-c('MONTH', 'WEATHER_CAT', 'WEATHER', 'DESA', 'SITENAME_COMBINE', 'TIDE_DIRECTION', "SITE_TYPE"))


library(brms)
library(tidyverse)
library(bayesplot)
library(tidybayes)


URUV_simpson <- URUV_model %>%
  mutate(
    TimeOfDay_s      = as.numeric(scale(TIME_DROPPED)),
    Visibility_s     = as.numeric(scale(VISIBILITY)),
    Vegetation_s     = as.numeric(scale(VEGITATION)),
    TideHeight_s     = as.numeric(scale(TIDE_HEIGHT)),
    TotalVideoTime_s = as.numeric(scale(TOTALTIME_ANALYSIS))
  )

#colSums(is.na(URUV_model))

URUV_simpson <- URUV_simpson %>%
  filter(!is.na(SIMPSON_DIV))

#colSums(is.na(URUV_simpson))


priors <- c(
  # Priors on the beta regression intercept and coefficients (logit scale)
  prior(normal(0, 2), class = "b"),               # regression coefficients
  prior(normal(0, 2), class = "Intercept"),        # intercept for mu
  
  # Prior on precision parameter (phi) - higher = less variance in beta part
  prior(gamma(2, 0.1), class = "phi"),
  
  # Priors for zero and one inflation components (logit scale)
  prior(normal(0, 2), class = "Intercept", dpar = "zoi"),   # zero-one inflation
  prior(normal(0, 2), class = "Intercept", dpar = "coi")    # conditional one inflation
)

# What these parameters mean:
#   
# mu — the mean of the Beta distribution (values strictly between 0 and 1)
# phi — precision of the Beta distribution (higher = tighter around the mean)
# zoi — probability of being a zero or one (zero-one inflation)
# coi — given it's a zero or one, probability it's a one (conditional one inflation)


URUV_simpson <- URUV_simpson[, names(URUV_simpson) != "" & !is.na(names(URUV_simpson))]

#### m2 ####

m2_simpson <- brm(
  bf(
    SIMPSON_DIV ~ 
      #s(TimeOfDay_s) +
      s(TideHeight_s) +
      s(Visibility_s, k = 8) +
      s(Vegetation_s) +
      TotalVideoTime_s +       # nuisance covariate, linear
      #MONTH +                   # ordered factor
      SITE_TYPE +             # ordered factor
      DESA +                    # nominal factor
      WEATHER_CAT,
    
    # Optionally model zero-one inflation as a function of predictors too
    zoi ~ TotalVideoTime_s + Visibility_s,   # fewer observations = more zeros
    coi ~ 1                                   # simple intercept for ones
  ),
  
  data = URUV_simpson,
  family = zero_one_inflated_beta(),
  prior = priors,
  
  # Sampler settings
  chains = 4,          # 4 independent MCMC chains
  iter = 4000,         # iterations per chain (2000 warmup + 2000 sampling)
  warmup = 2000,
  cores = 4,           # parallel processing
  seed = 123,          # reproducibility
  
  control = list(
    adapt_delta = 0.99,    # increase if you get divergent transitions: I got two so increasing to 0.99 which seems to have worked
    max_treedepth = 12     # increase if you get max treedepth warnings
  )
)

summary(m2_simpson)
# Rhat = 1
# Bulk_ESS: 12404
# Tail_ESS: 6278
# According to claudia, rhat should be close to 1 and then the ESSs should be >1000

mcmc_trace(m2_simpson, 
           pars = c("b_Intercept", "phi", "b_zoi_Intercept")) # traceplots look good


# Check for divergent transitions (should be 0 or very few)
nuts_params(m2_simpson) %>% 
  filter(Parameter == "divergent__") %>% 
  summarise(total_divergences = sum(Value)) #0 total divergences


# Posterior Predictive Check

# Overall distribution check
pp_check(m2_simpson, ndraws = 100)

# Specifically check the zeros and ones are being captured
pp_check(m2_simpson, type = "stat", stat = function(y) mean(y == 0))
pp_check(m2_simpson, type = "stat", stat = function(y) mean(y == 1)) # I think these all look good, observed statistic falls within simulataed vals



# Conditional effects plots (equivalent to GAM smooth plots)
plot(conditional_effects(m2_simpson), ask = FALSE)

# For the smooth terms specifically
conditional_effects(m2_simpson, effects = "TideHeight_s")
conditional_effects(m2_simpson, effects = "Visibility_s")

# Extract posterior summaries yeah idk what this is telling me
as_draws_df(m2_simpson) %>%
  select(starts_with("b_")) %>%
  summarise(across(everything(), 
                   list(mean = mean, 
                        lower = ~quantile(.x, 0.025),
                        upper = ~quantile(.x, 0.975))))

# MOdel comparison using LOO: LOO estimates out-of-sample predictive accuracy without actually refitting the model repeatedly, using Pareto-smoothed importance sampling (PSIS).

# Add LOO criterion to your fitted model
m2_simpson <- add_criterion(m2_simpson, "loo") #, moment_match = TRUE)

loo(m2_simpson)

# elpd_loo — the main metric, higher is better
# looic — like AIC but Bayesian, lower is better
# p_loo — effective parameters; if this is close to or exceeds the actual number of parameters, the model may be misspecified


plot(loo(m2_simpson)) # most of my k values are below 0.5 so I think that's good?


# Find the problematic observations
loo_result <- loo(m2_simpson)
pareto_k_ids <- which(loo_result$diagnostics$pareto_k > 0.7)
URUV_simpson[pareto_k_ids, ]   # inspect these rows. IDK this seems fine to me

# THen can start checking alternative models by:
# Define new model
# add_criterion(modelname, 'loo')
# loo_compare(model names) will result in a ranking of the models. Claude then goes into deets about this interpretation when we get here