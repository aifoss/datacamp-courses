################################################################################
## Source: DataCamp
## Course: R for SAS, SPSS, and STATA Users
## Date: 2016-04-01
################################################################################


################################################################################
## Ch.1 Introduction
################################################################################

############################################################
## Introduction
############################################################

## Five main parts of SAS/SPSS/STATA
##  - 1. Data input & management (language)
##  - 2. Stat & graphics procedures/commands
##  - 3. Output management systems (ODS/OMS/return codes, postestimation)
##  - 4. Macro language
##  - 5. Matrix language (IML/Matrix/Mata)

################################################################################
## Ch.2 Installing & Maintaining R
################################################################################

############################################################
## Installing & maintaining R
############################################################

## Installing package
install.packages("ggplot2")
update.packages(ask=FALSE)

## Loading package
library(ggplot2)

## Checking which packages are installed
library()

## Checking which packages are loaded into memory
search()

## Removing package from memory
detach("package:ggplot2")

##################################################
## R packages
##################################################

# Load the ggplot2 package into the memory 
library("ggplot2")

# List the package in your memory
search()

# Remove the ggplot2 package from the memory
detach("package:ggplot2")

################################################################################
## Ch.3 Help & Documentation
################################################################################

############################################################
## Help & documentation
############################################################

## Getting help
help(mean)
?mean
help("while")
help(package = "Hmisc")

## Checking methods of a function
methods(plot)

## Retrieving manuals
help.start()

## rdocumentation.org

##################################################
## Methods of a function
##################################################

# Look for the methods of the 'plot()' function
methods(plot)

##################################################
## Methods of a function - follow-up question
##################################################

## Methods shown with asterisk are non-visible internal methods.

################################################################################
## Ch.4 RStudio Basics
################################################################################

############################################################
## RStudio basics
############################################################

## Clearing console
## CTRL + L

## Commenting/uncommenting
## CTRL + SHIFT + C

## Saving work
save.image(file="work.RData")

################################################################################
## Ch.5 Programming Language Basics
################################################################################

############################################################
## Programming language basics
############################################################

##################################################
## Variable assignment
##################################################

# Here 2 is multiplied with 3 and assigned to the variable 'x'
x <- 2 * 3
x

# The letter "s" is assigned to the variable 'y' and printed. 
# Naming this variable 'y' might cause some confusion in the future. 
# Make sure to use variable names that make sense when you create 
# your own variables.
y <- "s"
y

# "Michael" is assigned to the variable 'name'
name <- "Michael"
name

# A vector with the letters "a", "b" and "c" is created 
# and stored in the variable 'abc'
abc <- c("a", "b", "c")
abc

# A matrix with 2 rows and 5 columns with the numbers 1 to 10 
# ordered column-wise is created and assigned to the variable 'm'
m <- matrix(1:10, nrow = 2, ncol = 5)
m

# A 2x5 matrix with the numbers 1 to 10 ordered row-wise is made 
# and assigned to the variable 'm'. Note that the old value of 'm' 
# will be overwritten.
m <- matrix(1:10, nrow = 2, ncol = 5, byrow = TRUE)
m

# Assign the value 7 to the variable 'a'
a <- 7

# Assign "this_is_b" to the variable 'b'
b <- "this_is_b"

############################################################
## Parentheses & braces
############################################################

## Using parentheses to print assignment values
(x <- 12)

##################################################
## Parentheses
##################################################

# Control math as usual will evaluate the division first, 
# followed by the sum. The result is 9.
4 + 10 / 2

# Adjust the expression by adding parentheses such that 
# 4 + 10 is evaluated first and the result becomes 7
(4 + 10) /2

##################################################
## Correct the errors
##################################################

# Assign 38 to variable 'x'
x <- 38

# Assign 10 to variable 'y'
y <- 10

# Calculate the sum of the two variables 'x' and 'y' and divide it by '3'.
# Assign the result to z
z <- (x + y) / 3  

# Print z
z

################################################################################
## Ch.6 Data Structures
################################################################################

############################################################
## Introduction to data structures
############################################################

##################################################
## Create a vector
##################################################

# Set the variable 'country' correctly
country <- c(1,2,1,2,1,2,1,2)

# Print the vector country
country

##################################################
## Vector operations - workshop
##################################################

# The workshop vector
workshop <- c(1, 2, 1, 2, 1, 2, 1, 2)

# Operation 1: workshop + workshop + workshop
workshop + workshop + workshop

# Operation 2: workshop + 6
workshop + 6

# Operation 3: 10 * workshop
10 * workshop

# Operation 4: workshop + c(1, 2, 3, 4)
workshop + c(1, 2, 3, 4)

##################################################
## Vector operations on a company review
##################################################

# Business hours quarter 1, 2, 3 and 4
QR1 <- c(36, 34, 37, 35, 33, 32, 35, 31)
QR2 <- c(37, 35, 38, 36, 35, 33, 35, 33)
QR3 <- c(39, 37, 40, NA, 36, 35, 37, 35)
QR4 <- c(36, 34, 37, 35, 34, 32, 36, 32)

# Sum four quarters
sum_quarters <- QR1 + QR2 + QR3 + QR4
sum_quarters

# Mean four quarters
mean_quarters <- sum_quarters / 4
mean_quarters

##################################################
## Recycling
##################################################

c(10, 8, 6, 4, 2, 12, 14, 16) / c(2, 1)

##################################################
## Character vectors
##################################################

# Assign the vector 'period'
period <- c("bc", "bc", "bc", NA, "ac", "ac", "ac", "ac")

############################################################
## Obtaining information out of vectors
############################################################

##################################################
## Understanding your vectors
##################################################

# The vectors country and period are preloaded in the workspace

# Apply the table() function here on the character vector 'period'
table(period)

# Apply the summary() function here on the numeric vector 'country'
summary(country)

# Apply the summary() function here on the character vector 'period'
summary(period)

##################################################
## Selecting vector elements
##################################################

# The vectors QR1 and period are preloaded in the workspace.

# Select the first three elements of QR1. 
QR1_subset <- QR1[1:3]

# Select the elements of QR1 which are from the period after the crisis. 
QR1_ac <- QR1[period == "ac"]

##################################################
## Selecting vector elements using gender
##################################################

# The workshop vector
workshop <- c(1, 2, 1, 2, 1, 2, 1, 2)

# The gender vector
gender <- c("f", "f", "f", NA, "m", "m", "m", "m")

# The q1 vector that contains the scores that were given in the survey.
q1 <- c(1, 2, 2, 3, 4, 5, 5, 4)

# Select the scores of the males and apply the summary function
summary(q1[gender=="m"])

# Select the scores of the females and apply the summary function
summary(q1[gender=="f"])

############################################################
## Factors and labels
############################################################

workshop <- c(1, 2, 1, 2, 1, 2, 1, 2)
workshop <- factor(workshop,
                   levels = c(1, 2),
                   labels = c("R", "SAS"))

##################################################
## Creating a factor
##################################################

# The vector country
country <- c(1, 2, 1, 2, 1, 2, 1, 2)

# Create a factor of the vector country 
# and re-assign it to the variable 'country'.
country <- factor(country)

# Print the updated 'country' variable
country

