################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Student's T-test
## Date: 2016-02-07
################################################################################

################################################################################
## Chapter 1: Introduction to t-tests
################################################################################

############################################################
## An introduction to t-tests
############################################################

## 4 kinds of tests that compare means:
## - z-test
##      - when comparing a sample mean to a population mean
##          and the standard deviation of the population is known
## - t-test (single sample)
##      - when comparing a sample mean to a population mean
##          and the standard deviation of the population is not known
## - t-test (dependent)
##      - when evaluating the difference between two related samples
## - t-test (independent)
##      - when evaluating the difference between two independent samples

## z = (Observed - Expected) / SE
## t = (Observed - Expected) / SE

## SE = SD / sqrt(N)

##                       Observed        Expected           SE
## z                     Sample mean     Population mean    SE of the mean
## t (single sample)     Sample mean     Population mean    SE of the mean
## t (dependent)         Sample mean     Population mean    SE of the mean
##                       of difference   of difference      difference
##                       scores          scores
## t (independent)       Difference      Difference         SE of the difference
##                       between two     between two        bewteen Ms
##                       sample means    population means

############################################################
## P-values for z-tests and t-tests
############################################################

## Exact p-value depends on:
##  - Directional or non-directional test
##  - Degrees of freedom (df)
##      Different t-distributions for different sample sizes

##                      df
## z                    NA
## t (single sample)    N-1
## t (dependent)        N-1
## t (independent)      (N1-1) + (N2-1)

##################################################
## Single sample t-tests
##################################################

## Null Hypothesis Signficance Testing (NHST)

##################################################
## Generate density plots of different 
## t-distributions
##################################################

# Generate a vector of 100 values between -4 and 4
x <- seq(-4, 4, length = 100)

# Simulate the t-distribution
# Create densities for df values 4, 6, 8, 10, 12
y_1 <- dt(x, 4)
y_2 <- dt(x, 6)
y_3 <- dt(x, 8)
y_4 <- dt(x, 10)
y_5 <- dt(x, 12)

# Plot the t-distributions
plot(x, y_1, 
     type = "l", lwd = 2, 
     xlab = "T value", ylab = "Density", 
     main = "Comparison of t-distributions")
lines(x, y_2, col = "red")
lines(x, y_3, col = "orange")
lines(x, y_4, col = "green")
lines(x, y_5, col = "blue")

# Add a legend
legend("topright", 
       c("df = 4", "df = 6", "df = 8", "df = 10", "df = 12"), 
       title = "T distributions", 
       col = c("black", "red", "orange", "green", "blue"), 
       lty = 1)

############################################################
## Dependent t-tests
############################################################

## Also known as paired samples t-test.
## Appropriate when the same subjects are being compared.
##      e.g., pre/post design
## Or when two samples are matched at the level of individual subjects.
##      Allowing for a difference score to be calculated

## A thorough analysis will include:
##  - t-value
##  - p-value
##  - Cohen's d (effect size)
##  - Confidence interval (interval estimate)

## t-value
##  - t = (Observed - Expected) / SE
##  - t = (M - 0) / SE = M / SE

## p-value
##  - Based on t-value and the t-distribution
##  - Directional or non-directional test

## Cohen's d
##  - d = M / SD

## Confidence interval
##  - Upper bound = M + t(SE)
##  - Lower bound = M - t(SE)
##  - t-value depends on level of confidence and t-distribution.

##################################################
## The working memory dataset
##################################################

# Take a look at the dataset
wm

# Create a subset for the data that contains information 
# on those subject who trained
wm_t <- subset(wm, train==1)

# Summary statistics 
describe(wm_t)

# Create a boxplot with pre- and post-training groups 
boxplot(wm_t$pre, wm_t$post, 
        main = "Boxplot", 
        xlab = "Pre and Post Training", 
        ylab = "Intelligence Score", 
        col = c("red", "green"))

##################################################
## Performing dependent t-tests manually in R (1)
##################################################

## Conducting a dependent t-test, also known as a paired t-test, requires:
##   - defining your null and alternative hypotheses
##   - calculating the degrees of freedom
##   - deciding the significance level α
##   - finding the critical value
##   - calculating the t-value

