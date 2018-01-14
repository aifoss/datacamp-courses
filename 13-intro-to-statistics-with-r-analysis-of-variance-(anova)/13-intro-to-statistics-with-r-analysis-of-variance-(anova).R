################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Analysis of Variance (ANOVA)
## Date: 2016-02-09
################################################################################

################################################################################
## Ch.1: An Introduction to ANOVA
################################################################################

############################################################
## Introduction to ANOVA
############################################################

## Appropriate when the predictors (IVs) are all categorical
##  and the outcome (DV) is continuous.
##  - Most common application is to analyze data from randomized
##      controlled experiemnts.

## More specifically, randomized controlled experiments that generate
##  more than two group means
##  - If only two group means, then us:
##      - Independent t-test
##      - Dependent t-test

## If more than two group means, then use:
##  - Between groups ANOVA
##  - Repeated measures ANOVA

## Example: Working memory training
##  - 4 independent groups (8, 12, 17, 19 training sessions)
##      - IV: Number of training sessions
##      - DV: IQ gain
##  - Null hypothesis: All groups are equal

##################################################
## Working memory experiment
##################################################

# Summary statistics by all groups (8 sessions, 12 sessions, 17 sessions, 
## 19 sessions)
describeBy(WM, WM$condition)

# Boxplot IQ versus cond
boxplot(WM$IQ ~ WM$condition, main="Boxplot", xlab="Group (cond)", ylab="IQ")

############################################################
## Exploration of the F-test
############################################################

## Analysis of Variance (ANOVA)
## Typically involes NHST
## The test statistic is the F-test (F-ratio)
##  - F = Variance between groups / Variance within groups

## Like the t-test and family of t-distributions
## The F-test has a family of F-distributions
##  - The distribution to assume depends on:
##      - Number of subjects per group
##      - Number of groups

##################################################
## Generate density plot of the F-distribution
##################################################

# Create the vector x
x <- seq(from=0, to=2, length=100)

# Simulate the F-distributions
## df(x, df1, df2)
y_1 <- df(x, 1, 1)
y_2 <- df(x, 3, 1)
y_3 <- df(x, 6, 1)
y_4 <- df(x, 3, 3)
y_5 <- df(x, 6, 3)
y_6 <- df(x, 3, 6)
y_7 <- df(x, 6, 6)

# Plot the F-distributions
plot(x, y_1, col = 1, "l")

lines(x, y_2, col = 2, "l")
lines(x, y_3, col = 3, "l")
lines(x, y_4, col = 4, "l")
lines(x, y_5, col = 5, "l")
lines(x, y_6, col = 6, "l")
lines(x, y_7, col = 7, "l")

# Add the legend in the top right corner and with the title 'F distributions'
legend("topright", 
       c("df = (1,1)", "df = (3,1)", "df = (6,1)", "df = (3,3)", 
         "df = (6,3)", "df = (3,6)", "df = (6,6)"),  
       title="F distributions", 
       col = c(1,2,3,4,5,6,7), 
       lty = 1)

##################################################
## Why is the F-distribution always positive?
##################################################

## F-distribution is always positive because the variances are always
##  positive, and consequently a ratio of variances is always positive.

############################################################
## Calculating the sum of squares
############################################################

## One-way ANOVA
## F-ratio:
##  - F = betwen-groups variance / within-groups variance
##  - F = MS (Mean Squares) between / MS within
##  - F = MS [A] / MS [S\A]

## MS [A] = SS [A] / df [A]
## MS [S/A] = SS [S\A] / df [S\A]

## df [A] = # of groups - 1
## df [S\A] = # of subjects in a group * # of groups

##################################################
## Between group sum of squares
##################################################

## The formula for the caluation of between-group sum of squares is:
##      SS [A] = n * SUM [ (Yj-Yt)^2 ],
##          where Yj are the group means,
##          Yt is the grand mean,
##          and n is the number of items in each group.

# Define number of subjects in each group
n <- 20

# Calculate group means
Y_j <- tapply(WM$IQ, WM$condition, mean)

# Calculate the grand mean
Y_T <- mean(WM$IQ)

# Calculate the sum of squares
SS_A <- n * sum((Y_j-Y_T)^2)

##################################################
## Within group sum of squares
##################################################