##################################################
## Value labels
##################################################

# The vector country
country <- c(1, 2, 1, 2, 1, 2, 1, 2)

# Create a factor with the labels "US" and "UK" for the levels 1 and 2 of the country vector and print it.
factor_country <- factor(country,
                         levels = c(1,2),
                         labels = c("US", "UK"))
factor_country

# Make a summary of the new factor country
summary(factor_country)

##################################################
## Factors, labels, and selecting by label
##  with a character vector
##################################################

# The gender vector
gender <- c("f", "f", "f", NA, "m", "m", "m", "m")

# Create a factor with the labels "Female" and "Male" and print the result
gender <- factor(gender, levels=c("f","m"), labels=c("Female","Male"))
gender

# The q1 vector
q1 <- c(1, 2, 2, 3, 4, 5, 5, 4)

# Select the scores of the females
q1[gender=="Female"]

############################################################
## Data frames
############################################################

##################################################
## Create a data frame
##################################################

# Our data so far:
# The vector country
country <- c(1, 2, 1, 2, 1, 2, 1, 2)

# The period vector
period <- c("bc", "bc", "bc", NA, "ac", "ac", "ac", "ac")

# Business hours quarter 1, 2, 3 and 4
QR1 <- c(36, 34, 37, 35, 33, 32, 35, 31)
QR2 <- c(37, 35, 38, 36, 35, 33, 35, 33)
QR3 <- c(39, 37, 40, NA, 36, 35, 37, 35)
QR4 <- c(36, 34, 37, 35, 34, 32, 36, 32)

# Create a data frame of the data of so far and assign it to 'company_data'.
company_data <- data.frame(country, period, QR1, QR2, QR3, QR4,
                           stringsAsFactors = FALSE)

# Print the data frame
company_data

##################################################
## Table data frames
##################################################

library(dplyr)
iris3_tbl <- tbl_df(data.frame(iris3))

############################################################
## Matrices and lists
############################################################

mymatrix <- matrix(
    c(.....),
    nrow=8,
    ncol=4,
    byrow=TRUE
)

##################################################
## Matrices
##################################################

# The matrix mymatrix and QR1,QR2, QR3, QR4 are preloaded in the workspace. 

# Construct the same matrix as mymatrix by using the vectors 
# QR1, QR2, QR3 and QR4 and assign to same_matrix. 
same_matrix <- cbind(QR1, QR2, QR3, QR4)

# Compute the correlation between the columns of same_matrix by using pairwise deletion of missing values
cor(same_matrix, use="pairwise") 

##################################################
## Lists
##################################################

# The following data are preloaded in the workspace: `country`, `period`, `QR1`, `QR2`, `QR3` , `QR4` and `mymatrix`, and name them.

# Create a list with our data that were used so far.
mylist <- list(
    country = country, 
    time = period, 
    QR1 = QR1, 
    QR2 = QR2, 
    QR3 = QR3, 
    QR4 = QR4, 
    mymatrix = mymatrix)

# Print the list
mylist

# Print the names of the list
names(mylist)  

################################################################################
## Ch.7 Managing Files & Workspace
################################################################################

############################################################
## Manipulating R objects
############################################################

# Listing objects
ls()
ls(pattern="q")
objects()

# Printing objects
print(mydata)
mydata
head(mydata)
tail(mydata)

# Displaying attributes
names(mydata)
rownames(mydata)
mode(mydata)
class(mydata)
attributes(mydata)

# Displaying structure
str(mydata)

# Deleting objects
rm(q1, q2, q3, q4)
myQs <- ls(pattern="q")
rm(list = myQs)
rm(list = ls()) # remove everything

##################################################
## Listing objects
##################################################

# List all objects that are stored in the workspace.
ls()

# List all objects in the workspace with a "q" in their name.
ls(pattern="q")

##################################################
## Get a feel for the data
##################################################

# The workshop and businesshours data frame are already loaded in your workspace

# Have a look at the first three rows of the `workshop` factor.
head(workshop, n=3)

# Have a look at the structure part of the `workshop` factor.   
str(workshop)

# Have a look at the last four rows of the `businesshours` data frame.
tail(businesshours, n=4)

# Have a look at the attributes of the `businesshours` data frame. 
attributes(businesshours)

##################################################
## Deleting objects
##################################################

# Assign the objects with the character q in their name to a variable 'objects_with_q'
objects_with_q <- ls(pattern="q")

# Remove the objects
rm(list = objects_with_q)

############################################################
## Managing your workspace
############################################################

# Working directory
getwd()
setwd("R4STATS")

# Saving your work
save.image(file="myPractice.RData")
save(mydata, mylist, mymatrix, file="myPractice.RData")

# Qutting & restarting
quit()
q()
setwd("R4STATS")
load("myPractice.RData")
ls()

# Special R files
# .Rproj - remembers the open files and the working directory
# .Rprofile - automatically executes commands at startup
# .Rhistory - contains the history of your R session commands (history())
# .RData - workspace loading automatically at startup

################################################################################
## Ch.8 Controlling Functions 
################################################################################

############################################################
## Functions and their arguments
############################################################

##################################################
## Arguments of the quantile function
##################################################

# The business hours vectors are already loaded in your workspace

# Look at the documentation of the quantile function
?quantile

# Correct the code below
summary(data.frame(QR1, QR2, QR3))

############################################################
## Classes
############################################################

# What methods exist?
methods(summary)

# Changing class
# as.vector, as.character, etc
print(as.list(mydata))

# Nesting function calls
summary(log(q4))

##################################################
## Changing the class
##################################################

# The business hours vector QR1 is already loaded in your workspace

# Verify the class of QR1
class(QR1)

# Change the class of QR1 to character
QR1_char <- as.character(QR1)

# Verify the class
class(QR1_char)

##################################################
## Creating nested functions
##################################################

# All the data that were used in the code blocks is preloaded

# Code block 1
max(c(mean(QR1), mean(QR2), mean(QR3), mean(QR4)))

# Code block 2
min(c(max(QR1), max(QR2), max(QR3), max(QR4)))

# Code block 3
quantile(log(QR1+QR2+QR3+QR4))

################################################################################
## Ch.9 Data Acquisition
################################################################################

############################################################
## Loading a CSV file
############################################################

mydata <- read.csv("mydata.csv")
 
##################################################
## Loading a CSV file from a URL
##################################################

# Load the workshop data and assign them to the variable below
mydata <- read.csv("http://bit.ly/bob_mydata_csv", 
                   strip.white=TRUE,
                   na.strings="")

# Print mydata
print(mydata)

##################################################
## Reading data within an R program
##################################################

# The workshop data as a string
mystring <- "workshop,gender,q1,q2,q3,q4
1,1,f,1,1,5,1
2,2,f,2,1,4,1
3,1,f,2,2,4,3
4,2, ,3,1, ,3
5,1,m,4,5,2,4
6,2,m,5,4,5,5
7,1,m,5,3,4,4
8,2,m,4,5,5,5"

# Read the workshop from the string and assign it to the variable below
mydata <- read.csv(
    textConnection(mystring),
    strip.white=TRUE,
    na.strings="")

# Print mydata
mydata

############################################################
## Loading other sorts of data
############################################################