## The formula for t-value is:
##      t = XD / SE = XD / (SD / sqrt(N))
##          where XD is the mean difference between the two groups,
##          SD is the standard deviation of the mean difference,
##          and N is the sample size.

## The standard deviation is calculated as:
##      SD = sqrt[SUM((diff-mean_diff)^2) / (N-1)]
##          where XD is the difference between scores.

## A two-tailed hypothesis tests whether or not there is a difference
##      between groups, but does not specify the direction of the effect.

## Before performing a two-tailed hypothesis test as to whether or not
##   the difference between the post and pre traning groups is significantly
##   different from zero, you will start off easily by computing some
##   preliminary steps.
## Us significance level of 5 percent throughout this example.

# Define the sample size
n <- dim(wm_t)[1]

#Calculate the degrees of freedom
df <- n-1

# Find the critical t-value by using qt(alpha, df)
# for two-tailed t-test
alpha <- .05 # significance level
t_crit <- abs(qt(alpha/2, df))

# Calculate the mean of the difference in scores. 
# The differences are already in the dataset under the column 'gain'.
mean_diff <- sum(wm_t$gain)/n ## XD

# Calculate the standard deviation
diff <- wm_t$gain - mean_diff
diff_squared <- diff * diff
sum_of_diff_squared <- sum(diff_squared)
sd_diff <- sqrt(sum_of_diff_squared/df)

##################################################
## Performing dependent t-tests manually in R (2)
##################################################

## The confidence interval is calculated by means of the following formula:
##      XD +- t_crit * (SD/sqrt(N))

## Test the null hypothesis that the difference in intelligence gain
##   between the post and pre training groups is equal to zero
##   against the alternative hypothesis that there exists a significant
##   difference betwen both groups at the 95% confidence level.
## Afterwards compute the confidence interval for the mean of the differences
##   in intelligence gain between groups and Cohen's d.

# The variables from the previous exercise are still preloaded, type ls() in the console to see them

# Calculate the t-value for this test
t_value <- mean_diff / (sd / sqrt(n))

# Check whether or not the mean difference is statistically significant
t_value
t_crit

# Calculate the confidence interval
conf_upper <- mean_diff + t_crit * (sd / sqrt(n))
conf_lower <- mean_diff - t_crit * (sd / sqrt(n))
conf_upper
conf_lower

# Calculate Cohen's d
cohens_d <- mean_diff / sd
cohens_d

##################################################
## Letting R do all the dirty work:
## Dependent t-tests
##################################################

# wm is already loaded in

# Conduct a paired t-test using the t.test function
t.test(wm_t$post, wm_t$pre, paired=T) 

# Calculate Cohen's d
cohensD(wm_t$post, wm_t$pre, method="paired")

################################################################################
## Chapter 2: Independent t-tests
################################################################################

############################################################
## Independent t-tests
############################################################

## Compares two independent samples.

## A thorough analysis will include:
##  - t-value
##  - p-value
##  - Cohen's d (effect size)
##  - Confidence interval (interval estimate)

## t-value
##  - t = (Observed - Expected) / SE
##  - t = (M1 - M2) / SE
##  - SE = (SE1 + SE2) / 2

## p-value
##  - Based on t-value and the t-distribution
##  - Directional or non-directional test

## Cohen's d
##  - d = (M1 - M2) / SD pooled
##  - SD pooled = (SD1 + SD2) / 2

## Confidence interval
##  - Upper bound = M + t(SE)
##  - Lower bound = M - t(SE)
##  - t-value depends on level of confidence and t-distribution.

## Homogeneity of Variance Assumption
##  - The pooled SD is appropriate only if the variances in the two groups
##      are equivalent
##  - If not, then the homogeneity of variance assumption is violated.
##      - Simulations indicate this results in an increase in the probability
##          of a Type I error.
##  - How to detect a violation:
##      - Conduct Levene's test
##          - If significant, then the homegeneity of variance assumption
##              is violated.
##  - What to do if violated?
##      - Adjust df and p-value (Welch's procedure)
##      - Use a non-parametric test

##################################################
## Preliminary statistics
##################################################

