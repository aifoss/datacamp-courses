################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Moderation and Mediation
## Date: 2016-02-15
################################################################################


################################################################################
## Ch.1: An Introduction to Moderation
################################################################################

############################################################
## Introductino to moderation
############################################################

## Example
##  - X: Experimental manipulation
##      - Stereotype threat
##  - Y: Behavioral outcome
##      - IQ test score
##  - Z: Moderator
##      - Working memory capacity (WMC)

##################################################
## Data exploration
##################################################

# The dataset `mod` is preloaded in your R workspace.

# Summary statistics
describeBy(mod, mod$condition)

# Create a boxplot of the data
boxplot(mod$iq ~ mod$condition, 
        main="Boxplot", 
        xlab="Group condition", 
        ylab="IQ")

############################################################
## Use of moderation
############################################################

## Moderation
## A moderator variable (Z) will ehnahce a regression model
##  if the relationship between X and Y varies as a function of Z.

## Experimental Research
##  - The manipulatin of an IV (X) causes change in a DV (Y)
##  - A moderator variable (Z) implies that the effect of the IV on the DV
##      (X on Y) is NOT consistent across the distribution of Z

## Correlational Research
##  - Assume a correlation between X and Y
##  - A moderator variable (Z) implies that the correlation between X and Y
##      is not consistent across the distribution of Z

##################################################
## Calculate correlations
##################################################

## A moderator predicts that the correlation between the predictor 
##  and the outcome will change in function of the group. 
##  So if a clear change is observed in the correlations as a function of group, 
##  then this can indicate a significant moderation effect.

# Create subsets of the three groups
# Make the subset for the group condition = "control"
mod_control <- subset(mod, condition=="control")
# Make the subset for the group condition = "threat1"
mod_threat1 <- subset(mod, condition=="threat1")
# Make the subset for the group condition = "threat2"
mod_threat2 <- subset(mod, condition=="threat2")

# Calculate the correlations
cor_control <- cor(mod_control$iq, mod_control$wm)
cor_threat1 <- cor(mod_threat1$iq, mod_threat1$wm)
cor_threat2 <- cor(mod_threat2$iq, mod_threat2$wm)

############################################################
## Moderation model
############################################################

## Moderation Model
## If both X and Z are continuous
##  - Y = B[0] + B[1]X + B[2]Z + B[3](X*Z) + e
## If X is categorical (with 3 levels) and Z is continuous
##  - Y = B[0] + B[1](D1) + B[2](D2) + B[3]Z + B[4](D1*Z) + B5(D2*Z) + e

##################################################
## Model with and without moderation
##################################################

# Model without moderation (tests for "first-order effects")
model_1 <- lm(mod$iq ~ mod$wm + mod$d1 + mod$d2) 

# Make a summary of model_1
summary(model_1)

# Create new predictor variables
wm_d1 <- mod$wm * mod$d1
wm_d2 <- mod$wm * mod$d2

# Model with moderation
model_2 <- lm(mod$iq ~ mod$wm + mod$d1 + mod$d2 + wm_d1 + wm_d2)

# Make a summary of model_2
summary(model_2)

############################################################
## How to test for moderation
############################################################

## If both X and Z are continuous
##  - Model 1: No moderation
##      - Y = B[0] + B[1]X + B[2]Z + e
##  - Model 2: Moderation
##      - Y = B[0] + B[1]X + B[2]Z + B[3](X*Z) + e

## If X is categorial and Z is continuous
##  - Model 1: No moderation
##      - Y = B[0] + B[1](D1) + B[2](D2) + B[3]Z + e
##  - Model 2: Moderation
##      - Y = B[0] + B[1](D1) + B[2](D2) + B[3]Z +
##                  B[4](D1*Z) + B[5](D2*Z) + e

## Compare Model 1 and Model 2 in terms of overall variance explained,
##  that is, R^2
##  - NHST available for this comparison
## Evaluate B values for predictors associated with the moderation effect
##  - (X*Z)
##  - (D1*Z) and (D2*Z)

##################################################
## Model comparison
##################################################