# Reding tab file
mydata <- read.delim("mydata.tab",
                     strip.white=TRUE,
                     na.strings="")

# Reading excel file
library("xlsx")
mydata <- read.xlsx("mydata.xlsx", sheetIndex=1)

# Reading SAS file
library("sas7bdat")
mydata <- read.sas7bdat("mydata.sas7bdat")

# Reading SPSS file
library("foreign")
mydata < read.spss("mydata.sav",
                   use.value.labels=TRUE,
                   to.data.frame=TRUE)

# Reading STATA file
library("Hmisc")
mydata <- stata.get("mydata.dta")

# When ID is named
mydata <- read.delim("mydata.tab",
                     strip.white=TRUE,
                     na.strings="",
                     header=TRUE,
                     row.names="id")

##################################################
## Loading a SAS and a tab file from a URL
##################################################

# Load the workshop tab file with the right arguments and assign them to the variable 'mydata_tab'
mydata_tab <- read.delim("http://bit.ly/bob_mydata_tab",
                         strip.white=TRUE,
                         na.strings="")

# Load the library
library(sas7bdat)

# Load the workshop SAS file and assign them to the variable 'mydata_sas'
mydata_sas <- read.sas7bdat("http://bit.ly/bob_mydata_sas7bdat")

# Print both variables
mydata_tab
mydata_sas

################################################################################
## Ch.10 Missing Values
################################################################################

############################################################
## How to deal with missing values (1)
############################################################

# Testing for missing values
is.na(q3)

# Counting missing or valid
sum(is.na(q3))
sum(!is.na(q3))
n.valid <- function(x) sum(!is.na(x)) # defined in prettyR package
n.valid(q3)

##################################################
## Counting missing values
##################################################

# Create a function to calculate the number of missing values. 
n.missing <- function(x) {sum(is.na(x))}

# Use n.missing to calculate the number of missing values of QR3.
missing_count <- n.missing(QR3)

############################################################
## How to deal with missing values (2)
############################################################

# Setting values to missing
na.strings = c(".", "99", "999")
age[age==999] <- NA
# When creating a factor, leaving out levels will set the values to missing
factor(workshop, levels=c(1,4))

# Action on missing values
# Summary functions return NA unless
na.rm = TRUE
# Modeling functions automatically exclude NAs
na.action = omit
# You can omit cases with any missing using:
myNoMissing <- na.omit(mydata)

# Useful packages for replacing missing values
# VIM - visualization and imputation of missing values
# mice - multivariate imputation by chained equations

##################################################
## Setting values to missing
##################################################

# The vector random_vector is preloaded in the workspace.
random_vector <- c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3)

# Set all the 3s in random_vector to missing
random_vector[random_vector==3] <- NA

# Print the new vector
random_vector

##################################################
## Actions on missing values
##################################################

# Print the vector 'QR1' and inspect it
QR1

# Print the data frame 'my_QR_data' and inspect it
my_QR_data

# Calculate the mean of 'QR1' by excluding the missing values
mean(QR1, na.rm=TRUE)

# Remove all rows that contain any missing values from 'my_QR_data'.
na.omit(my_QR_data)
my_QR_data

################################################################################
## Ch.11 Selecting Variables
################################################################################

############################################################
## Selecting variables (1)
############################################################

# Selecting variables using $ notation
summary(mydata$q1)
summary(data.frame(mydata$q1, mydata$q2))

# Selecting variables using attach()
# R rooks for variable in data frame after searching in workspace
attach(mydata)
summary(q1) 
summary(data.frame(q1, q2))
detach(mydata)

# Selecting variables using with()
# R looks for variable in data frame before workspace
with(mydata, summary(q1))
with(mydata, summary(data.frame(q1, q2)))

##################################################
## Select variables using $ notation
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Select the QR1 variable of businesshours
my_QR1_selection <- businesshours$QR1

# Make a summary of the variables QR2 and QR3 of the data frame businesshours.
summary(data.frame(businesshours$QR2, businesshours$QR3))

##################################################
## Select variables using attach
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Attach the businesshours variable to the temporary work area.
attach(businesshours)

# Select the QR1 variable of businesshours and assign it to my_QR1_selection.
my_QR1_selection <- QR1

# Make a summary of the variables QR2 and QR3 of the data frame businesshours.
summary(data.frame(QR2, QR3))

# Detach the businesshours variable of the temporary work area.
detach(businesshours)

##################################################
## Creating new variables with data attached
##################################################

# If a dataset is stored in a temporary data space with attach()
# and you create a new variable, this variable will be stored 
# in your current workspace.

##################################################
## Select variables using with
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Select the QR1 variable of businesshours using the with function and assign it my_QR1_selection
my_QR1_selection <- with(businesshours, QR1)

# Make a summary of the variables QR2 and QR3 of the data frame businesshours by using the with function.
with(businesshours, summary(data.frame(QR2, QR3)))

############################################################
## Selecting variables (2)
############################################################

# Subscripting or indexing
q1[gender=="m"]
summary(mydata[, 3])
summary(mydata[, "q1"])
summary(mydata[, c(3, 4, 5, 6)])
summary(mydata[, 3:6])
summary(mydata[, c("q1", "q2", "q3", "q4")])

# Comma details
# If the comma is missing, suscripts refer to columns
mydata[c("q1", "q2", "q3", "q4")]
mydata[c(3, 4, 5, 6)]
mydata[3:6]
# A multiple column selection from a data frame always returns a data frame
# A single column selection can be a vector or a data frame
mydata["q1"] # data frame
mydata[, "q1"] # vector

# Selecting variables using formulas
t.test(q4 ~ gender, data = mydata)

##################################################
## Select variables by subscripting or indexing
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Select the QR1 variable of businesshours
my_QR1_selection <- businesshours[, "QR1"]

# Make a summary of the variables QR2 and QR3 of businesshours.
summary(businesshours[, c("QR2","QR3")])

##################################################
## Comma details
##################################################

# Which of the following commands will calculate the mean of all elements 
# of columns 2 and 3 of businesshours?
mean(c(mean(businesshours[, 2]), mean(businesshours[, 3])))

##################################################
## Select variables using formulas
##################################################

# The `businesshours` dataset is pre-loaded in the workspace.

# Correct the errors in the t-test of QR4 as function of period and assign it to t_test_1.
t_test_1 <- t.test(QR4 ~ period, data = businesshours)

# Correct the errors in the paired t-test comparing QR1 to QR2 and assign it to t_test_2.
t_test_2 <- t.test(businesshours$QR1, businesshours$QR2, paired=TRUE)

############################################################
## The dplyr package
############################################################

# dplyr's select() function
library("dplyr")
select(mydata, workshop, gender)
select(mydata, gender:q4)
select(mydata, contains("q"))
select(mydata, starts_with("q"))
select(mydata, ends_with("shop"))
select(mydata, num_range("q", 1:4))
select(mydata, matches("^q"))

# Nesting select()
library("dplyr")
summary(select(mydata, q1:q4))

##################################################
## dplyr's select function
##################################################

# A data frame businesshours is pre-loaded in the workspace.

# Load the dplyr package into the memory.
library("dplyr")

# Use the select() function to select all variables starting with the variable "period" until "QR3" and all the variables in between them.
select(businesshours, period:QR3)

