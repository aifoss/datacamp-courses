################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Repeated Measures Anova
## Date: 2016-02-10
################################################################################

################################################################################
## Ch.1: An Introduction to Repeated Measures
################################################################################

############################################################
## Introduction
############################################################

##################################################
## Difference manipulation between groups
##  and within groups
##################################################

## Manipulation between groups means that each subject is randomly assigned
##  to one group or one condition, whereas manipulation within groups means
##  that you use the same subjects in each group so you use repeated measures.

############################################################
## Examples
############################################################

## Example 1: Manipulation within groups
## You want to test the effect of alcohol on test scores of students.
## There are three conditions: the student consumed no alcohol, two glasses
##  of beer, or five glasses of beer.
## How much each participant studied for the test and alcohol tolerance
##  should be considered somehow.

## Example 2: Manipulation between groups
## You want to investigate the effects of fertilizers upon plant growth.
## Assume you have two different fertilizers, A and B.
## Consider three conditions: you give the plant no fertilizer (control),
##  fertilizer A (A), or fertilizer B (B).
## You measure the height of the plant after a specific period to see
##  whether the fertilizers perform an effect.

##################################################
## Introduction example - data exploration
##################################################

# Define the variable subject as a categorical variable
wm$subject <- factor(wm$subject)

# Summary statistics by all groups (8 sessions, 12 sessions, 17 sessions, 
# 19 sessions)
describeBy(wm, wm$condition)

# Boxplot IQ versus condition
boxplot(wm$iq ~ wm$condition, 
        main="Boxplot",
        xlab="Training sessions",
        ylab="IQ")

# Illustration data, each line represents the development of each subject 
# by number of trainings
ggplot(data = wm, 
       aes(x = wm$condition, y = wm$iq, 
           group = wm$subject, colour = wm$subject)) + 
    geom_line() + 
    geom_point()

############################################################
## Pros
############################################################

## Pros:
##  - Less cost (fewer subjects required)
##  - More statistical power

## More statistical power
##  - Variance across subjects may be systematic
##  - If so, it will not contribute to the error term in repeated measures

############################################################
## Cons - counterbalancing
############################################################

## Cons:
##  - Order effects
##  - Counterbalancing
##  - Missing data
##  - Extra assumption

## Counterbalancing
## Consider a simple design with just two conditions, A1 and A2.
## One approach is a Blocked Design
##  - Subjects are randomly assigned to one of two "order" conditions:
##      - A1, A2
##      - A2, A1
## Another approach is a Randomized Design
##  - Conditions are presented randomly in a mixed fashion:
##      - A2, A1, A1, A2, A2, A1, A2, ...

##################################################
## Example counterbalancing
##################################################

## Suppose you have 3 levels of an independent variable A and a blocked design.
## You want to use full counterbalancing to take into account order effects.
## what are all the possible orders that you need to use?

## (A1,A2,A3), (A1,A3,A2), (A2,A1,A3), (A2,A3,A1), (A3,A1,A2), (A3,A2,A1)

##################################################
## Number of order conditions?
##################################################

## Assume the number of levels of the independent variable goes up
##  and you want to completely counterbalance.
## What will happen to the number of order conditions you'll need?

## That number becomes really large. An independent variable with n levels
##  will have n! order conditions.

##################################################
## Latin Squares design
##################################################

## Another possible solution is the Latin Squares design, which is
##  the most common workaround for this problem.
## You do not completely counterbalance but you put every condition
##  at every position (at least) once.

## Which of the following examples has been constructed according to
##  the "Latin Squares" design?

## (A1,A2,A3), (A2,A3,A1), (A3,A1,A2)

##################################################
## Latin Squares design:
## The number of order conditions
##################################################

## What is the number of order conditions in a "Latin Squares" design?

## The number of order conditions is always equal to the number of levels
##  of your independent variable.

############################################################
## Cons - Missing data
############################################################

## Missing data ~ Relative amount
## How much is a lot?
##  - No hard and fast rules
##  - A rule of thumb is
##      - Less than 10% on any one variable, OK
##      - Greater than 10%, not OK

## Missing data ~ Pattern?
## Is the pattern random or lawful?
##  - This can easily be detected
##  - For any variable of interest (X) create a new variable (XM)
##      - XM = 0 if X is missing
##      - XM = 1 if X is not missing
##  - Conduct a t-test with XM as the IV
##  - If significant, then pattern of missing data *may* be lawful

## Missing data ~ Remedies
## Drop all cases without a perfect profile
##  - Drastic
##  - Use only if you can afford it
## Keep all cases and estimate the values of the missing data points
##  - There are several options for how to estimate values
##      - e.g., Use multiple regression