# Compare model_1 and model_2
anova(model_1, model_2)

##################################################
## Scatterplot
##################################################

# Choose colors to represent the points by group
color <- c("red","green","blue")

# Illustration of the first-order effects of working memory on IQ
ggplot(mod, aes(x = wm, y = iq)) + 
    geom_smooth(method = "lm", color = "black") + 
    geom_point(aes(color = condition))

# Illustration of the moderation effect of working memory on IQ
ggplot(mod, aes(x = wm, y = iq)) + 
    geom_smooth(aes(group = condition), 
                method = "lm", se = T, color = "black", fullrange = T) +
    geom_point(aes(color = condition))

################################################################################
## Ch.2: An Introduction to Centering Predictors
################################################################################

############################################################
## Introduction to centering
############################################################

## Cetering Predictors
## To center means to put in deviation form
##  - X[C] = X - M
## Why center?
##  - Two reasons:
##      - Conceptual
##      - Statistical

##################################################
## Centering data
##################################################

# Define wm_center
wm_center <- mod$wm - mean(mod$wm) 

# Compare with the variable wm.centered
all.equal(wm_center, mod$wm.centered)

##################################################
## The mean of centered data
##################################################

## The mean of centered data is 0.

############################################################
## Conceptual reasons for centering
############################################################

## Conceptual Reason
##  - Suppose
##      - Y = child's verbal ability
##      - X = mother's vocabulary
##      - Z = child's age
##  - The intercept, B[0], is the predicted score on Y when all predictors (X,Z)
##      are 0
##  - If X = 0 or Z = 0 is meaningless, or impossible, then B[0] will be 
##      difficult to interpret
##  - In contrast, if X = 0 and Z = 0 are the average, then B[0] is easy
##      to interpret
##  - The regression coefficient B[1] is the slope for X, assuming an average
##      score on Z
##  - No moderation effect implies that B[1] is consistent across the tnire
##      distribution of Z
##  - In contrast, a moderation effect implies that B[1] is NOT consistent
##      across the entire distribution of Z
##  - Where in the distribution of Z is B[1] most representative
##      of the relationship between X & Y?

##################################################
## Change between the models?
##################################################

# Model without moderation and with centered data
model_1_centered <- lm(mod$iq ~ mod$wm.centered + mod$d1 + mod$d2) 

# Make a summary of model_1_centered
summary(model_1_centered)

##################################################
## Centering versus no centering with moderation
##################################################

# Create new predictor variables
wm_d1_centered <- mod$wm.centered * mod$d1 
wm_d2_centered <- mod$wm.centered * mod$d2 

# Define model_2_centered
model_2_centered <- lm(mod$iq ~ mod$wm.centered + mod$d1 + mod$d2 + wm_d1_centered + wm_d2_centered)

# Make a summary of model_2_centered
summary(model_2_centered)

##################################################
## Change between the two models?
##################################################

## The essential regression coefficients will not change as a function 
##  of centering (in this case these are the moderation terms). 
##  These coefficients are also the highest order terms, 
##  everything with a lower order can change as a function of centering.

##################################################
## Model comparison
##################################################

# Compare model_1_centered and model_2_centered
anova(model_1_centered, model_2_centered)

# Compare model_1 and model_2
anova(model_1, model_2)

##################################################
## Centered data or not?
##################################################

## To test for moderation, centering or not centering does not matter.

############################################################
## Statistical reason
############################################################

## Statistical Reason
##  - The predictors, X and Z, can become highly correlated with the product,
##      (X*Z)
##      - Multicolinearity: When two predictor variables in a GLM are so highly
##          correlated that they are essentially redundant and it becomes
##          difficult to estimate B values associated with each predictor

##################################################
## Some correlations
##################################################

# Calculate the correlations between working memory capacity 
# and the product terms
cor_wmd1 <- cor(mod$wm, wm_d1)
cor_wmd2 <- cor(mod$wm, wm_d2)
cor_wmd1_centered <- cor(mod$wm.centered, mod$wm.centered * mod$d1)
cor_wmd2_centered <- cor(mod$wm.centered, mod$wm.centered * mod$d2)