# Use the select() function to select all variables that contain "o".
select(businesshours, contains("o"))

# Use the select() function to select all variables that starts_with "Q".
select(businesshours, starts_with("Q"))

# Use the select() function to select all variables with a numeric range from 2 to 4 and starting with "QR".
select(businesshours, num_range("QR", 2:4))

# Use the select() function to select all variables that DO NOT have a numeric range from 2 to 4 and starts with "QR".
select(businesshours, -num_range("QR", 2:4))

##################################################
## Nesting select
##################################################

# A data frame businesshours is pre-loaded in the workspace.
library("dplyr")

# Make a summary of QR1 and QR2 by nesting the select() function.
summary(select(businesshours, QR1, QR2))

# Calculate the mean of QR3 with the mean() function.
mean(businesshours$QR3)

################################################################################
## Ch.12 Selecting Observations
################################################################################

############################################################
## Selecting observations
############################################################

# Using subscripting
summary(mydata[mydata$gender=="f", ])

# Using filter() function
library("dplyr")
summary(filter(mydata, gender=="f"))

##################################################
## Selecting observations using subscripting
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Select the observations of businesshours from the period before the crisis ("bc").
businesshours[businesshours$period=="bc",]

# Select the observations of businesshours with an average number of business hours in the first quarter (QR1) bigger than 34 and smaller than or equal to 36 and make a summary of this. 
summary(businesshours[businesshours$QR1 > 34 & businesshours$QR1 <= 36, ])

##################################################
## Selecting observations using filter from dplyr
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Load the appropriate package
library(dplyr)

# Select the observations of businesshours from the period before the crisis ("bc") using the filter() function from the dplyr package.
filter(businesshours, period=="bc")

# Select the observations of businesshours with an average number of business hours in the first quarter (QR1) bigger than 34 and smaller than or equal to 36 using the filter() function from the dplyr package and make a summary of this. 
summary(filter(businesshours, QR1 > 34 & QR1 <= 36))

############################################################
## Logic rules and functions
############################################################

# Logic rules
mydata$gender == "f"
which(mydata$gender == "f")

# Logic functions
any(mydata$gender == "m")
all(mydata$gender == "m")
sum(mydata$gender == "m", na.rm = TRUE)

# Logic operators
# xor(a, b)

##################################################
## Logic rules
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Print a logical vector which indicates which elements of period from businesshours are equal to "bc".
businesshours$period == "bc"

# Print the indices of period from businesshours which are equal to "ac".
which(businesshours$period == "ac")

##################################################
## Logic functions
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Find out whether there are subjects of period from businesshours equal to "bc".
any(businesshours$period == "bc")

# Find out how many subjects of period from businesshours are equal to "bc".
sum(businesshours$period == "bc", na.rm = TRUE)

# Find out whether all the subjects of period from businesshours are equal to "bc".
all(businesshours$period == "bc")

################################################################################
## Ch.13 Selecting Variables & Observations
################################################################################

############################################################
## Selecting variables and observations
############################################################

# Using both subscripts
myVars <- c("gender", "q1", "q2", "q3", "q4")
myObs <- which(mydata$gender == "f")
summary(mydata[myObs, myVars])

# Saving a subset
mysubset <- mydata[myObs, myVars]
summary(mysubset)

# Combining select() and filter()
library("dplyr")
mysubset <- select(mydata, gender, q1:q4)
mysubset <- filter(mysubset, gender=="f")
summary(mysubset)

##################################################
## Using both subscripts
##################################################

# The data frame businesshours is pre-loaded in the workspace.

# Create a character vector with the variables: "period", "QR1" and "QR2" and call it `myVars`.
myVars <- c("period", "QR1", "QR2")

# Create a vector with the observations of the period equal to "bc" and call this vector `myObs`.
myObs <- which(businesshours$period == "bc")

# Select, with the two vectors from above, the variables and observations from `businesshours` by subscripting.
# Save this selection in 'mySubset', print it and make summary of it.
mySubset <- businesshours[myObs, myVars]
print(mySubset)
summary(mySubset)

##################################################
## Combining select and filter
##################################################

# The data frame businesshours is pre-loaded in the workspace.
library("dplyr")

# Use the select() to create mySubset1 with variables period, QR1 and QR2 (in this order) selected from businesshours.
mySubset1 <- select(businesshours, period, QR1, QR2)

# Use the filter() function to select from mySubset1 the observations with the period equal to "bc". Store the result in mySubset2
mySubset2 <- filter(mySubset1, period == "bc")

# Make a summary of mySubset2
summary(mySubset2)

################################################################################
## Ch.14 Transformations
################################################################################

############################################################
## Transformations
############################################################

# dplyr mutate() function
library("dplyr")
mydata2 <- mutate(mydata,
                  diff = q4-q1,
                  ratio = q4/q1,
                  q4log = log(q4),
                  z4 = scale(q4),
                  meanQ = (q1+q2+q3+q4)/4)

##################################################
## Using $ notation
##################################################

# The data frame yourdata is pre-loaded in the workspace.

# Copy the data frame `yourdata` and assign it to `yourdata2`.
yourdata2 <- yourdata

# Subtract all the observations of the `A` variable from the observations of `D` variable and assign it to `yourdata2$diff`.
yourdata2$diff  <- yourdata$D - yourdata$A 

# Divide all the observations from the `D` variable through the observations of `A` variable and assign it to `yourdata2$ratio`.
yourdata2$ratio <- yourdata$D / yourdata$A

# Compute the logarithm of the `D` variable and assign it to `yourdata2$Dlog`.
yourdata2$Dlog <- log(yourdata$D)

# Calculate the mean of the variables `A`, `B`, `C` and `D` and assign it to `yourdata2$mean`.
yourdata2$mean <- (yourdata$A + yourdata$B + yourdata$C + yourdata$D) / 4

##################################################
## Using subscripting
##################################################

# The data frame yourdata is pre-loaded in the workspace.

# Copy the data frame `yourdata` and assign it to `yourdata2`.
yourdata2 <- yourdata

# Subtract all the observations of the `A` variable from the observations of `D` variable and assign it to `yourdata2[,"diff"]`.
yourdata2[,"diff"]  <- yourdata2[,"D"] - yourdata2[,"A"] 

# Divide all the observations from the `D` variable through the observations of `A` variable and assign it to `yourdata2[,"ratio"]`.
yourdata2[,"ratio"] <- yourdata2[,"D"] / yourdata2[,"A"]

# Compute the logarithm of the `D` variable and assign it to `yourdata2[,"Dlog"]`.
yourdata2[,"Dlog"] <- log(yourdata2[,"D"])

# Calculate the mean of the variables `A`, `B`, `C` and `D` and assign it to `yourdata2[,"mean"]`.
yourdata2[,"mean"] <- (yourdata[,"A"]+yourdata[,"B"]+yourdata[,"C"]+yourdata[,"D"])/4

##################################################
## dplyr's mutate function
##################################################

# The data frame yourdata is pre-loaded in the workspace.

# Perform all the transformations listed in the instructions in 1 one mutate function call and assign this to yourdata2.
yourdata2 <- mutate(yourdata,
                    diff = D-A,
                    ratio = D/A,
                    Dlog = log(D),
                    mean = (A+B+C+D)/4)

