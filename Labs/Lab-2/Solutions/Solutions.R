library(fixest)
library(haven)
library(tidyverse)
library(WeightIt)

# Setup data ----
data = read_dta("almond_chay_lee.dta")


# Baseline regressions ----
setFixest_fml(..covs = ~ blackm + educm + marm + agem)
baseline_1 = feols(bweight ~ smoked, data, vcov = "hc1")
baseline_2 = feols(bweight ~ smoked + ..covs, data, vcov = "hc1")
etable(baseline_1, baseline_2)


# FWL check ----
data$smoked_r = resid(feols(smoked ~ ..covs, data))
feols(bweight ~ smoked_r, data)


# Ex post weights ----
num = data$smoked * data$smoked_r
data$psi = num / sum(num)
summary(data$psi)
summary(data$smoked_r[data$smoked == 0])
summary(data$smoked_r[data$smoked == 1])


# Richer controls ----
# fixest has a fast version of creating group index
data$strata = fixest::to_integer(data$blackm, data$educm, data$marm, data$agem)

feols(bweight ~ smoked | strata, data) 


# Ex ante weights ----
est = feols(smoked ~ 0 | strata, data, fixef.rm = "singleton")
data$smoked_bar = predict(est, newdata = data)

num = data$smoked_bar * (1 - data$smoked_bar)
# fixed-effect could not be estimated
num = ifelse(is.na(data$smoked_bar), 0, num)
data$phi = num / sum(num)

plot(density(data$phi))


# ATE estimation ----
w = weightit(
  fixest::xpd(smoked ~ ..covs), 
  data = data, estimand = "ATT"
)
lm_weightit(bweight ~ smoked, data = data, weightit = w)


# Hospital clustering ----
feols(bweight ~ smoked + ..covs, data, cluster = ~hospital)