# Calculate the correlations between the dummy variables 
# and the product terms
cor_d1d1 <- cor(mod$d1, wm_d1)
cor_d2d2 <- cor(mod$d2, wm_d2) 
cor_d1d1_centered <- cor(mod$d1, mod$wm.centered * mod$d1) 
cor_d2d2_centered <- cor(mod$d2, mod$wm.centered * mod$d2)

# correlations
rbind(c(cor_wmd1, cor_wmd2), c(cor_wmd1_centered, cor_wmd2_centered))
rbind(c(cor_d1d1, cor_d2d2), c(cor_d1d1_centered, cor_d2d2_centered))

############################################################
## Summary
############################################################

## Centering predictors
##  - Convert raw scores to deviation scores
##      - X[C] = X-M
## Reasons for centering
##  - Conceptual
##      - Regression constant will become more meaninful
##  - Statistical
##      - Avoid multicolinearity

##################################################
## What is you conclusion?
##################################################

## Moderation changes the slope and centering changes the scale.

################################################################################
## Ch.3: An Introduction to Mediation
################################################################################

############################################################
## Introduction to mediation
############################################################

## Example
## X: Experimental manipulation
##  - Stereotype threat
## Y: Behavioral outcome
##  - IQ score
## M: Mediator (Mechanism)
##  - Working memory capacity

##################################################
## Differecence between moderation and mediation
##################################################

## A moderator has influence over other effects or relationships,
##  whereas the mediator explains a relationship.

##################################################
## Data exploration
##################################################

# Summary statistics
describeBy(med, med$condition)

# Create a boxplot of the data
boxplot(med$iq ~ med$condition, 
        main = "Boxplot", xlab = "Group condition", ylab = "IQ")

############################################################
## The basic principles of mediation
############################################################

## A mediation analysis is typically conducted to better understand 
##  an observed effect of an IV on a DV or a correlation between X and Y
##  - Why, and how, does streotype threat influence IQ test performance?

## If X and Y are correlated, then we can use regression to predict Y from X
##  - Y = B[0] + B[1]X + e

## If X and Y are correlated BECAUSE OF the mediator M, then (X -> M -> Y):
##  - Y = B[0] + B[1]M + e
##  - M = B[0] + B[1]X + e

## If X and Y are correlated BECAUSE OF the mediator M, and:
##  - Y = B[0] + B[1]M + B[2]X + e
##      - What will happen to the predictor value of X
##      - In other words, will B[2] be significant?

##################################################
## What will be the approach to test for mediation?
##################################################

## Run three regression models, namely lm(y ~ x), lm(m ~ x) and lm(y ~ x + m), 
##  where x,y and m represent respectively the independent variable, 
##  the dependent variable and the mediator.

##################################################
## Run 3 regression models on the data
##################################################

# Run the three regression models
model_yx <- lm(med$iq ~ med$condition)
model_mx <- lm(med$wm ~ med$condition)
model_yxm <- lm(med$iq ~ med$condition + med$wm)

# Make a summary of the three models
summary(model_yx)
summary(model_mx)
summary(model_yxm)

##################################################
## Can you conclude that there is mediation
##  and why or why not?
##################################################

## Yes, there is mediation because there is a significant relation 
##  between the predictor and the outcome, the predictor and the mediator 
##  and because there is no significance anymore of the predictor 
##  in the full model.

############################################################
## Partial and full mediation
############################################################

## A mediator variable (M) accounts for some or all of the relationship
##  between X and Y
##  - Some: Partial mediation
##  - All: Full mediation

## Caution
##  - Correlation does not imply causation
##  - There is a BIG difference between statistical mediation 
##      and true causal mediation

##################################################
## Sobel test
##################################################

## The multilevel R package contains a function sobel(). 
## The sobel() function runs the whole mediation analysis.
## A z-value with an abolute value larger than 1.96 in the sobel test result
##  implies significance at 0.05 (alpha) significance level.

# Compare the previous results to the output of the sobel function
model_all <- sobel(med$condition, med$wm, med$iq) 

model_all

################################################################################