##################################################
## Some more mathematical operations
##################################################

# The variables x and y are pre-loaded in the workspace.

# Calculate `x` to the power 5
x^5

# Calculate the exponential function of `x`
exp(x)

# Round the square root of `y` to 2 digits after the comma
round(sqrt(y),2)

# Calculate the round-off error from the previous instruction
abs(sqrt(y)-round(sqrt(y),2))

################################################################################
## Ch.15 Graphics
################################################################################

############################################################
## Traditional or base graphics
############################################################

# plot()
plot(workshop) # bar plot
plot(workshop, gender) # bar plot
plot(workshop, posttest) # box plot
plot(posttest, workshop) # strip plot
plot(posttest) # index plot
plot(pretest, posttest) # scatter plot

# hist() & rug()
hist(posttest)
rug(posttest)

##################################################
## Basic plotting with factors
##################################################

# Plot the workshop factor on the x-axis and the gender factor on the y-axis
plot(workshop, gender)

# Plot the gender factor on the x-axis and the workshop factor on the y-axis
plot(gender, workshop)

##################################################
## Basic plotting with continuous variables
##################################################

# Plot the workshop factor against the pretest variable
plot(workshop, pretest)

# Plot the pretest variable against the workshop factor
plot(pretest, workshop)

# Plot the posttest variable against the pretest variable
plot(posttest, pretest)

##################################################
## Basic plotting with histograms
##################################################

# Make a histogram of the pretest variable and add ticks to it
hist(pretest)
rug(pretest)

############################################################
## Embellishments (1)
############################################################

# Adding embellishments
plot(pretest, posttest,
     pch = 19, # plot character
     cex = 2, # character expansion
     main = "My Main Title",
     xlab = "My X Axis Label",
     ylab = "My Y Axis Label")
grid()

# Graphics PARameters
par()

##################################################
## Adding embellishments
##################################################

# Plot the posttest variable against the pretest variable 
# and add all the embellishments
plot(posttest, pretest,
     pch = 3,
     cex = 0.5,
     main = "Embellished plot",
     xlab = "X values",
     ylab = "Y values")
grid()

############################################################
## Plotting groups (1)
############################################################

# Plotting groups using mfrow (MultiFrame) parameter
par(mfrow = c(2,1)) # 2 rows, 1 column
plot(workshop[gender=="Female"], main="The Females")
plot(workshop[gender=="Male"], main="The Males")
par(mfrow = c(1,1))

############################################################
## Scatter plot with regression
############################################################

# Scatter with regression - manual approach
plot(pretest, posttest)
abline(c(18.78, 0.845))

# Scatter with regression - automatted approach
plot(pretest, posttest)
myModel <- lm(posttest ~ pretest, data = mydata100)
abline(coefficients(myModel))

##################################################
## Scatter plot with regression:
##  the manual approach
##################################################

# Plot the pretest variable against the posttest variable 
# and include a regression analysis manually
plot(pretest, posttest)
abline(a=18.78, b=0.845) # a = intercept, b = slope

##################################################
## Scatter plot with regression:
##  the automated approach
##################################################

# Plot the pretest variable against the posttest variable
plot(pretest, posttest)

# Create a regression model 
myModel <- lm(posttest ~ pretest, data = mydata100)

# Plot a regression analysis automatically
abline(coefficients(myModel))

##################################################
## Combine them all!
##################################################

# Plot the posttest variable against the pretest variable 
# with the right embellishments
plot(posttest, pretest,
     pch = 3,
     cex = 2,
     main = "Combination Plot",
     xlab = "X: posttest",
     ylab = "Y: pretest")
grid()

# Create a regression model and plot it
myModel <- lm(pretest ~ posttest, data = mydata100)
abline(coefficients(myModel))

############################################################
## The ggplot2 package
############################################################

# ggplot2 package
library("ggplot2")
ggplot(mydata100, aes(workshop)) +
    geom_bar()
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="stack")
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="stack") +
    scale_fill_grey()
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="dodge")
ggplot(mydata100, aes(workshop)) +
    geom_bar() +
    facet_grid(gender ~ .)

##################################################
## Basic plotting with ggplot2
##################################################

# Plot the workshop factor as a bar chart
ggplot(mydata100, aes(workshop)) +
    geom_bar()

##################################################
## Basic plotting with ggplot2 ctd.
##################################################

# Plot a bar chart of the workshop factor, 
# filled with stacked gender information
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="stack")

# Plot a bar chart of the gender factor in grey scale, 
# filled with stacked workshop information
ggplot(mydata100, aes(gender, fill=workshop)) +
    geom_bar(position="stack") +
    scale_fill_grey()

# Plot a bar chart of the workshop factor in grey scale, 
# filled with dodged gender information.
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="dodge") +
    scale_fill_grey()

##################################################
## Plotting groups with ggplot2
##################################################

# Plot a grouped bar chart of the workshop factor, 
# with the gender factor specifying the number of rows
ggplot(mydata100, aes(workshop)) +
    geom_bar() + 
    facet_grid(gender ~ .)

############################################################
## The ggplot2 package (2)
############################################################

# Boxplot
ggplot(mydata100, aes(workshop, posttest)) +
    geom_boxplot() + 
    geom_point()
ggplot(mydata100, aes(workshop, posttest)) +
    geom_boxplot() + 
    geom_point() +
    facet_grid(. ~ gender)

# Scatterplot
ggplot(mydata100, aes(pretest, posttest)) +
    geom_point()
ggplot(mydata100, aes(pretest, posttest, shape=gender)) +
    geom_point(size=5)
ggplot(mydata100, aes(pretest, posttest, shape=gender, linetype=gender)) +
    geom_point(size=5) +
    geom_smooth(method="lm")
ggplot(mydata100, aes(pretest, posttest, shape=gender)) +
    geom_point() +
    geom_smooth(method="lm") +
    facet_grid(workshop ~ gender)

# Same, more fully specified
ggplot() +
    geom_point(data=mydata100,
               aes(pretest, posttest,
                   shape=gender)) +
    geom_smooth(data=mydata100,
                aes(pretest, posttest),
                method="lm") +
    facet_grid(workshop ~ gender)

##################################################
## Advanced plotting with ggplot2
##################################################

ggplot(mydata100, aes(pretest, posttest, shape=gender, linetype=gender)) +
    geom_point(size=5) +
    geom_smooth(method="lm")

##################################################
## Regression analysis with ggplot2
##################################################

# Make a scatter plot of the pretest variable against the posttest variable, 
# specifying the shape of the points by the gender factor 
# and setting their size to 5. 
# Superimpose this plot with a regression analysis of the same data, 
# specifying the line type again by the gender factor
ggplot(mydata100, aes(pretest, posttest, shape=gender, linetype=gender)) +
    geom_point(size=5) +
    geom_smooth(method="lm")

############################################################
## Embellishments (2)
############################################################

# Adding embellishments
ggplot(mydata100, aes(pretest, posttest)) +
    geom_point() +
    labs(title = "Plot of Test Scores",
         x = "Before Workshop",
         y = "After Workshop") +
    theme(plot.title = element_text(size=rel(2.5))) +
    theme_bw()
