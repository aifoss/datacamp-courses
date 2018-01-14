################################################################################
## Source: DataCamp
## Course: Intro to Statistics with R: Introduction
## Date: 2016-02-04
################################################################################

################################################################################
## Chapter 1: Variables
################################################################################

############################################################
## Types of variables
############################################################

## 4 types of variables:
##      Nomimal - used to assign individual cases to categories
##      Ordinal - used to rank order cases (e.g., basketball team ranking)
##      Interval - used to rank order cases where the interval between 
##                  each value is equal (e.g., longitudes and latitudes)
##      Ratio

##################################################
## Nominal variables in R
##################################################

# Create a numeric vector with the identifiers of the participants 
# of your survey
participants_1 <- c(2, 3, 5, 7, 11, 13, 17)

# Check what type of values R thinks the vector consists of
class(participants_1)

# Transform the numeric vector to a factor vector
participants_2 <- factor(participants_1)

# Check what type of values R thinks the vector consists of now
class(participants_2)

##################################################
## Ordinal variables in R
##################################################

# Create a vector of temperature observations
temperature_vector <- c("High", "Low", "High", "Low", "Medium")

# Specify that they are ordinal variables with the given levels
factor_temperature_vector <- factor(temperature_vector, 
                                    order = TRUE, 
                                    levels = c("Low","Medium","High"))

##################################################
## Interval and ratio variables in R
##################################################

# Assign to the variable 'longitudes' a vector with the longitudes
# This is an interval variable.
longitudes <- c(10,20,30,40)

# Assign the times it takes for an athlete to run 100 meters 
# to the variable 'chronos'
# This is a ratio variable.
chronos <- c(10.60,10.12,9.58,11.1)

############################################################
## Quick summary
############################################################

## Nominal variables
## - Independent variables in experimentl research
##      (e.g., treatment/placebo)
## - Quasi-independent variables in correlational research
##      (e.g., gender)

## Interval and Ratio variables
## - Dependent variables in experimental research
##      (e.g., rate of polio in a community)
## - Measured variables in correlational research
##      (e.g., IQ score)

## Discrete vs. continuous variables
## - Nominal variables are discrete (categorical)
## - Ordinal variables are technically discrete but often treated as continuous
## - Interval and ratio variables are continuous

################################################################################
## Chapter 2: Histograms and Distributions
################################################################################

############################################################
## Histograms and distributions
############################################################

##################################################
## Creating histograms in R
##################################################

# Print the 'impact' data.frame
impact

# Use the describe() function to see some summary information per variable
describe(impact)

# Select the variable 'verbal_memory_baseline' from the 'impact' data.frame 
# and assign it to the variable 'verbal_baseline'
verbal_baseline <- impact$verbal_memory_baseline

# Plot a histogram of the verbal_baseline variable that you have just created
hist(verbal_baseline,
     main="Distribution of verbal memory baseline scores",
     xlab="score",
     ylab="frequency")

############################################################
## Looking at distributions by using histograms
############################################################

##################################################
## Let us go wine tasting (red wine)
##################################################

# The data.frame `red_wine_data` is already pre-loaded.

# Print the data.frame
red_wine_data

# Print basic statistical properties of the red_wine_data data.frame. 
# Use the describe() function
describe(red_wine_data)

# Split the data.frame in subsets for each country and assign these subsets 
# to the variables below
red_usa <- subset(red_wine_data, condition=='USA')
red_france <- subset(red_wine_data, condition=='France')
red_australia <- subset(red_wine_data, condition=='Australia')
red_argentina <- subset(red_wine_data, condition=='Argentina')

# Select only the Ratings variable for each of these subsets 
# and assign them to the variables below
red_ratings_usa <- red_usa$Ratings
red_ratings_france <- red_france$Ratings
red_ratings_australia <- red_australia$Ratings
red_ratings_argentina <- red_argentina$Ratings

## Create a 2 by 2 matrix of histograms

# Organize the histograms so that they are structured in a 2 by 2 matrix.
par(mfrow = c(2,2))

# Plot four histograms, one for each subject
hist(red_ratings_usa, 
     main="USA Ratings", xlab="Subject", ylab="Ratings")
hist(red_ratings_france, 
     main="France Ratings", xlab="Subject", ylab="Ratings")
hist(red_ratings_australia, 
     main="Australia Ratings", xlab="Subject", ylab="Ratings")
hist(red_ratings_argentina, 
     main="Argentina Ratings", xlab="Subject", ylab="Ratings")

##################################################
## Let us go wine tasting (white wine)
##################################################

# The data.frame `white_wine_data` is already pre-loaded.

# Print the white wine data.frame
white_wine_data

# Assign the scores for each country to a variable
white_ratings_france <- 
    subset(white_wine_data, 
           white_wine_data$condition == "France")$Ratings
white_ratings_argentina <- 
    subset(white_wine_data, 
           white_wine_data$condition == "Argentina")$Ratings
white_ratings_australia <- 
    subset(white_wine_data, 
           white_wine_data$condition == "Australia")$Ratings
white_ratings_usa <- 
    subset(white_wine_data, 
           white_wine_data$condition == "USA")$Ratings

# Plot a histogram for each of the countries
# Organize the histograms so that they are structured in a 2 by 2 matrix.
par(mfrow = c(2,2))
hist(white_ratings_usa, 
     main = "USA white ratings", xlab = "score")
hist(white_ratings_australia, 
     main = "Australia white ratings", xlab = "score")
hist(white_ratings_argentina, 
     main = "Argentina white ratings", xlab = "score")
hist(white_ratings_france, 
     main = "France white ratings", xlab = "score")

##################################################
## A uniform distribution
##################################################

##################################################
## A negatively skewed distribution
##################################################

