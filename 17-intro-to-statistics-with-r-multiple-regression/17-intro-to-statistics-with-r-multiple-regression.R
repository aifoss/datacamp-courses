################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Multiple Regression
## Date: 2016-02-15
################################################################################


################################################################################
## Ch.1: A Gentle Introduction to the Principles of Multiple Regression
################################################################################

############################################################
## A gentle introduction to the principles of multiple
##  regression
############################################################

## Simple vs. Multiple Regression
##  - Simple regression
##      - Just one predictor (X)
##  - Multiple regression
##      - Multiple predictors (X1,X2,X3,...)

## Multiple Regression Equation
##  - Just add more predictors (multiple Xs)
##      Y-hat = B[0] + B[1]X[1] + B[2]X[2] + ... + B[k]X[k]
##      Y-hat = B[0] + SUM(B[k]X[k])
##      where
##          Y-hat = predicted value on the outcome variable Y
##          B[0] = predicted value on Y when all X = 0
##          X[k] = predictor variables
##          B[k] = unstandardized regression coefficients
##          Y - Y-hat = residual (prediction error)
##          k = number of predictor variables

## Model R and R^2
##  - R = multiple correlation coefficient
##      - R = r[Y-hat][Y]
##      - The correlation between the predicted scores and the observed scores
##  - R^2
##      - The percentage of variance in Y explained by the model

##################################################
## Multiple regression: visualization
##  of the relationships
##################################################

# fs is available in your working environment

# Perform the two single regressions and save them in a variable
model_years <- lm(fs$salary ~ fs$years)
model_pubs <- lm(fs$salary ~ fs$pubs)

# Plot both enhanced scatter plots in one plot matrix of 1 by 2
par(mfrow = c(1, 2))
plot(fs$salary ~ fs$years, 
     main = "plot_years", xlab = "years", ylab = "salary")
abline(model_years)
plot(fs$salary ~ fs$pubs, 
     main = "plot_pubs", xlab = "pubs", ylab = "salary")
abline(model_pubs)

##################################################
## Multiple regression: model selection
##################################################

## The R^2 coefficient of a regression model is defined as the percentage 
##  of the variation in the outcome variable that can be explained 
##  by the predictor variables of the model. In general, the R^2 coefficient 
##  of a model increases when more predictor variables are added to the model.

# fs is available in your working environment

# Do a single regression of salary onto years of experience and check the output
model_1 <- lm(fs$salary ~ fs$years)
summary(model_1)

# Do a multiple regression of salary onto years of experience 
# and numbers of publications and check the output
model_2 <- lm(fs$salary ~ fs$years + fs$pubs)
summary(model_2)

# Save the R squared of both models in preliminary variables
preliminary_model_1 <- summary(model_1)$r.squared
preliminary_model_2 <- summary(model_2)$r.squared

# Round them off while you save them in new variables
r_squared <- c()
r_squared[1] <- round(preliminary_model_1, 3)
r_squared[2] <- round(preliminary_model_2, 3)

# Print out the vector to see both R squared coefficients
r_squared

##################################################
## Multiple regression: beware of redundancy
##################################################

# fs is available in your working environment, 
# just like the variables model_1, model_2 and r_squared 
# that you created in the previous exercise

# Do multiple regression and check the regression output
model_3 <- lm(fs$salary ~ fs$years + fs$pubs + fs$age)
summary(model_3)

# Round off the R squared coefficients and save the result in the vector 
# (in one step!)
r_squared[3] <- round(summary(model_3)$r.squared, 3)

# Print out the vector in order to display all R squared coefficients 
# simultaneously
r_squared

############################################################
## Multiple regression: interpretation
############################################################

## Multiple Regression Example
##  - Outcome measure (Y)
##      - Faculty salary (Y)
##  - Predictors (X1, X2, X3)
##      - Time since PhD (X1)
##      - Number of publications (X2)
##      - Gender (X3)

##################################################
## Multiple regression: interpretation 
##  regression constants
##################################################

