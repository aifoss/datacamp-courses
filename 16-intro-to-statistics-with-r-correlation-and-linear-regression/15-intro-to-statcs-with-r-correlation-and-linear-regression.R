################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Correlation and Linear Regression
## Date: 2016-02-10
################################################################################

################################################################################
## Ch.1: An Introduction to Correlation Coefficients
################################################################################

############################################################
## How are correlation coefficients calculated?
############################################################

## Calculation of r
## r
##  - Pearson product-moment correlation coefficient
##      - Raw score formula
##      - Z-score formula
## Sum of cross products (SP) & Covariance

## r = degree to which X and Y vary together,
##      relative to the degree to which X and Y vary independently
## r = (Covariance of X & Y) / (Variance of X & Y)

##################################################
## Manual computation of correlation coefficients
## - part 1
##################################################

## The general formula for calculating the correlation coefficient 
##  between two variables is:
##      r = cov(A,B) / S[A]*S[B],
##          where cov(A,B) is the covariance between A and B,
##          and S[A] and S[B] are the standard deviations.

# The vectors `A` and `B` have already been loaded

# Take a quick peek at both vectors
A
B

# Save the differences of each vector element with the mean 
# in a new variable
diff_A <- A - mean(A)
diff_B <- B - mean(B)

# Do the summation of the elements of the vectors 
# and divide by N-1 in order to acquire the covariance 
# between the two vectors
cov <- sum(diff_A*diff_B) / (length(A)-1)

##################################################
## Manual computation of correlation coefficients
## - part 2
##################################################

# Your workspace still contains the results of the previous exercise

# Square the differences that were found in the previous step
sq_diff_A <- diff_A * diff_A
sq_diff_B <- diff_B * diff_B

# Take the sum of the elements, divide them by N-1 
# and consequently take the square root to acquire 
# the sample standard deviations
sd_A <- sqrt(sum(sq_diff_A)/(length(A)-1))
sd_B <- sqrt(sum(sq_diff_B)/(length(B)-1))

##################################################
## Manual computation of correlation coefficients
## - part 3
##################################################

# Your workspace still contains the results of the previous exercise

# Combine all the pieces of the puzzle
correlation <- cov / (sd_A * sd_B)
correlation

# Check the validity of your result with the cor() command
cor(A, B)

############################################################
## The usefulness of correlation coefficients
############################################################

## Correlation
##  - A statistical procedure used to measure and describe the relationship
##      between two variables
##  - Correlations can range between +1 and -1
##      - +1 is a perfect positive correlation
##      - 0 is no correlation (independence)
##      - -1 is a perfect negative correlation
##  - When two variables, let's call them X and Y, are correlated,
##      then one variable can be used to predict the other variable
##      - More precisely, a person's score on X can be used to predict
##          his score on Y

## Correlation Example:
##  - Working memory capacity is strongly correlated with intelligence, or IQ,
##      in health young adults
##  - So if we know a person's IQ, then we can predict how they will do 
##      on a test of working memory

##################################################
## Creating scatterplots
##################################################

# Read data from a URL into a dataframe called PE (physical endurance)
PE <- read.table("http://assets.datacamp.com/course/Conway/Lab_Data/Stats1.13.Lab.04.txt", header=TRUE)

# Summary statistics
describe(PE)

# Scatter plots
plot(PE$age ~ PE$activeyears)
plot(PE$endurance ~ PE$activeyears)
plot(PE$endurance ~ PE$age)

##################################################
## Correlation matrix
##################################################

# PE is already loaded in

# Correlation Analysis 
round(cor(PE[2:4]), 2)

# Do some correlation tests. If the null hypothesis of no correlation 
# can be rejected on a significance level of 5%, 
# then the relationship between variables is  significantly different 
# from zero at the 95% confidence level
cor.test(PE$age, PE$activeyears)
cor.test(PE$endurance, PE$activeyears)
cor.test(PE$endurance, PE$age)

############################################################
## Points of caution
############################################################

## Correlation does not imply causation
## The magnitude of a correlation depends on many factors, including:
##  - Sampling (random and representative?)
##      - Attenuation of correlation due to a restricted range of one variable
##          - e.g., Working memory test for only above-average IQ individuals
## The magnitude of a correlation is also influenced by:
##  - Measurement of X & Y
##  - Several other assumptions
## The correlation coefficients is a sample statistic, just like the mean
##  - It may not be representative of ALL individuals

##################################################
## Non-representative data samples
##################################################

# The impact dataset is already loaded in

# Summary statistics entire dataset
describe(impact)

# Calculate correlation coefficient 
entirecorr <- round(cor(impact$vismem2, impact$vermem2), 2)

# Summary statistics subsets
describeBy(impact, impact$condition)

# Create 2 subsets: control and concussed
control <- subset(impact, condition=="control")
concussed <- subset(impact, condition=="concussed")

# Calculate correlation coefficients for each subset
controlcorr <- round(cor(control$vismem2, control$vermem2), 2)
concussedcorr <- round(cor(concussed$vismem2, concussed$vermem2), 2)