my_white <- theme_bw() +
    theme(plot.title = element_text(size=rel(2.5)),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank())

# Using a palette
library("RColorBrewer")
display.brewer.all(n=4)
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="stack") +
    scale_fill_brewer(palette="Set1")

##################################################
## Adding embellishments with ggplot2
##################################################

# Make a scatter plot of the pretest variable against the posttest variable, 
# specifying the shape of the points by the gender factor and setting their size to 5. 
# Superimpose this plot with a regression analysis of the same data, 
# specifying the line type again by the gender factor
ggplot(mydata100, aes(pretest, posttest, shape=gender, linetype=gender)) +
    geom_point(size=5) +
    geom_smooth(method="lm")

##################################################
## Create a theme
##################################################

# Create a theme that starts from the theme theme_bw(), 
# doubles the size of the title, 
# and sets the major and minor grid lines (x and y) to white
my_white <- theme_bw() +
    theme(plot.title = element_text(size=rel(2)),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank())

# Make a scatter plot of the pretest variable against the posttest variable, 
# set the title of the plot to "Plot of Test Scores" 
# and the x- and y-label to "Before Workshop" and "After Workshop", respectively,
# and add your own theme
ggplot(mydata100, aes(pretest, posttest)) +
    geom_point() +
    labs(title = "Plot of Test Scores",
         x = "Before Workshop",
         y = "After Workshop") +
    my_white

##################################################
## Use a palette
##################################################

# List the color palettes with four colors of the RColorBrewer package
display.brewer.all(n=4)

# Plot a bar chart of the workshop factor, 
# filled with stacked gender information, colored according to the palette Set2
ggplot(mydata100, aes(workshop, fill=gender)) +
    geom_bar(position="stack") +
    scale_fill_brewer(palette="Set2")

##################################################
## Combine them all! Again!
##################################################

# Create your theme
my_white <- theme_bw() +
    theme(plot.title = element_text(size=rel(3)),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.y = element_blank())

# Plot!
ggplot(mydata100, 
       aes(pretest, posttest, shape=gender, linetype=gender)) +
    geom_point(size=2) +
    facet_grid(workshop ~ gender) +
    labs(title="Combination Plot",
         x="Before Workshop",
         y="After Workshop") +
    geom_smooth(method="lm") +
    my_white

############################################################
## Interactive graphics & graphics resources
############################################################

# Interactive graphics
# iplots, ggvis

################################################################################
## Ch.16 Writing Functions
################################################################################

############################################################
## Writing functions
############################################################

# Function with vector output
mystats <- function(x) {
    mymean <- mean(x, na.rm=TRUE)
    mysd <- sd(x, na.rm=TRUE)
    c(mean=mymean, sd=mysd)
}
mystats(posttest)

##################################################
## Your own function
##################################################

# Write a function mymean that returns the mean of a vector, removing the missing values and without naming the result
mymean <- function(x) {
    mean(x, na.rm=TRUE)
}

# Apply mymean on `pretest`
mymean(pretest)

##################################################
## Function with vector output
##################################################

# Write a function mystats that returns the mean, the standard deviation, 
# the median, the maximum and the minimum of an vector, in that order, 
# removing the missing values.
mystats <- function(x) {
    mean = mean(x, na.rm=TRUE)
    sd = sd(x, na.rm=TRUE)
    median = median(x, na.rm=TRUE)
    max = max(x, na.rm=TRUE)
    min = min(x, na.rm=TRUE)
    c(mean=mean, sd=sd, median=median, max=max, min=min)
}

# Apply mystats on `pretest`
mystats(pretest)

############################################################
## Applying functions by group and anonymous functions
############################################################

# Applying functions by group
by(posttest, workshop, mean)

# More than 1 function by group
# Combine multiple functions into one
by(posttest, workshop, mystats)

# Anonymous functions
by(posttest, workshop,
   function(x) {
       c(mean(x), sd(x))
   }
)

##################################################
## Applying functions by group
##################################################

# Calculate the mean, standard deviation, median, maximum and minimum 
# by using the pre-loaded function of the pretest variable 
# that is grouped by gender
by(pretest, gender, mystats)

##################################################
## Anonymous function
##################################################

# Calculate the mean and the minimum (in that order and without names) in 
# an anonymous function of the pretest variable that is grouped by gender.
by(pretest, gender, 
   function(x) {
       c(mean(x), min(x))
   }
)

############################################################
## Debugging tips
############################################################

##################################################
## Debug the code
##################################################

# Debug the code so it gives the mean, the standard deviation, and the median
# of pretest, grouped by gender without removing missing values 
# and without specifying the name of the arguments.
by(pretest,
   gender,
   function(x){c(mean(x),
                 sd(x),
                 median(x))
   }
)

################################################################################
## Ch.17 Basic Statistics
################################################################################

############################################################
## The R's built-in means functions
############################################################

# R's built-in frequencies
table(q4)
prop.table(table(q4))
cumsum(prop.table(table(q4)))

# Deducer's frequencies()
options(DeducerNoGui=TRUE)
Deducer::frequencies(
    select(mydata100, workshop, gender) # dplyr
)

# R's built-in means, SDs, etc.
mean(posttest, na.rm=TRUE)
median(posttest, na.rm=TRUE)
sd(posttest, na.rm=TRUE)
var(posttest, na.rm=TRUE)
min(posttest, na.rm=TRUE)
max(posttest, na.rm=TRUE)

##################################################
## Computing the means
##################################################

# Compute the mean of the scores for each student individually
rowMeans(talent_scores)

# Compute the mean of the scores for each course individually
colMeans(talent_scores)

# Compute the score each student has gained for all his courses
rowSums(talent_scores)

# Compute the total score that is gained by the students on each course
colSums(talent_scores)

##################################################
## Other statistics
##################################################

# Compute the mean of the English scores
mean(scores_english, na.rm=TRUE)

# Compute the median of the English scores
median(scores_english, na.rm=TRUE)

# Compute the variance between the English scores
var(scores_english, na.rm=TRUE)

# Compute the standard deviation between the English scores
sd(scores_english, na.rm=TRUE)

# Compute the minimum of the English scores
min(scores_english, na.rm=TRUE)

# Compute the maximum of the English scores
max(scores_english, na.rm=TRUE)

############################################################
## Getting summary statistics
############################################################

# R's summary() function
summary(
    select(mydata100, contains("test")) # dplyr
)

# Rcmdr's numSummary()
library("Rcmdr")
numSummary(
    select(mydata100, q1:posttest),
    statistics = c("mean", "sd", "cv", "quantiles"),
    quantiles = c(0, .50, 1)
)

##################################################
## Computing summary statistics in R
##################################################

# Summary statistics for all variables - 5 digits
summary(talent_scores, digits=5)

# Summary statistics for all variables - 10 digits
summary(talent_scores, digits=10)

# Summary statistics for variables containing "cal". Calculate the statistics to 4 significant digits 
summary(select(talent_scores, contains("cal")), digits=4)

# Summary statistics for variables containing "rea". Calculate the statistics to 4 significant digits 
summary(select(talent_scores, contains("rea")), digits=4)

##################################################
## Alternative function to compute summary statistics
##################################################

# Calculate the summary statistics 
numSummary(talent_scores)