## It is the predicted value for the outcome variable 
##  when all predictor variables are set equal to zero.

##################################################
## Multiple regression: interpretation
##  regression coefficients
##################################################

## The regression coefficient for publications is equal to 634.9.
## This means that the predicted increase in salary for a unit increase
##  in the number of publications is equal to $634.90 for those professors
##  who have already completed their PhD an average amount of years ago.

##################################################
## Multiple regression: strongest predictor
##  variable
##################################################

## The number of publications.
## This because the standardized coefficient for publications is the highest.

################################################################################
## Ch.2: Intuition behind Estimation of Multiple Regression Coefficients
################################################################################

##################################################
## Definition of matrices
##################################################

# Construction of 3 by 8 matrix r that contains the numbers 1 up to 24
r <- matrix(seq(1:24), nrow=3, ncol=8)

# Construction of 3 by 8 matrix s that contains the numbers 21 up to 44
s <- matrix(seq(from=21, to=44, by=1), nrow=3, ncol=8)

# Take the transpose t of matrix r
t <- t(r)  

##################################################
## Addition, subtraction, and multiplication
##  of matrices
##################################################

## The addition or subtraction of two matrices is only possible 
##  if the matrices are of the same size or order. 

## The multiplication of two matrices is only possible when they are conformable:
##  the number of columns of the first matrix must equal the number of rows 
##  of the second matrix:
##      R = M^T * N

# The matrices r and s are preloaded in your workspace

# Compute the sum of matrices r and s
operation_1 <- r + s

# Compute the difference between matrices r and s
operation_2 <- r - s

# Multiply matrices t and s
operation_3 <- t %*% s

############################################################
## Correlation matrix of a raw dataframe
############################################################

##################################################
## Row vector of sums
##################################################

## A raw dataframe X (a 10-by-3 matrix) is already loaded in. 
## The first step is to sum up its 3 columns. 
## In other words, we need to construct the row vector of sums:
##      T[1p] = 1[1n]*X[np]
##          where T[1p] is the 1-by-p row vector of sums,
##          X[np] an n-by-p raw dataframe,
##          and 1[1n] is a 1-by-n matrix of ones.

# The raw dataframe `X` is already loaded in.
X

# Construction of 1 by 10 matrix I of which the elements are all 1
I <- matrix(1, nrow=1, ncol=10)

# Compute the row vector of sums
t_mat <- I %*% X

##################################################
## Row vector of means and matrix of means
##################################################

## Now that you have the row vector of sums t_mat, a 1-by-3 matrix, 
##  you are ready to construct the row vector of means M via:
##      M[1p] = T[1p]*N^-1,
##          with M[1p] the 1-by-p row vector of means,
##          T[1p] the 1-by-p row vector of sums,
##          and N^-1 the inverse number of observations for each variable.

## Given the row vector of means M, you can also construct the matrix of means
##  MM by multiplying the row vector of means with a column vector:
##      MM[np] = 1[n1]*M[1p]
##          with MM[np] the n-by-p matrix of means,
##          M[1p] the 1-by-p row vector of means,
##          and 1[n1] a n-by-1 column vector.

# The data matrix `X` and the row vector of sums (`t_mat`) 
# are saved and can be used.

# Number of observations
n = 10

# Compute the row vector of means 
M <- t_mat * (1/n)

# Construction of 10 by 1 matrix J of which the elements are all 1
J <- matrix(1, n, 1)

# Compute the matrix of means 
MM <- J %*% M

##################################################
## Matrix of deviation scores
##################################################

## The formula to calculate a matrix of deviation scores D is:
##      D[np] = X[np] - MM[np]
##          where D[np] is an n-by-p deviation matrix,
##          X[np] is the n-by-p raw dataframe,
##          and MM[np] is the n-by-p matrix of means

# The previously generated matrices X, M and MM do not need 
# to be constructed again but are saved and can be used.

# Matrix of deviation scores D 
D <- X - MM

##################################################
## Sum of squares and sum of cross products matrix
##################################################