## The formula for the caluation of within-group sum of squares is:
##      SS [S\A] = SUM [ (Yij-Yj)^2 ],
##          where Yij are the individual scores,
##          and Yj are the group means.

# Create four subsets of the four groups, containing the IQ results
# Make the subset for the group cond = "8 days"
Y_i1 <- subset(WM$IQ, WM$condition == "8 days")

# Make the subset for the group cond = "12 days"
Y_i2 <- subset(WM$IQ, WM$condition == "12 days")

# Make the subset for the group cond = "17 days"
Y_i3 <- subset(WM$IQ, WM$condition == "17 days")

# Make the subset for the group cond = "19 days"
Y_i4 <- subset(WM$IQ, WM$condition == "19 days")

# Subtract the individual values by their group means
# You have already calculated the group means in the previous exercise 
## so use this result, the vector that contains these group means 
## was called Y_j
S_1 <- Y_i1 - Y_j[1]
S_2 <- Y_i2 - Y_j[2] 

# Do it without the vector Y_j, so calculate the group means again.
S_3 <- Y_i3 - mean(Y_i3)
S_4 <- Y_i4 - mean(Y_i4)

#Put everything back in one vector
S_T <- c(S_1,S_2,S_3,S_4)

#Calculate the sum of squares by using the vector S_T
SS_SA <- sum((S_T)^2)

##################################################
## Calculating the F-ratio
##################################################

## The formula to calculate F-ratio is given by:
##      F = MS [A] / MS [S\A],
##          where MS [A] = SS [A] / df [A],
##          MS [S\A] = SS [S\A] / df [S\A],

## df [A] = a-1,
## df [S\A] = a(n-1),
##      where a = number of groups,
##      and n = number of subjects in each group.

# Number of groups
a <- 4

# Number of subject in each group
n <- 20

# Define the degrees of freedom
df_A <- a-1
df_SA <- a*(n-1)

# Calculate the mean squares (variances) by using the sum of squares 
# SS_A and SS_SA
MS_A <- SS_A / df_A
MS_SA <- SS_SA / df_SA

# Calculate the F-ratio
f_rat <- MS_A / MS_SA

############################################################
## ANOVA table
############################################################

## Summary table
## Source | SS               | df     | MS              | F
## A      | n * SUM(Yj-Yt)^2 | a-1    | SS[A]/df[A]     | MS[A]/MS[S\A]
## S\A    | SUM(Yij-Yj)^2    | a(n-1) | SS[S\A]/df[S\A] | ...
## Total  | SUM(Yij-Yt)^2    | N-1    | ...             | ...

## Effect Size
## R^2 = eta^2 (eta-squared)
## eta^2 = SS[A] / SS[Total]

## Assumptions
## DV is continuous (interval or ratio variable)
## DV is normally distributed
## Homogeneity of variance
##  - Within-groups variance is equivalent for all groups
##      - Levene's test

##################################################
## A faster way: ANOVA in R
##################################################

# WM is already loaded in

# Apply the aov function
anova.WM <- aov(WM$IQ ~ WM$condition)

# Look at the summary table of the result
summary(anova.WM)

##################################################
## Significance of the F-ratio
##################################################

## F-value vs. p-value

##################################################
## Levene's test
##################################################

# WM is already loaded in

# Levene's test
# If you do not specify any additional arguments,
# the deviation scores are calculated by comparing each score
# to its group mean.
leveneTest(WM$IQ, WM$condition)

# Levene's test with the change for the default, namely center = mean
leveneTest(WM$IQ, WM$condition, center=mean)

##################################################
## Does the assumption of homegeneity of variance
## hold?
##################################################

## Large p-value indicates that the null hypothesis cannot be rejected,
##  which means the assumption of homogeneity of varaince holds.

################################################################################
## Ch.2: Post-hoc Analysis
################################################################################

############################################################
## An introduction to post-hoc tests
############################################################

## Post-hoc tests, such as Tukey's procedure, allow for multiple pairwise
##  comparisons, without an increase in the probability of a Type I error.

## Many procedures are available; the degree to which p-values are adjusted
##  varies according to procedure
##  - Most liberal: No adjustment
##  - Most conservative: Bonferroni procedure

