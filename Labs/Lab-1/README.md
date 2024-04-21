# Coding Lab 1

This lab will get your IV hands dirty with data from the Angrist and Krueger (1991) quarter-of-birth study. If you’re not familiar with the study, the basic idea is to use the quarter of an individual’s birth as an instrument for their years of completed when estimating effects on log wages. The idea is that for people born in the first half of the 20th century, compulsory schooling laws made it such that if you were relatively older in your grade (i.e. born in Q1 instead of Q4) you were able to drop out with relatively less schooling during this period. We’ll think about this identification strategy from a design-based perspective. 

To start, load the `angrist_krueger_mod.dta` data file into Stata or R. This is a modified subset of the original study data, with earnings from two census years (1980 and 2000). In the 1980 census we have men born in 1940-1949. In the 2000 census we have men born in 1960-1969. 

1. Using the 1980 cohort (`year`), estimate an IV regression of log wages (`lwage`) on completed years of schooling (`educ`) instrumenting with an indicator for being born in the first quarter of birth (`qob == 1`). Control for indicators for year of birth (`yob`). Report your coefficient estimate and its robust standard error. Taken at face value, how would you interpret the coefficient? 

2. Verify that IV is "reduced form over first stage" in this case. 

3. From a design perspective, what would be the reason for including year of birth dummies? Check that they are in fact necessary to include from this view.  

4. Verify that the instrument is balanced on parental income (`pwage`) in the 1980 cohort. What happens when you add `pwage` as a control? Are you surprised by anything?

5. Regress the indicator for whether the individual self-describes as an athlete in adulthood (`athlete`) on the instrument and controls in the 1980 cohort. Interpret the result: why might it make sense given the institutional context, and how might it shape how you think about the IV estimate?

6. Re-do steps 1 and 4 in the 2000 cohort. Interpret the results: why does the IV coefficient change the way it does when you add `pwage` as a control now?