## If you now take your matrix of deviation scores D and multiply it 
##  with its transpose, you get the matrix of sum of squares 
##  and sum of cross products S. The formula is:
##      S[XX] = D[pm]^T * D[np]
##          with S[XX] the matrix of sum of squares and sum of cross products,
##          D[pm]^T the transpose of the deviation matrix, 
##          and D[np] the n-by-p deviation matrix.

# The previously generated matrices X, M, MM and D do not need 
# to be constructed again but are saved and can be used.

# Sum of squares and sum of cross products matrix
S <- t(D) %*% D

##################################################
## Calculating the correlation matrix
##################################################

## Using the sums of squares and the sums of cross products matrix S 
##  you can calculate the variance-covariance matrix C:
##      C[XX] = S[XX] * N^-1
##          with C[XX] the variance-covariance matrix,
##          S[XX] the matrix of sum of squares and sum of cross products,
##          and N^-1 the inverse number of observations for each variable.

## Next, you can standardize this variance-covaraince matrix by multiplying it
##  with the standard deviation matrix SD. This gives us the correlation matrix
##  R:
##      R[XX] = (SD[XX])^-1 * C[XX] * (SD[XX])^-1
##          with R[XX] the corerlation matrix,
##          C[XX] the variance-covariance matrix,
##          and SD[XX] the standard deviation matrix.

# The previously generated matrices X, M, MM, D and S 
# do not need to be constructed again but are saved and can be used.
n = 10

# Construct the variance-covariance matrix 
C <- S * (1/n)

# Generate the standard deviations matrix by extracting the diagonals
SD <- diag(x = diag(C)^(1/2), nrow = 3, ncol = 3)

# Compute the correlation matrix
R <- solve(SD) %*% C %*% solve(SD)

############################################################
## Estimation of regression coefficients
############################################################

## The values of the coefficients (B) are estimated such that 
##  the model yields optimal predictions
##      - Minimize the residuals

# The sum of the squared (SS) residuals is minimized
##  - SS.RESIDUAL = SUM[(Y-hat - Y)^2]

## Standardized and in matrix form, the regression equation is Y-hat = B * X,
##  where
##  - Y-hat is a [N x 1] vector
##      - N = number of cases
##  - B is a [k x 1] vector
##      - k = number of predictors
##  - X is a [N x k] matrix

## Y-hat = B * X
##  - To solve for B
##  - Replace Y-hat with Y
##  - Conform for matrix multiplication:
##      - Y = X * B

## Y = X * B
## Now let's make X square and symmetric
## To do this, pre-multiply both sides of the equation by the transpose of X,
##  X^T

## Y = X * B becomes
##  - X^T(Y) = X^T(XB)
##  - Now, to solve for B, eliminate X^T(X)
##  - To do this, pre-multiply by the inverse, (X^T * X)^-1

## X^T * Y = X^T (XB) becomes
##  - (X^T X)^-1 (X^T Y) = (X^T X)^-1 (X^T XB)
##      - Note that (X^T X)^-1 (X^T X) = I (identity matrix)
##      - and IB = B
##  - Therefore, (X^T X)^-1 (X^T Y) = B

## B = (X^T X)^-1 (X^T Y)

################################################################################
## Ch.3: Dummy Coding
################################################################################

############################################################
## An introduction to dummy coding
############################################################

## Dummy Coding
## A system to code categorical predictors in a regression analysis

## Example
##  - IV: Area of research in Psychology department
##      - Cognitive
##      - Clinical
##      - Developmental
##      - Social
##  - DV: Number of publications

##################################################
## Starting off
##################################################

# Summary statistics
describeBy(fs, fs$dept)

##################################################
## Creating dummy variables (1)
##################################################

## In order to automatically create dummy variables, the dummy.code() function 
##  of the psych package is easy to use.