## NHST Review
##                   Experiemntal Decision
##                   Retain H0             Reject H0 
##        H0 true    Correct Decision      Type I error (False alarm)
## Truth                                   p = 0.05
##        H0 false   Type II error (miss)  Correct Decision

##################################################
## The necessity of post-hoc tests
##################################################

## Post-hoc tests help you find out which groups differ significantly
##  from each other and which do not.
## More formatlly, post-hoc tests allow for multiple pairwise comparison
##  without inflating the type I error.

## Suppose the post-hoc test involves performing 3 pairwise comparisons,
##  each with the probability of a type I error at 5%.
## The probability of making at least one type I error is then equal to
##  1 - (no type I error * no type I error * no type I error).
## So, if you assume independence of these three events,
##  the familywise error rate becomes roughly 1 - (0.95 * 0.95 * 0.95)
##  = 14.26%.
## In other words, you have a probability of 14.26% to have at least
##  one false alarm.

## What is the maximum familywise error rate for the working memory experiment
##  assuming that you do all possible pairwise comparisons
##  with a type I error rate of 5%?
##  - 1 - (0.95)^6 = 26.49%

##################################################
## NHST table
##################################################

## Sensitivity and specificity are two concepts that statisticians use
##  to measure the performance of a certain statistical test.
## The sensitivity of a test can be seen as its true positive rate:
##      sensitivity 
##      = # true positives / (# true positives + # false negatives)
## The specificity of a test is its true negative rate:
##      specificity 
##      = # true negatives / (# true negatives + # false positives)

##                Condition Positive   Condition Negative
## Test Outcome          120                   25     
## Positive
##
## Test Outcome           15                  140
## Negative

## Sensitivity = 120 / (120+15) = 0.89
## Specificity = 140 / (140+25) = 0.85

##################################################
## Calculate and interpret the results of Tukey
##################################################

# Revision: Analysis of variance
anova_WM <- aov(WM$gain ~ WM$cond)

# Summary Analysis of Variance
summary(anova_WM)

# Post-hoc (Tukey)
TukeyHSD(anova_WM)

# Plot confidence intervals
plot(TukeyHSD(anova_WM))

##################################################
## Bonferroni adjusted p-values
##################################################

## Just like Tukey's procedure, the Bonferroni correction is a method
##  that is used to counteract the problem of inflated type I errors
##  while engaging in multiple pairwise comparisons between subgroups.
## Bonferroni is generally known as the most conservative method
##  to control the familywise error rate.

## Bonferroni is based on the idea that if you test N dependent
##  or independent hypotheses, one way of maintaining the familywise 
##  error rate is to test each individual hypothesis at a statistical
##  significance level that is deflated by a factor of 1/n.
## So, for a significance level for the whole family of tests of alpha,
##  the Bonferroni correction would be to test each of the individual tests
##  at a significance level of alpha/n.

# Suppose you have a p-value of 0.005 and there are 8 pairwise comparisons.
# Use the p.adjust() function while applying the Bonferroni method
#   to calculate the adjusted p-values.
# Be sure to specify the method and n values necessary to adjust the .005
#   value.
# Assign the result to bonferroni_ex.
bonferroni_ex <- p.adjust(p=0.005, method="bonferroni", n=8)
bonferroni_ex

# Make use of the pairwise.t.test() function to test the pairwise
#   comparisons between your different conditions and include the Bonferroni
#   correction in one single command.
# Do not forget to set the p.adjust argument in the pairwise.t.test() function
#   to "bonferroni".
pairwise.t.test(WM$gain, WM$cond, p.adjust="bonferroni")

################################################################################
## Ch.3: Between Group Factorial ANOVA
################################################################################

############################################################
## Introduction to factorial ANOVA: The experiment
############################################################

## Factorial ANOVA
## 2 independent variables (IVs)
## 1 dependent variable (DV)

## Suppose an experiment is conducted to examine the effect of talking
##  on a mobile while driving
##  - IV1: Driving difficulty
##  - IV2: Conversation demand
##  - DV: Driving errors

##################################################
## Starting off
##################################################

## Conversation difficulty: None, Low, High
## Driving difficulty: Easy, Difficult

## Each of the subjects was randomly assigned to one of these 6 conditions,
##  which are formed by combining different values of independent variables.
## What is the number of factor levels for each independent variable?
##  - 3, 2