# The dataset wm_t is already loaded. Familiarize yourself with it.
wm_t

# Create subsets for each training time
wm_t08 <- subset(wm_t, cond=="t08")
wm_t12 <- subset(wm_t, cond=="t12")
wm_t17 <- subset(wm_t, cond=="t17")
wm_t19 <- subset(wm_t, cond=="t19")

# Summary statistics of the change in training scores before and after exercise
describe(wm_t08)
describe(wm_t12)
describe(wm_t17)
describe(wm_t19)

# Create a boxplot of the different training times
ggplot(wm_t, aes(x = cond, y = gain, fill = cond)) + geom_boxplot()

# Levene's test
leveneTest(wm_t$gain~wm_t$cond)

##################################################
## Conducting an independent t-test manually (1)
##################################################

## You will test whether or not the null hypothesis holds that the difference
##   in intelligence score gain between the group that trained for 8 days
##   and the group that trained for 19 days is equal to zero.
## If not, the null can be rejected in favor of the alternative hypothesis,
##   which would imply a significant difference in intelligence gain
##   between both training methods.
## Do this hypothesis test at the 95% confidence level (alpha=0.05).

## The formula for the t-value is:
##      t = XD / SE,
##          where XD is the difference between the two group means
##          and SE is the pooled standard error.

## The standard error is the sum of standard errors for each group divided by 2.
##      sqrt((var-n1/n1)+(var-n2/n2)),
##          where n1 is the size of the first group 
##          and n2 is the size of the second group.

## The formula for the degrees of freedom is now:
##      n1 + n2 - 2

# The subsets wm_t08 and wm_t19 are still loaded in

# Calculate mean difference by subtracting the gain for t08 by the gain for t19
mean_t08 <- sum(wm_t08$gain)/dim(wm_t08)[1]
mean_t19 <- sum(wm_t19$gain)/dim(wm_t19)[1]
mean_diff <- mean_t19 - mean_t08

# Calculate degrees of freedom
n_t08 <- dim(wm_t08)[1]
n_t19 <- dim(wm_t19)[1]
df <- n_t08 + n_t19 - 2

# Calculate the pooled standard error
diff_from_mean_t08 <- wm_t08$gain - mean_t08
diff_from_mean_t19 <- wm_t19$gain - mean_t19
diff_squared_t08 <- diff_from_mean_t08 * diff_from_mean_t08
diff_squared_t19 <- diff_from_mean_t19 * diff_from_mean_t19
sum_of_diff_squared_t08 <- sum(diff_squared_t08)
sum_of_diff_squared_t19 <- sum(diff_squared_t19)
var_t08 <- sum_of_diff_squared_t08 / (n_t08-1)
var_t19 <- sum_of_diff_squared_t19 / (n_t19-1)
se_pooled <- sqrt((var_t08/n_t08)+(var_t19/n_t19))

##################################################
## Conducting an independent t-test manually (2)
##################################################

## The formula for Cohen's d for independent t-tests is:
##      Cohen's d = XD / SD pooled,
##          where XD is the mean difference between the two groups
##          and SD is the pooled standard deviation.

## The pooled standard deviation is
##      SD pooled = (sd1 + sd2) / 2,
##          where sd1 is the standard deviation for the first group,
##          and sd2 is the standard deviation of the second group.

# All variables from the previous exercises are preloaded in your workspace
# Type ls() to see them

# Calculate the t-value
t_value <- mean_diff / se_pooled

# Calculate p-value
p_value <- 2 * (1 - pt(t_value, df=df))

# Calculate Cohen's d
sd_t08 <- sqrt(var_t08)
sd_t19 <- sqrt(var_t19)
pooled_sd <- (sd_t08 + sd_t19) / 2
cohens_d <- mean_diff / pooled_sd

##################################################
## Letting R do all the dirty work:
## Indepenent t-tests
##################################################

# The subsets wm_t08 and wm_t19 are already pre-loaded in the work space

# Conduct an independent t-test 
t.test(wm_t19$gain, wm_t08$gain, var.equal=T)

# Calculate Cohen's d
cohensD(wm_t19$gain, wm_t08$gain, method="pooled")

################################################################################