##################################################
## Why is missing data a problem?
##################################################

## Why is missing data a problem with repeated measures?

## Because in between-groups design, it is OK to have a slightly different 
##  number of subjects in each group, so if one subject drops out
##  in one of the conditions then that group has just one less number
##  of subjects.

############################################################
## Cons - Sphericity assumption
############################################################

## Sphericity Assumption
##  - Homogeneity of variance
##  - Homogeneity of covariance

## How to test?
##  - Mauchly's test
##      - If significant, then report an adjusted p-value
##          - Greenhouse-Geisser
##          - Huyn-Feldt

##################################################
## Homogeneity of covariance?
##################################################

## What does homogeneity of covariance mean?

## The correlations between the levels should approximately be the same.

##################################################
## Mauchly's test
##################################################

## To do Mauchly's test, you can make use of R function mauchly.test().
## The input arguments has to be an object of class SSD or mlm.

# Define iq as a data frame where each column represents a condition
iq <- cbind(wm$iq[wm$condition == "8 days"], 
            wm$iq[wm$condition == "12 days"], 
            wm$iq[wm$condition == "17 days"], 
            wm$iq[wm$condition == "19 days"]) 

# Make an mlm object
mlm <- lm(iq ~ 1)

# Mauchly's test
mauchly.test(mlm, x = ~ 1) 

##################################################
## Does the sphericity assumption hold?
##################################################

## The p-value of the test is 0.94 > 0.05, which means that 
##  the null hypothesis of the test is not rejected.
## Therefore, the sphericity assumption holds.

################################################################################
## Ch.2: Repeated Measures ANOVA
################################################################################

############################################################
## Two different designs, two different concepts
############################################################

## Between-groups design (SS)
##  - Systematic/Between (A)
##  - Unsystematic/Within (S\A)

## Repeated measures design (SS)
##  - Between (A)
##  - Subjects (S)
##  - Unsystematic (AxS)

## Error in a repeated measure design is the inconsistency of subjects
##  from one condition to another.
## Therefore:
##      F[A] = MS[A] / MS[AxS]

## MS and F
## MS[A] = SS[A] / df[A]
## MS[AxS] = SS[AxS] / df[AxS]
## F = MS[A] / MS[AxS]

##################################################
## The systematic between-groups variance
##################################################

## The formula for systematic sum of squares is
##      SS[A] = n * SUM[(Yj-Yt)^2],
##          where Yj are the group means,
##          Yt is the grand mean,
##          and n is the number of items in each group
##          with j the number of groups.

## The formulat for systematic variance is then
##      MS[A] = SS[A] / df[A]
##          where df stands for the degrees of freedom,
##              which are set equal to the number of groups - 1

## Calculate the systematic variance due to conditions

# Define number of subjects for each condition
n <- 20

# Calculate group means
y_j <- tapply(wm$IQ, wm$condition, mean)

# Calculate the grand mean
y_t <- mean(wm$IQ)

# Calculate the sum of squares
ss_cond <- n * sum((y_j-y_t)^2)

# Define the degrees of freedom for conditions
df <- 3

# Calculate the mean squares (variance)
ms_cond <- ss_cond / df

##################################################
## The subject variance
##################################################

## You will also need the error term of the repeated measures design.
## This can be calculated in a few steps:
##  - First calculate the systematic variance due to subjects SS[S].
##  - Calculate the unsystematic variance SS[SA].
##  - If you subtract these two results, you will get the error term
##      of the repeated measures design MS[RM].

## The systematic (stable) subject variance will be taken out of 
##  the error term, so the error term is reduced in comparison
##  with the bewteen-groups design.

## Calculate the systematic variance due to subjects, the data set `wm` is already loaded in 

# Define number of conditions for each subject
n <- 4

# Calculate subject means
y_j <- tapply(wm$IQ, wm$subject, mean)

# Calculate the grand mean
y_t <- mean(wm$IQ)

# Calculate the sum of squares
ss_subjects <- n * sum((y_j-y_t)^2)

# Define the degrees of freedom for subjects
df <- 19 # number of subjects - 1

# Calculate the mean squares (variance)
ms_subjects <- ss_subjects / df

##################################################
## The unsystematic within-groups variance
##################################################

## The formula for the within-groups sum of squares is given by
##      SS[S\A] = SUM((Yij-Yj)^2),
##          where Yij are the individual scores,
##          and yj are the group means,
##          with i the number of observations,
##          and j the number of groups.