##################################################
## Data exploration with a barplot
##################################################

# Use the tapply function to create your groups
ab_groups <- tapply(ab$errors, list(ab$driving, ab$conversation), sum)

# Make the required barplot
barplot(ab_groups, 
        beside = TRUE, 
        col = c("orange","blue"), 
        main = "Driving Errors", 
        xlab = "Conversation Demands", 
        ylab = "Errors")

# Add the legend
legend("topright", 
       c("Difficult", "Easy"), 
       title = "Driving", 
       fill = c("orange", "blue"))

############################################################
## Hypotheses, F ratios, and effects
############################################################

## Factorial ANOVA
## 3 hypotheses can be tested:
##  - More errors in the difficult simulator?
##  - More errors with more demanding conversation?
##  - More errors due to the interaction of driving difficulty
##      and conversation demand?

## 3 F ratios:
##  - F[A]
##  - F[B]
##  - F[AXB]


## Main Effect
## The effect of one IV averaged across the levels of the other IV
## (The effect of one IV, ignoring the other IV)

## Interaction Effect
## The effect of one IV depends on the other IV.
## (The simple effects of one IV change across the levels of the other IV.)

## Simple Effect
## The effect of one IV at a particular level of the other IV

## Main effects and interaction effect are independent from one another.

##################################################
## The homogeneity of variance assumption
##################################################

## For two independent variables, input to levenTest() function changes to:
##  leveneTest(DV ~ IV1 * IV2)

# The data frame 'ab' is preloaded in your workspace
head(ab)

# Test the homogeneity of variance assumption
leveneTest(ab$errors ~ ab$conversation * ab$driving)

##################################################
## Homogeneity of variance?
##################################################

## p-value < 0.95 implies that the null hypothesis holds.

##################################################
## The factorial ANOVA
##################################################

## aov(dependent_variable ~ independent_variable_one *
##  independent_variable_two)

# The data frame 'ab' is preloaded in your workspace
head(ab)

# Factorial ANOVA
ab_model <- aov(ab$errors ~ ab$conversation * ab$driving)

# Get the summary table
summary(ab_model)

############################################################
## Post-hoc tests and effect sizes
############################################################

## Follow-Up Tests
##  - Main effects
##      - Post-hoc tests
##  - Interaction
##      - Analysis of simple effects
##          - Conduct a series of one-way ANOVAs (or t-tests)

## Effect Size
##  - Complete eta^2
##      - eta^2 = SS[effect] / SS[total]
##  - Partial eta^2
##      - eta^2 = SS[effect] / (SS[effect]+SS[S\AB])
##      - Usually used instead of complete eta^2, because it partials out
##          systematic effects due to A and B

## Assumptions Underlying Factorial ANOVA
##  - DV is continuous (interval or ratio variable)
##  - DV is normally distributed
##  - Homogeneity of variance

##################################################
## The interaction effect
##################################################

# Create the two subsets
ab_1 <- subset(ab, driving=="Easy")
ab_2 <- subset(ab, driving=="Difficult")

# Perform the one-way ANOVA for both subsets
aov_ab_1 <- aov(ab_1$errors ~ ab_1$conversation) 
aov_ab_2 <- aov(ab_2$errors ~ ab_2$conversation)

# Get the summary tables for both aov_ab_1 and aov_ab_2
summary(aov_ab_1)
summary(aov_ab_2)

##################################################
## The effect sizes
##################################################

## etaSquared(anova_object, anova=T)

# The 'aov_ab_1' and 'aov_ab_2' variables are preloaded in your workspace

# Calculate the etaSquared for the easy driving case
etaSquared(aov_ab_1, anova=T)

# Calculate the etaSquared for the difficult driving case
etaSquared(aov_ab_2, anova=T)

##################################################
## Interpreting the etaSquared function
##################################################

## Larger value of etaSquared indicates a larger interaction effect.

##################################################
## Pairwise comparisons
##################################################

## Tukey post-hoc test in R:
## TukeyHSD(anova_object)

## Adjusted p-value less than .95 indicates statistical signficance.

# Note that 'aov_ab_1' and 'aov_ab_2' are preloaded in your workspace

# Tukey for easy driving
TukeyHSD(aov_ab_1)

# Tukey for difficult driving
TukeyHSD(aov_ab_2)

################################################################################