## The function takes a categorical variable as argument and automatically 
##  creates the required dummy variables: all levels are ranked alphabetically 
##  and the first one is taken as the reference group. Remember that only 
##  (N-1) dummies are created for a categorical variable with N levels. 
##  Consequently, the category which is not directly linked with a dummy 
##  variable is defined as the reference category.

# `fs` is available in your working environment

# Create the dummy variables
dept_code <- dummy.code(fs$dept)
dept_code

# Merge the dataset in an extended dataframe
extended_fs <- cbind(fs, dept_code)

# Look at the extended dataframe
extended_fs

# Provide summary statistics
summary(extended_fs)

############################################################
## Dummy variables in multiple regressions
############################################################

## Y-hat = B[0] + B[1](D1) + B[2](D2) + B[3](D3)

##################################################
## Creating dummy variables (2)
##################################################

## From this point onwards the contrast C() function is used to create 
##  dummy variables. The contrast C() takes a categorical variable 
##  as a first argument and the treatment as a second argument. 
##  The latter tells R to rank all levels alphabetically and to take 
##  the first category as the reference group.

# `fs` is available in your working environment

# Regress salary against years and publications
model <- lm(fs$salary ~ fs$years + fs$pubs)

# Apply the summary function to get summarized results for model
summary(model)

# Compute the confidence intervals for model
confint(model) 

# Create dummies for the categorical variable fs$dept by using the C() function
dept_code <- C(fs$dept, treatment)

# Regress salary against years, publications and department 
model_dummy <- lm(fs$salary ~ fs$years + fs$pubs + dept_code) 

# Apply the summary function to get summarized results for model_dummy
summary(model_dummy)

# Compute the confidence intervals for model_dummy
confint(model_dummy)

##################################################
## Model selection: ANOVA
##################################################

# The dataset `fs` and regressions `model` and `model_dummy` 
# are available in your workspace

# Compare model_dummy with model
anova(model, model_dummy)

##################################################
## Model selection: interpretation
##################################################

## The inclusion of department significantly improves the fit of the model 
##  as it results in a significant p-value at a 5%  significance level.

##################################################
## Discrepancy between actual and predicted means
##################################################

# `fs` is still available in your working environment

# Actual means of fs$salary
tapply(fs$salary, fs$dept, mean)

############################################################
## An introduction to effects coding
############################################################

##################################################
## Unweighted effects coding
##################################################

## In the effects coding scheme, a reference category still needs to be appointed
##  but this time the reference category gests a weight -1.
## The number of dummies that must be generated equals the number of levels - 1.
## This type of effects coding is called unweighted effects coding
##  since the number of observations within each category of the variable
##  is not taken into account.

# The dataframe `fs` is still loaded in

# Factorize the categorical variable fs$dept 
# and name the factorized variable dept.f
dept.f <- factor(fs$dept)

# Assign the 3 levels generated in step 2 to dept.f
contrasts(dept.f) <- contr.sum(3)

# Regress salary against dept.f
model_unweighted <- lm(fs$salary ~ dept.f)

# Apply the summary() function
summary(model_unweighted)

##################################################
## Weighted effects coding
##################################################

## Weighted effects coding differs from unweighted effects coding 
##  with respect to the weights, fractions. A reference category is chosen 
##  and the weights form the following dummy coding scheme:
##      dummy   1           2       ...     N-1
##              -n2/n1      -n3/n1  ...     -nN/n1
##              n2/n1       0       ...     0
##              0           n3/n1   ...     0
##              0           0       ...     nN/n1
##          with n = number of observations of reach group,
##          and index N = number of levels.
## The weights represent the number of observations of a non-reference category
##  relative to those of the reference category.

# Factorize the categorical variable fs$dept 
# and name the factorized variable dept.g
dept.g <- factor(fs$dept)

# The weights for each dummy are already computed and combined
# in the weights matrix.
# Assign the weights matrix to dept.g 
contrasts(dept.g) <- weights

# Regress salary against dept.f and apply the summary() function
model_weighted <- lm(fs$salary ~ dept.g)

# Apply the summary() function
summary(model_weighted)

################################################################################