# Display all values at the same time
correlations <- cbind(entirecorr, controlcorr, concussedcorr)
correlations

################################################################################
## Ch.2: An introduction to Linear Regression
################################################################################

############################################################
## Introduction to regression
############################################################

## Regression
## A statistical analysis used to predict scores on an outcome variable,
##  based on scores on one or multiple predictor variables
##  - Simple regression: One predictor variable
##  - Multiple regression: Multiple predictors

##################################################
## Impact experiment
##################################################

## Regression involves using one or more variables, 
##  labelled independent variables, to predict the values of another variable, 
##  the dependent variable. Variables that are strongly correlated 
##  with the dependent variable would therefore be useful for predicting 
##  that variable.

# The dataset `impact` is already loaded

# Look at the dataset. Note that the variables we are interested in are on the 9th to 14th columns
impact

# Create a correlation matrix for the dataset
correlations <- cor(impact[9:14])

# Create the scatterplot matrix for the dataset
corrplot(correlations)

############################################################
## Regression equations and the R-squared value
############################################################

## Impact Data Example
## For this sample, assume:
##  - Symptom Score is the outcome variable
##  - Simple regression example:
##      - Predict Symptom Score from just one variable
##  - Multiple regression example:
##      - Predict Symptom Score from two variables

## Regression Equation
## Y = m + bX + e
##  - Y is a linear function of X
##  - m = intercept
##  - b = slope
##  - e = error (residual)
## Y = B[0] + B[1]X[1] + e
##  - Y is a linear function of X[1]
##  - B[0] = intercept = regression constant
##  - B[1] = slope = regression coefficient
##  - e = error (residual)

## Model R and R^2
## R = multiple correlation coefficient
##  - R = r[Y-hat][Y]
##  - The correlation between the predicted scores and the observed scores
## R^2
##  - The percentage of variance in Y explained by the model

## Impact Data Example
## Y = B[0] + B[1]X[1] + e
##  - Let Y = Symptom Score
##  - Let X[1] = Impulse Control
##  - Solve for B[0] and B[1]
##  - In R, function lm()

##################################################
## Manual computation of a simple linear regression
##################################################

## The general formula for the slope is:
##      B[1] = r * sd(y)/sd(x),
##          where x is the independent variable and y is the dependent variable

## The general formulat for the intercept is:
##      B[0] = mean(y) - B[1]*mean(x)

# The dataset `impact` is already loaded.

# Calculate the required means, standard deviations 
# and correlation coefficient
mean_sym2 <- mean(impact$sym2)
mean_ic2 <- mean(impact$ic2)
sd_sym2 <- sd(impact$sym2)
sd_ic2 <- sd(impact$ic2)
r <- cor(impact$ic2,impact$sym2)

# Calculate the slope
B_1 <- r * (sd_sym2)/(sd_ic2)

# Calculate the intercept
B_0 <- mean_sym2 - B_1 * mean_ic2

# Plot of ic2 against sym2
plot(impact$ic2, impact$sym2, 
     main = "Scatterplot", 
     ylab = "Symptoms", 
     xlab = "Impulse Control")

# Add the regression line
abline(B_0, B_1, col = "red")

##################################################
## Executing a simple linear regression using R
##################################################

# The dataset impact is still loaded

# Construct the regression model
model_1 <- lm(impact$sym2 ~ impact$ic2)

# Look at the results of the regression by using the summary function
summary(model_1)

# Create a scatter plot of Impulse Control against Symptom Score
plot(impact$sym2 ~ impact$ic2, 
     main = "Scatterplot", 
     ylab = "Symptoms", 
     xlab = "Impulse Control")

# Add a regression line
abline(model_1, col = "red")

##################################################
## Coefficient of impulse control
##################################################

lm(impact$sym2 ~ impact$ic2)

##################################################
## Correlation coefficient
##################################################

cor(impact$sym2, impact$ic2)

############################################################
## Multiple linear regression
############################################################

## The regression model is used to model or predict future behavior
## The goal is to produce better models so we can generate 
##  more accurate predictions

##################################################
## Executing a multiple regression in R
##################################################

## We can extend our model by introducing a second Independent Variable: 
##  Verbal Memory. This variable is also from the impact dataset, 
##  which is still loaded in your workspace. The regression equation 
##  would thus be
##      sym2 = B[0] + B[1]*ic2 + B[2]*vermem2 + e

# The impact dataset is already loaded in

# Multiple Regression
model_2 <- lm(impact$sym2 ~ impact$ic2 + impact$vermem2)

# Examine the results of the regression
summary(model_2)

# Extract the predicted values
predicted <- fitted(model_2)

# Plotting predicted scores against observed scores
plot(predicted ~ impact$sym2, 
     main = "Scatterplot", 
     xlab = "Observed Scores", 
     ylab = "Predicted Scores")
abline(lm(predicted ~ impact$sym2), col = "green")

##################################################
## Effect of adding an extra regressor
##################################################

# Compare the R^2 value of model_1 with that of model_2. 
# What does this suggest about the models?
summary(model_1)$r.squared
summary(model_2)$r.squared

################################################################################
## Ch.3: Linear Regression Models continued
################################################################################