############################################################
## R's description abilities
############################################################

# Hmisc's describe() function
library("Hmisc")
describe(mydata100)

##################################################
## Describe your data!
##################################################

# Describe the `talent_scores` dataset
describe(talent_scores)

# Describe the `businesshours` dataset
describe(businesshours)

############################################################
## R's tabulation possibilities
############################################################

# R's built-in crosstab
myWG <- table(workshop, gender)
summary(myWG)
chisq.test(myWG)

# Table-related functions
prop.table() # calculates proportions
addmargins() # add row/column totals

# gmodels' CrossTable()
library("gmodels")
CrossTable(workshop, gender, chisq=TRUE, format="SAS")

##################################################
## Set up a crosstable! (1)
##################################################

# Generate a two-way contingency table of gender and fulltime and print the output
gender_fulltime <- table(talent$gender, talent$fulltime)
gender_fulltime

# Obtain the Pearson's Chi-Squared test, the number of observations and the number of factors for the table
summary(gender_fulltime)  

# Obtain the Pearson's Chi-Squared test for the table
chisq.test(gender_fulltime)  

# Generate a two-way contingency table of gender and fulltime with proportions
prop.table(gender_fulltime)  

# Add the margins to `gender_fulltime`
addmargins(gender_fulltime)

##################################################
## Set up a crosstable! (2)
##################################################

# Load the gmodels package
library(gmodels)

# Generate a cross table of gender and fulltime
gender_fulltime_2 <- CrossTable(talent$fulltime, talent$gender)
gender_fulltime_2  

# Generate a crosstable for gender and fulltime 
# in which only the results for the chi-square test are included, and the row proportions.   
CrossTable(talent$fulltime, talent$gender,
           chisq=TRUE, prop.r=TRUE,
           prop.c=FALSE, prop.t=FALSE, prop.chisq=FALSE)  

# Generate a cross table of gender and fulltime in SAS format
CrossTable(talent$fulltime, talent$gender, format="SAS")  

# Generate a cross table of gender and fulltime in SPSS format
CrossTable(talent$fulltime, talent$gender, format="SPSS")

################################################################################
## Ch.18 Correlation & Regression
################################################################################

############################################################
## Correlation and its signifiance
############################################################

# R's built-in functions
cor(select(mydata, q1:q4),
    method="pearson",
    use="pairwise")
cor.test(mydata$q1, mydata$q4,
         use="pairwise")

# Rcmdr's rcorr.adjust()
library("Rcmdr")
rcorr.adjust(
    select(mydata, q1:q4),
    type="pearson"
)

# Corrs w/ Bayesian probabilities
library("devtools")
install_github("rasmusab/bayesian_first_aid")
library("BayesianFirstAid")
myBayes <- bayes.cor.test(mydata$q1, mydata$a4, use="pairwise")

##################################################
## Correlations and pairwise p-values by a number
##  of stpes? (1)
##################################################

# Read the variables names
names(talent)

# Create a subset of the dataframe talent, talent_selected, containing reading, english and creativity (in that order).
talent_selected <- subset(talent, select = c(reading, english, creativity))

# Compute the correlations among reading, english and creativity
cor(talent_selected,
    method="pearson",
    use="pairwise")

# Compute the p-values for all pairwise comparisons
cor.test(talent_selected$english, talent_selected$reading, use="pairwise")
cor.test(talent_selected$reading, talent_selected$creativity, use="pairwise")
cor.test(talent_selected$english, talent_selected$creativity, 
         use="pairwise")

##################################################
## Correlations and pairwise p-values by a number
##  of stpes? (2)
##################################################

# To use the 'select()' function, the dplyr package has to be loaded
library(dplyr)

# Create a subset of the dataframe businesshours, businesshours_selected, containing QR1, QR2, QR3 and QR4 (in that order)
businesshours_selected <- select(businesshours, QR1:QR4) 

# Compute the correlations among QR1, QR2, QR3 and QR4
cor(businesshours_selected, method="pearson", use="pairwise")

# Test the **significance** of the correlations among `QR1` and `QR2`
cor.test(businesshours_selected$QR1, businesshours_selected$QR2, use="pairwise")

############################################################
## Modeling functions: a different approach
############################################################

# Linear regression using lm()
myModel <- lm(q4 ~ q1+q2+q3, data=mydata100)
summary(myModel)
anova(myModel)
plot(myModel)
predict(myModel, mydata)

##################################################
## Linear regression (1)
##################################################

# model_erc: regress english on reading and creativity
model_erc <- lm(english ~ reading+creativity, data=talent)

# Compute the summary statistics for model
summary(model_erc)

# Perform an analysis of variance on model
anova(model_erc)

# Produce diagnostic plots for model
plot(model_erc)

# Predict based on the fitted function model_erc
predict(model_erc, talent)

############################################################
## Get the output
############################################################

mode(myModel)
class(myModel)
names(myModel)
myModel$coefficients
print(unclass(myModel))

############################################################
## Common regression models
############################################################

# Common regression models
# Simple regression: y ~ x
# Regression w/o intercept: y ~ -1 + x
# Multiple regression with all variables: y ~ .
# Multiple regression with interaction:
#   y ~ x1 + x2 + x1:x2
#   or y ~ x1*x2
#   or y ~ (x1 + x2) ^ 2
# Polynomial regression:
#   y ~ x + I(x^2) + I(x^3)
#   or y ~ poly(x, 3)

##################################################
## Multiple regression with interaction
##################################################

# Regress english against creativity and reading - no interaction term
model_1 <- lm(talent$english ~ talent$creativity+talent$reading)

# Summary statistics for model_1
summary(model_1)  

# Regress english against creativity and reading - interaction term
model_2 <- lm(talent$english ~ talent$creativity + talent$reading + talent$creativity:talent$reading) 

# Summary statistics for model_2
summary(model_2)

##################################################
## Polynomial regression
##################################################

# Plot the relation between math and reading
plot(talent$math, talent$reading)

# Regress reading against math - no higher order terms
model_1 <- lm(talent$reading ~ poly(talent$math,1))

# Summary statistics for model_1
summary(model_1)

# Regress reading against math - 1 higher order term
model_2 <- lm(talent$reading ~ poly(talent$math, 2)) 

# Summary statistics for model_2
summary(model_2)

# Regress reading against math - 2 higher order terms
model_3 <- lm(talent$reading ~ poly(talent$math, 3))

# Summary statistics for model_3
summary(model_3)

################################################################################
## Ch.19 Comparing groups
################################################################################

############################################################
## Test independency between groups
############################################################

# Two independent groups
# Parametric
t.test(q1 ~ gender)
# Non-parametric
wilcox.test(q1 ~ gender)
# Bayesian
library(devtools)
install_github("rasmusab/bayesian_first_aid")
library("BayesianFirstAid")
bayes.t.test(q1 ~ gender)
  
##################################################
## Test independency between groups: parametric
##################################################

# In order to test whether two groups are independent or not, 
#   a number of tests might be performed: parametric, non-parametric and bayesian.
# Independency between groups is examined by testing whether the means 
#   of the two groups are statistically different.

# A parametric test or the two-sample Welch test is performed 
#   when the sample sizes of both groups are large enough 
#   as the central limit theorem applies. 