##################################################
## Leptokurtic distribution
##################################################

## A leptokurtic distribution is a distribution that is very concentrated 
## around a small range of values. Leptokurtic distributions are 
## characterized by a peak in the histogram.

############################################################
## Quick summary
############################################################

################################################################################
## Chapter 3: Scales of Measurement
################################################################################

############################################################
## Scales of measurement - introduction
############################################################

## In statistics, there is a standard scale - the Z cale.
## Any score from any scale can be converted to Z scores.

## Z = (X - M) / SD
##      where X is a raw score, M is the mean, SD is the standard deviation

## The mean Z score is Z = 0.
## Positive Z scores are above average.
## Negative Z scores are below average.

## Example:
## M = 98.6, SD = .5, X = 99.6
## Z = 2

##################################################
## Converting a distribution to Z-scale
##################################################

# The data `ratings_australia` is already loaded

# Print the ratings for the Australian red wine
ratings_australia

# Convert these ratings to Z-scores. Use the `scale()` function
z_scores_australia <- scale(ratings_australia)

# Plot both the original data and the scaled data in histograms 
# next to each other
par(mfrow = c(1,2))

# Plot the histogram for the original scores
hist(ratings_australia,
     main="Australia Ratings",
     xlab="Ratings")

# Plot the histogram for the Z-scores
hist(z_scores_australia,
     main="Z Scores of Australia Ratings",
     xlab="Ratings")

############################################################
## Quick summary
############################################################

## Percentile rank
## Percentage of scores that fall at or below a score in a distribution.
##  - Assume a normal distribution
##  - If Z=0, then percentile rank=50th
##  - 50 percent of the distribution falls below the mean
## Raw score -> Z score -> Percentile rank

################################################################################
## Chapter 4: Measures of Central Tendency
################################################################################

############################################################
## Measures of central tendency - introduction
############################################################

## The mean is a measure of central tendency.

##################################################
## The mean of a Fibonacci sequence
##################################################

# create a vector that contains the Fibonacci elements
fibonacci <- c(0, 1, 1, 2, 3, 5, 8, 13)

# calculate the mean manually. Use the sum() and the length() functions
mean <- sum(fibonacci)/length(fibonacci)

# calculate the mean the easy way
mean_check <- mean(fibonacci)

############################################################
## Three measures of central tendency
############################################################

## Measure of central tendency:
## A measure that describes the middle or center point of a distribution.
## A good measure of central tendency is representative of the distribution.

## Mean: the average, M = (Sum X)/N
## Median: the middle score
## Mode: the score that occurs most often

## Mean is the best measure of central tendency when the distribution is normal.
## Median is preferred when there are extreme scores in the distribution.
## Mode is the peak of a histogram.

##################################################
## Setting up histograms
##################################################

# Look at the data in order to figure out which subsets are included
wine_data

# create the two subsets
red_wine <- subset(wine_data, condition=="Red")
white_wine <- subset(wine_data, condition=="White")

# Plot the histograms of the ratings of both subsets
par(mfrow = c(1,2))
hist(red_wine$Ratings, main="Shiraz", xlab="Ratings")
hist(white_wine$Ratings, main="Pinot Grigio", xlab="Ratings")

##################################################
## Robustness to outliers
##################################################

# create the outlier and add it to the dataset
outlier <- data.frame("Red", 0)
names(outlier) <- names(red_wine)
red_wine_extreme <- rbind(red_wine, outlier)

# calculate the difference in means and display it afterwards
diff_means <- mean(red_wine$Ratings) - mean(red_wine_extreme$Ratings)
diff_means

# calculate the difference in medians and display it afterwards

diff_medians <- median(red_wine$Ratings) - median(red_wine_extreme$Ratings)
diff_medians

##################################################
## Get intuitive!
##################################################

## In a right-skewed distribution: mode < median < mean
## In a left-skewed distribution: mean < median < mode

############################################################
## Quick summary
############################################################

################################################################################
## Chapter 5: Measures of Variability
################################################################################

############################################################
## Introduction to measures of variability
############################################################

## Measure of variability:
## A measure that describes the range and diversity of scores in a distribution.
## Standard deviation (SD): the average deviation from the mean in a distrubtion
## Population Variance = SD^2 = [Sum((X-M)^2)]/N
##  - used for descriptive statistics

##################################################
## The formula for the sample variance
##################################################

## Sample Variance = SD^2 = [Sum((X-M)^1)]/(N-1)
##  - used for inferential statistics

############################################################
## Calculating variance in practice
############################################################

## M = Mean
## SD = Standard Deviation
## SD^2 = Variance (aka MS)
##  - MS stands for Mean Squares
##  - SS stands for Sum of Squares

##################################################
## Michael Jordan's first NBA season 
## - Global overview
##################################################

# The dataset `data_jordan` is already loaded

# Explore Michael Jordan's first season data 
data_jordan

# Make a scatterplot of the data on which a horizontal line with height 
# equal to the mean is drawn.
mean_jordan <- mean(data_jordan$points)
plot(x=data_jordan$game, y=data_jordan$points,
     main="1st NBA season of Michael Jordan")
abline(h=mean_jordan)

##################################################
## Michael Jordan's first NBA season 
## - Calculate the variance
##################################################

# The dataset `data_jordan` is already loaded

# Calculate the differences with respect to the mean
mean <- mean(data_jordan$points)
diff <- data_jordan$points - mean

# Calculate the squared differences
squared_diff <- diff * diff

# Combine all pieces of the puzzle in order to acquire the variance
variance <- sum(squared_diff) / (length(squared_diff)-1)
variance

# Compare your result to the correct solution. 
# You can find the correct solution by calculating it 
# with the `var()` function.
var(data_jordan$points)

############################################################
## Quick summary
############################################################



################################################################################