############################################################
## Estimation of coefficients
############################################################

## Regression Equation:
##  - Y = B[0] + B[1]X[1] + e
##  - Y-hat = B[0] + B[1]X[1]
##  - Y - Y-hat = e (residual)

## The values of the coefficients (e.g., B[1]) are estimated such that
##  the regression model yields optimal predictions
##  - Minimize the residuals

## Ordinary Least Squares Estimation
##  - Minimize the sum of the squared (SS) residuals
##  - SS.RESIDUAL = SUM[(Y-Y-hat)^2]

## SS.X = Sum of Squared deviation scores (SS) in variable X
## SS.Y = Sum of Squared deviation scores (SS) in variable Y
## SP.XY = Sum of Cross Products = SS.X INTERSECT SS.Y

## Sum of Cross Products = SS of the Model
##  - SP.XY = SS.MODEL

## SS.RESIDUAL = (SS.Y - SS.MODEL)

##################################################
## Calculating the sum of squared individuals
##################################################

## To create an optimal regression model, it is necessary that the values 
##  of the coefficients are estimated to minimize the prediction error. 
##  This is equivalent to minimizing the sum of the squared residuals. 
##  Mathematically we wish to minimize
##      SS[R] = SUM[(Y-Y-hat)^2],
##          where Y are the observed values of the dependent variable
##          and Y-hat the values predicted by the model.

# The impact dataset is already loaded the workspace.

# Create a linear regression with `ic2` and `vismem2` as regressors
model_1 <- lm(impact$sym2 ~ impact$ic2 + impact$vismem2)

# Extract the predicted values
predicted_1 <- fitted(model_1)

# Calculate the squared deviation of the predicted values from the observed values
diff_1 <- impact$sym2 - predicted_1
deviation_1 <- diff_1 * diff_1 

# Sum the squared deviations
SSR_1 <- sum(deviation_1)
SSR_1

# Create a linear regression with `ic2` and `vermem2` as regressors
model_2 <- lm(impact$sym2 ~ impact$ic2 + impact$vermem2)

# Extract the predicted values
predicted_2 <- fitted(model_2)

# Calculate the squared deviation of the predicted values from the observed values
diff_2 <- impact$sym2 - predicted_2
deviation_2 <- diff_2 * diff_2

# Sum the squared deviations
SSR_2 <- sum(deviation_2)
SSR_2

############################################################
## Estimation of unstandardized and standardized regression
##  coefficients
############################################################

## Formula for the unstandardized coefficient
##  - B[1] = r * (SD[y]/SD[x])

## Formula for the standardized coefficient
##  - SD[y] = SD[x] = 1
##  - B = r * (SD[y]/SD[x])
##  - Beta = r

##################################################
## Standardized linear regression
##################################################

## Standardization is a process that involves subtracting an individual value 
##  by the population mean and then dividing by the population 
##  standard deviation. In linear regression this results in predictors 
##  that have a mean of 0 and a standard deviation of 1.

## Standardization is useful when one of the variables has a very large scale, 
##  as this may lead to regression coefficients of a very small order 
##  of magnitude. Executing a standardized linear regression in R 
##  is very similar to executing an unstandardized linear regression 
##  but involves the extra step of standardizing the variables 
##  by using the scale() function.

# The dataset `impact` is already loaded

# Create a standardized simple linear regression
model_1_z <- lm(scale(impact$sym2) ~ scale(impact$ic2))

#Look at the output of this regression model
summary(model_1_z)

# Extract the R-Squared value for this regression
r_square_1 <- summary(model_1_z)$r.square

#Calculate the correlation coefficient
corr_coef_1 <- sqrt(r_square_1)

# Create a standardized multiple linear regression
model_2_z <- lm(scale(impact$sym2) 
                ~ scale(impact$ic2) + scale(impact$vismem2))

# Look at the output of this regression model
summary(model_2_z)

# Extract the R-Squared value for this regression
r_square_2 <- summary(model_2_z)$r.square

# Calculate the correlation coefficient
corr_coef_2 <- sqrt(r_square_2)

############################################################
## Assumptions of linear regression
############################################################

## Assumption of linear regression
##  - Normal distribution for Y
##  - Linear relationship between X and Y
##  - Homoscedasticity
##  - Reliability of X and Y
##  - Validity of X and Y
##  - Random and representative sampling

############################################################
## Anscombe's quartet
############################################################

## To test assumptions, save resituals
##  - Y = B[0] + B[1]X[1] + e
##  - e = Y - Y-hat
## Then examine a scatterplot with
##  - X on the X-asis
##  - Residuals on the Y-axis

##################################################
## Plotting residuals
##################################################

# Extract the residuals from the model
residual <- resid(model_2)

# Draw a histogram of the residuals
hist(residual)

# Extract the predicted symptom scores from the model
predicted <- fitted(model_2)

# Plot the residuals against the predicted symptom scores
plot(residual ~ predicted, 
     main = "Scatterplot", 
     xlab = "Model 2 Predicted Scores", 
     ylab = "Model 2 Residuals")
abline(lm(residual ~ predicted), col="red")

################################################################################