# Ensure that the data are normally distributed
hist(talent$english)

# Perform the parametric test
t.test(talent$english ~ talent$gender)

############################################################
## Test matched groups
############################################################

# Two matched groups
# Parametric
t.test(pretest, posttest, paired=TRUE)
# Non-parametric
wilcox.test(pretest, posttest, paired=TRUE)
# Bayesian
bayesian.t.test(pretest, posttest, paired=TRUE)

##################################################
## Test matched groups: parametric
##################################################

# Perform the parametric test
t.test(mydata$q1, mydata$q2, paired=TRUE)

##################################################
## Test matched groups: non-parametric
##################################################

# Perform the Wilcoxon signed rank test
wilcox.test(mydata$q1, mydata$q2, paired=TRUE)

############################################################
## Analysis of variance (ANOVA)
############################################################

# ANOVA: Getting means
by(posttest, workshop, mean, na.rm=TRUE)

# ANOVA: Getting variances
by(posttest, workshop, var, na.rm=TRUE)

# ANOVA: Testing variances
library("car") # Companion to Applied Regression
# Levene's Test for Homogeneity of Variance
leveneTest(posttest, workshop)

# ANOVA models
# Parametric
summary(aov(posttest ~ workshop))
# Non-parametric
kruskal.test(posttest ~ workshop)

# ANOVA model
myModel <- aov(posttest ~ workshop)
summary(myModel)
plot(myModel)

##################################################
## ANOVA: Get the means for different subgroups
##################################################

# The analysis of variance approach might be used for testing 
#   for group differences in mean and/or in variance of a continuous variable 
#   that is split up into subsets by a categorical variable.

# Compute the means for subsets of the variable english
by(talent$english, talent$region, mean, na.rm=TRUE)

##################################################
## ANOVA: Get the variances for different subgroups
##################################################

# Compute the variances for subsets of the variable english
anova_2 <- by(talent$english, talent$region, var, na.rm=TRUE)
anova_2

# Test for homogeneity of variance across the groups
leveneTest(talent$english, talent$region)

##################################################
## ANOVA modelling: the parametric approach
##################################################

# Create the ANOVA model: model_anova
model_anova <- aov(talent$reading ~ talent$fulltime, data=talent)

# Print the summary statistics for the ANOVA model
summary(model_anova)
anova(model_anova)

# Obtain diagnostic plots for the ANOVA model
plot(model_anova)

##################################################
## ANOVA modelling: the non-parametric equivalent
##################################################

# Perform the Kruskal-Wallis test 
kt <- kruskal.test(talent$english ~ talent$region)
kt  

############################################################
## Post-Hoc with t-tests
############################################################

# Post-hoc with t-tests
# Parametric
pairwise.t.test(posttest, workshop)
# Non-parametric
pairwise.wilcox.test(posttest, workshop)

# Post-hoc with tukey
TukeyHSD(myModel, "workshop")
plot(TukeyHSD(myModel, "workshop"))

##################################################
## Multiple hypothesis testing: parametric
##################################################

# Pairwise comparisons between group levels are computed 
#   using the pairwise.t.test() function. The pairwise.t.test() function 
#   performs all possible tests and corrects them for multiple testing. 
# A correction is required since performing multiple tests at once 
#   requires a higher individual confidence level to result in the same family 
#   confidence level. 
# The adjustment method which is applied is called the Holm method.

# Alternatively, multiple comparisons at the level of the mean might be performed 
#   using the Tukey method. The Tukey honestly significant different (HSD) test 
#   is executed in R by the tukeyHSD() function. 

# Perform pairwise comparisons between the fulltime levels for english: pairwise t-test
pairwise.t.test(talent$english, talent$fulltime)

# Regress english against fulltime using the analysis of variance approach and assign the name model_t
model_t <- aov(talent$english ~ talent$fulltime, data=talent)

# Perform pairwise comparisons between the fulltime levels for english: tukeyHSD test
# Print the result
THSD <- TukeyHSD(model_t, "talent$fulltime")
THSD

# Plot the result of the tukeyHSD test
plot(THSD)

##################################################
## Multiple hypothesis testing: non-parametric
##################################################

# If you have done a non-parametric oneway analysis of variance 
#   using the Kruskal-Wallis test and found a significant result, 
#   you can then determine which of the medians differ 
#   by using the pairwise Wilcoxon rank sum test: pairwise.wilcox.test.

# Perform the Pairwise Wilcoxon Rank Sum Test
pairwise.wilcox.test(talent$english, talent$fulltime)

############################################################
## ANOVA and ANCOVA
############################################################

# ANOVA and ANCOVA models
# One-way analysis of variance: 
#   y ~ x
# Two-way analysis of variance with interaction:
#   y ~ a + b + a:b
#   or y ~ a*b
# Three-way ANOVA with all interactions:
#   y ~ a*b*c
# Three-way ANOVA with only 2-way interactions:
#   y ~ (a+b+c) ^2
#   or y ~ a*b*c - a:b:c
# ANOVA nesting b within a:
#   y ~ b %in% a
#   or y ~ a/b
# Analysis of covariance:
#   Separate slopes: y ~ x + a
#   Common slopes: y ~ x * a

# Type III sums of squares
options(contrasts=c("contr.sum","contr.poly"))

################################################################################
## Ch.20 High Quality Output
################################################################################

############################################################
## High quality output
############################################################

myM1 <- lm(q4 ~ q1+q2+q3, data=mydata100)
myM2 <- lm(q4 ~ q1)

library("xtable")
print(xtable(myM1),
      type="html",
      file="myM1-xtable.doc")

library("texreg")
htmlreg(myM1, single.row=TRUE, file="myM1-htmlreg.doc")
htmlreg(list(myM1, myM2), file="myM1-myM2-htmlreg.doc")
texreg(list(myM1, myM2))

##################################################
## Convert output to an xtable
##################################################

# Load the required package xtable
library(xtable)

# The linear model myM1 is created.
myM1 <- lm(q4 ~ q1 + q2 + q3, data = mydata)

# Print an xtable of the linear model 'myM1' and print it as a LaTeX table.
print(xtable(myM1), type="LaTeX")

##################################################
## Convert R regression output to doc
##################################################

# Make sure to load the required package
library(texreg)

# Create the table you see on the right from the linear model `myM1` and call the file "myM1.doc".
htmlreg(myM1, single.row=TRUE, file="myM1.doc")

##################################################
## Convert R regression output to LaTex and HTML
##  tables
##################################################

# Two linear models myM1 and myM2 are created.
myM1 <- lm(q4 ~ q1 + q2 + q3, data = mydata)
myM2 <- lm(q4 ~ q1 , data = mydata)

# Create a HTML table of the linear models 'myM1` and `myM2`.
htmlreg(list(myM1, myM2))

# Create a LaTeX table of the linear models 'myM1` and `myM2`.
texreg(list(myM1, myM2))

################################################################################
## Ch.21 Ways to Run R
################################################################################

############################################################
## Ways to run R
############################################################

# R Commander
# RExcel - run R / R Commander in Excel
# Rattle: R Analytical Tool To Learn R Easily
# Alteryx + R or Revolution R Enterprise

################################################################################