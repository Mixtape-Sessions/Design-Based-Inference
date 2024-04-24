# Coding Lab 2

This lab will help practice some practical points from today with data from [Almond, Chay, and Lee (2005)](Readings/Almond_Chay_Lee_2005.pdf). We’re going to use these data to estimate the effect of smoking during pregnancy on child birthweight. To start, load the `almond_chay_lee.dta` data file into Stata or R. This is a modified subset of the original study data, with birthweight (`bweight`), an indicator for whether or not the mother smoked while pregnant (`smoked`), and demographic characteristics of the mother (`agem`, `blackm`, `educm`, and `marm`).

1. Use a simple regression to estimate the treatment effect, assuming selection on observables. Taken at face value, how would you interpret the estimated effect? Compare the estimate to a more naïve regression which doesn’t control for demographics. Interpret the result in terms of possible selection bias.
 
2. Verify the Frisch-Waugh-Lovell Theorem applies to your controlled regression.
 
3. Compute the "ex post" weights for the controlled regression. Are there negative weights?
 
4. Generate groups from the unique values of the demographics: i.e. generate a strata variable where all mothers in a stratum have the same value of `agem`, `blackm`, `educm`, and `marm`. Estimate the treatment effect by regression, controlling for strata fixed effects. Does the linear specification in 1 appear to be "flexible enough"?
 
5. Compute the "ex ante" weights for the strata-controlled regression, assuming treatment is independent of potential outcomes within strata and using the fact of $Var(x \ |\  w)=E[x \ |\  w](1 - E[x \ |\  w])$ when $x$ is binary. Plot the distribution of ex ante weights. Is it roughly uniform?
 
6. Use your favorite propensity score method (e.g. matching or weighting) to estimate the ATE. Compare your estimated effect to the corresponding regression estimate. Are you surprised?
 
7. The data also includes a variable indicating which hospital the mother gave birth at (`hospital`). People who give birth at the same hospital likely have clustered unobservables. Explain why this need not make you cluster your standard errors, and verify indeed that clustering by hospital does not meaningfully change your inferences.