## The formula for the unsystematic variance of the between-groups design
##  is given by
##      MS[S\A] = SS[S\A] / df,
##          where df = j * (i-1)

## Calculate the unsystematic variance of the between-groups design, 
## `wm` is still loaded in your workspace

# Create four subsets of the four groups, containing the IQ results
# Make the subset for the group condition = "8 days"
y_i1 <- subset(wm$IQ, wm$condition == "8 days")
# Make the subset for the group condition = "12 days"
y_i2 <- subset(wm$IQ, wm$condition == "12 days")
# Make the subset for the group condition = "17 days"
y_i3 <- subset(wm$IQ, wm$condition == "17 days")
# Make the subset for the group condition = "19 days"
y_i4 <- subset(wm$IQ, wm$condition == "19 days")

# Subtract the individual values by their group means
s_1 <- y_i1 - mean(y_i1)
s_2 <- y_i2 - mean(y_i2)
s_3 <- y_i3 - mean(y_i3)
s_4 <- y_i4 - mean(y_i4)

# Put everything back into one vector
s_t <- c(s_1, s_2, s_3, s_4)

# Calculate the within-groups sum of squares by using the vector s_t
ss_sa <- sum((s_t)^2) 

# Define the degrees of freedom
df <- 4 * 19

# Calculate the mean squares (variances)
ms_sa <- ss_sa / df

##################################################
## The unsystematic variance for the repeated
##  measures design
##################################################

## The unsystematic variance for the repeated measures design
##  is also called the error term of this design.

# Calculate the unsystematic sum of squares for repeated measures.
# This is just the unsystematic sum of squares of the between-groups design
# reduced by the stable subjects sum of squares.
# `wm`, `ss_sa` and `ss_subjects` remain available in your workspace.
ss_rm <- ss_sa - ss_subjects

# Define the degrees of freedom
df <- 3 * 19 ## (i-1)*(j-1)

# Calculate the mean squares (variances)
ms_rm <- ss_rm / df

##################################################
## F-ratio and p-value
##################################################

## The formula to calculate the F-ratio is given by
##      F = MS[A] / MS[SxA]

# `wm`, `ms_cond` and `ms_rm` remain available in your workspace

# Calculate the F-ratio
f_rat <- ms_cond / ms_rm

# Define the degrees of freedom of the F-distribution
df1 <- 3
df2 <- 3 * 19

# Calculate the p-value
p <- 1 - pf(f_rat, df1, df2)

##################################################
## Error term in a repeated measures design?
##################################################

## The error term is reduced as a function of stable subject variance. 
## So if subjects just reveal stable individual differences 
##  across an experiment then that can be contributed to subjects 
##  and that gets taken out of the error term. 
## Therefore the error term is reduced and represents an interaction 
##  between subjects and condition.

##################################################
## Anova in R
##################################################

# `wm` is available in your workspace

# ANOVA model
model <- aov(wm$IQ ~ wm$condition + Error(wm$subject / wm$condition))

# summary model
summary(model)

##################################################
## Significant F-ratio?
##################################################

## F-value > p-value, so F-value is significant.

##################################################
## Effect size
##################################################

# Define the total sum of squares
ss_total <- ss_cond + ss_rm

# Calculate the effect size
eta_sq <- ss_cond / ss_total

############################################################
## Post-hoc tests
############################################################

##################################################
## Post-hoc test one
##################################################

# `wm` is still loaded in

# Post-hoc test: default procedure - Holm procedure
with(wm, pairwise.t.test(IQ, condition, paired = T))

##################################################
## Post-hoc test: Bonferroni
##################################################

# `wm` is still loaded in

# Post-hoc test: Bonferroni procedure
with(wm, pairwise.t.test(IQ, condition, paired = T, 
                         p.adjust.method="bonferroni"))

##################################################
## Paired t-test
##################################################

# Define two subsets containing the IQ scores for the condition group 
# "12 days" and "17 days"
cond_12days <- subset(wm$IQ, wm$condition=="12 days")
cond_17days <- subset(wm$IQ, wm$condition=="17 days")

# t-test
t.test(cond_12days, cond_17days, paired=TRUE)

############################################################
## Summary
############################################################

## Repeated measures ANOVA
## Appropriate when comparing group means
##  - 3 or more group means
##  - Same subjects tested in each condition
##  - F-test
##  - Post-hoc tests

##################################################
## Analogy between t-tests and anova
##################################################

## Which of the following statements best represents the analogy
##  between t-tests and ANOVA?
##  - The independent t-test is analogous to between-groups ANOVA
##      and the paired-sample t-test is analogous to repeated-measures ANOVA.

################################################################################