library(fixest)
library(haven)

# Setup data ----
data = read_dta("angrist_krueger_mod.dta")
data$z = (data$qob == 1)
data_1980 = subset(data, year == 1980)
data_2000 = subset(data, year == 2000)

# Basline IV, RF, and FS ----
baseline_2sls = feols(
  lwage ~ 1 | yob | educ ~ i(z), 
  data = data_1980, vcov = "hc1"
)
baseline_rf = feols(
  lwage ~ i(z) | yob, 
  data = data_1980, vcov = "hc1"
)
baseline_fs = feols(
  educ ~ i(z) | yob, 
  data = data_1980, vcov = "hc1"
)
etable(
  baseline_2sls, baseline_rf, baseline_fs,
  headers = c("2SLS", "Reduced Form", "First Stage")
)

# Check assignment varies by year ----
feols(
  z ~ i(yob), 
  data = data_1980, vcov = "hc1"
)


# Check balance on parental income ----
feols(
  pwage ~ z + i(yob),
  data = data_1980, vcov = "hc1"
)
feols(
  lwage ~ pwage | yob | educ ~ i(z), 
  data = data_1980, vcov = "hc1"
)


# Check exclusion on athelete status ----
feols(
  athlete ~ z + i(yob), 
  data = data_1980, vcov = "hc1"
)


# New data IV and balance ----
feols( 
  lwage ~ 1 | yob | educ ~ z, 
  data = data_2000, vcov = "hc1"
)
feols( 
  pwage ~ i(z) | yob, 
  data = data_2000, vcov = "hc1"
)
feols( 
  lwage ~ pwage | yob | educ ~ z, 
  data = data_2000, vcov = "hc1"
)

