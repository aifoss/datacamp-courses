################################################################################
## Source: DataCamp
## Course: Intermediate R
## Date: 2016-01-12
################################################################################

################################################################################
## Chapter 1: Conditionals and Control Flows
################################################################################

#####################
## Compare Vectors ##
#####################

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Popular days
linkedin > 15

# Quiet days
linkedin <= 5

# LinkedIn more popular than Facebook
linkedin > facebook

######################
## Compare Matrices ##
######################

# The social data has been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

# When does views equal 13?
views == 13

# When is views less than or equal to 14?
views <= 14

# How often does facebook equal or exceed linkedin times two?
sum(views[1, ] * 2 <= views[2, ])

#################
## & and | (2) ##
#################

# linkedin exceeds 10 but facebook below 10
linkedin > 10 & facebook < 10

# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12

# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14

############################
## Blend It Alll Together ##
############################

# li_df is pre-loaded in your workspace
# (data frame)

# Select the second column, named day2, from li_df: second
second <- li_df$day2

# Build a logical vector, TRUE if value in second is extreme: extremes
extremes <- second > 25 | second < 5

# Count the number of TRUEs in extremes
sum(extremes)

################################################################################
## Chapter 2: Loops
################################################################################

########################
## Loop Over a Vector ##
########################

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for (l in linkedin) {
    print(l)
}    

# Loop version 2
for (i in 1:length(linkedin)) {
    print(linkedin[i])
}

######################
## Loop Over a List ##
######################

# The nyc list is already specified
nyc <- list(pop = 8405837, 
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"), 
            capital = FALSE)

# Loop version 1
for (e in nyc) {
    print(e)
}

# Loop version 2
for (i in 1:length(nyc)) {
    print(nyc[[i]])
}

########################
## Loop Over a Matrix ##
########################

# The tic-tac-toe matrix has already been defined for you
ttt <- matrix(c("O", NA, "X", NA, "O", NA, "X", "O", "X"), nrow = 3, ncol = 3)

# define the double for loop
for (i in 1:nrow(ttt)) {
    for (j in 1:ncol(ttt)) {
        print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
    }
}

###################################
## Build a for Loop from Scratch ##
###################################

# Pre-defined variables
rquote <- "R's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]

# Your solution here
rcount <- 0
for (c in chars) {
    if (c == "r" | c == "R") {
        rcount <- rcount+1
    } else if (c == "u" | c == "U") {
        break
    }
}

# Print the resulting rcount variable to the console
print(rcount)

################################################################################
## Chapter 3: Functions
################################################################################

#######################
## Load an R Package ##
#######################

# The mtcars vectors have already been prepared for you
wt <- mtcars$wt
hp <- mtcars$hp

# Request the currently attached packages
search()

# Try the qplot() function with wt and hp
qplot(wt, hp)

# Load the ggplot2 package
library(ggplot2)

# Retry the qplot() function
qplot(wt, hp)

# Check out the currently attached packages again
search()

################################################################################
## Chapter 4: The apply Family
################################################################################

###########################################
## Use LAPPLY with a Built-in R Function ##
###########################################

# The vector pioneers has already been created for you
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")

# Split names from birth year: split_math
split_math <- strsplit(pioneers, ":")

# Convert to lowercase strings: split_low
split_low <- lapply(split_math, tolower)

# Take a look at the structure of split_low
str(split_low)

# Code from previous exercise:
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

#######################################
## Use LAPPLY with Your Own Function ##
#######################################

# Write function select_first()
select_first <- function(vec) {
    return(vec[1])
}    

# Apply select_first() over split_low: names
names <- lapply(split_low, select_first)

# Write function select_second()
select_second <- function(vec) {
    return(vec[2])
}    

# Apply select_second() over split_low: years
years <- lapply(split_low, select_second)

####################################
## LAPPLY and Anonymous Functions ##
####################################

# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

names <- lapply(split_low, function(x) {x[1]})
years <- lapply(split_low, function(x) {x[2]})

##########################################
## Use LAPPLY with Additional Arguments ##
##########################################

multiply <- function(x, factor) {
    x*factor
}
lapply(list(1,2,3), multiply, factor = 3)
lapply(list(1,2,3), multiply, 3)

# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Replace the select_*() functions by a single function: select_el
select_el <- function(x, idx) {
    x[idx]
}    

# Call the select_el() function twice on split_low: names and years
names <- lapply(split_low, select_el, 1)
years <- lapply(split_low, select_el, 2)

######################################
## APPLY Functions That Return NULL ##
######################################

lapply(split_low, function(x) {
    if (nchar(x[1]) > 5) {
        return(NULL)
    } else {
        return(x[2])
    }
})

# list("1777", "1702", NULL, NULL)

#######################
## How To Use SAPPLY ##
#######################

# temp has already been defined in the workspace
temp <- list(c(10,5,7), c(5,3,3), c(12,0,1), c(3,10,9), 
             c(0,7,7), c(9,4,4), c(4,8,3))

# Use lapply() to find each day's minimum temperature
lapply(temp, min)

# Use sapply() to find each day's minimum temperature
sapply(temp, min)

# Use lapply() to find each day's maximum temperature
lapply(temp, max)

# Use sapply() to find each day's maximum temperature
sapply(temp, max)

###################################
## SAPPLY with Your Own Function ##
###################################

# temp is already defined in the workspace

# Define a function calculates the average of the min and max of a vector: extremes_avg
extremes_avg <- function(vec) {
    (min(vec)+max(vec)) / 2.0
}    

# Apply extremes_avg() over temp using sapply()
sapply(temp, extremes_avg)

# Apply extremes_avg() over temp using lapply()
lapply(temp, extremes_avg)

###########################################
## SAPPLY with Function Returning Vector ##
###########################################

# temp is already available in the workspace

# Create a function that returns min and max of a vector: extremes
extremes <- function(vec) {
    min <- min(vec)
    max <- max(vec)
    result <- c(min, max)
    names(result) <- c("min", "max")
    result
}

# Apply extremes() over temp with sapply()
sapply(temp, extremes)

# Apply extremes() over temp with lapply()
lapply(temp, extremes)

######################################
## SAPPLY Can't Simplify, Now What? ##
######################################

# temp is already prepared for you in the workspace

# Create a function that returns all values below zero: below_zero
below_zero <- function(vec) {
    vec[vec < 0]
}    

# Apply below_zero over temp using sapply(): freezing_s
freezing_s <- sapply(temp, below_zero)

# Apply below_zero over temp using lapply(): freezing_l
freezing_l <- lapply(temp, below_zero)

# Compare freezing_s to freezing_l using identical()
identical(freezing_s, freezing_l)

############################################
## SAPPLY with Functions That Return NULL ##
############################################

# temp is already available in the workspace

# Write a function that 'cat()s' out the average temperatures: print_info
print_info <- function(vec) {
    cat("The average temperature is", mean(vec), "\n")
}    

# Apply print_info() over temp using lapply()
lapply(temp, print_info)

# Apply print_info() over temp using sapply()
sapply(temp, print_info)

################################
## Reverse Engineering SAPPLY ##
################################

sapply(list(runif (10), runif (10)), 
       function(x) c(min = min(x), mean = mean(x), max = max(x)))

################
## Use VAPPLY ##
################

# temp is already available in the workspace

# Code the basics() function
basics <- function(vec) {
    result <- c(min(vec), mean(vec), max(vec))
    names(result) <- c("min", "mean", "max")
    result
}    

# Apply basics() over temp using vapply()
vapply(temp, basics, numeric(3))

####################
## Use VAPPLY (2) ##
####################

# temp is already available in the workspace

# Definition of the basics() function
basics <- function(x) {
    c(min = min(x), mean = mean(x), median = median(x), max = max(x))
}

# Fix the error:
vapply(temp, basics, numeric(4))

###########################
## From SAPPLY to VAPPLY ##
###########################

# temp is already defined in the workspace

# Convert to vapply() expression
#sapply(temp, max)
vapply(temp, max, numeric(1))

# Convert to vapply() expression
#sapply(temp, function(x, y) { mean(x) > y }, y = 5)
vapply(temp, function(x, y) { mean(x) > y }, y=5, logical(1))

# Definition of get_info (don't change)
get_info <- function(x, y) { 
    if (mean(x) > y) {
        return("Not too cold!")
    } else {
        return("Pretty cold!")
    }
}

# Convert to vapply() expression
#sapply(temp, get_info, y = 5)
vapply(temp, get_info, y=5, character(1))

#####################################################
## Apply Your Knowledge. Or Better Yet: SAPPLY It? ##
#####################################################

# work_todos and fun_todos have already been defined
work_todos <- c("Schedule call with team", 
                "Fix error in Recommendation System", 
                "Respond to Marc from IT")
fun_todos <- c("Sleep", "Make arrangements for summer trip")

# Create a list: todos
todos <- list(work_todos, fun_todos)

# Sort the vectors inside todos alphabetically
lapply(todos, sort)

################################################################################
## Chapter 5: Utilities
################################################################################

####################
## Data Utilities ##
####################

# The linkedin and facebook vectors have already been created for you
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)

# Convert linkedin and facebook to a vector: li_vec and fb_vec
li_vec <- unlist(linkedin)
fb_vec <- unlist(facebook)

# Append fb_vec to li_vec: social_vec
social_vec <- append(li_vec, fb_vec)

# Sort social_vec
sort(social_vec, decreasing=TRUE)
social_vec

########################
## Beat Gauss Using R ##
########################

# Create first sequence: seq1
seq1 <- seq(1, 500, by=3)

# Create second sequence: seq2
seq2 <- seq(1200, 900, by=-7)

# Calculate total sum of the sequences
sum(append(seq1, seq2))

##################
## GREPL & GREP ##
##################

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl(pattern="edu", x=emails)

# Use grep() to match for "edu", save result to hits
hits <- grep(pattern="edu", x=emails)

# Subset emails using hits
emails[hits]

######################
## GREPL & GREP (2) ##
######################

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grep() to match for .edu addresses more robustly
grep(pattern="@.*\\.edu$", x=emails)

# Use grepl() to match for .edu addresses more robustly, save result to hits
hits <- grepl(pattern="@.*\\.edu$", x=emails)

# Subset emails using hits
emails[hits]

################
## SUB & GSUB ##
################

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use sub() to convert the email domains to datacamp.edu (attempt 1)
sub(pattern="@.*\\.edu$", replacement="datacamp.edu", x=emails)

# Use sub() to convert the email domains to datacamp.edu (attempt 2)
sub(pattern="@.*\\.edu$", replacement="@datacamp.edu", x=emails)

###########################
## Right Here, Right Now ##
###########################

# Get the current date: today
today <- Sys.Date()

# See what today looks like under the hood
unclass(today)

# Get the current time: now
now <- Sys.time()

# See what now looks like under the hood
unclass(now)

#############################
## Create and Format Dates ##
#############################

# %Y: 4-digit year (1982)
# %y: 2-digit year (82)
# %m: 2-digit month (01)
# %d: 2-digit day of the month (13)
# %A: weekday (Wednesday)
# %a: abbreviated weekday (Wed)
# %B: month (January)
# %b: abbreviated month (Jan)

as.Date("1982-01-13")
as.Date("Jan-13-82", format = "%b-%d-%y")
as.Date("13 January, 1982", format = "%d %B, %Y")

today <- Sys.Date()
format(Sys.Date(), format = "%d %B, %Y")
format(Sys.Date(), format = "Today is a %A!")

# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-3-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2, format = "%Y-%m-%d")
date3 <- as.Date(str3, format = "%d/%B/%Y")

# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")

#############################
## Create and Format Times ##
#############################

# %H: hours as a decimal number (00-23)
# %M: minutes as a decimal number
# %S: seconds as a decimal number
# %T: shorthand notation for the typical format %H:%M:%S

# Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2, format = "%Y-%m-%d %T")

# Convert times to formatted strings
format(time1, "%M")
format(time2, "%I:%M %p")

#############################
## Calculations with Dates ##
#############################

today <- Sys.Date()
today + 1
today - 1

as.Date("2015-03-12") - as.Date("2015-02-27")
as.Date("2012-03-12") - as.Date("2012-02-27")

# day1, day2, day3, day4 and day5 are already available in the workspace

# Difference between last and first pizza day
day5 - day1

# Create vector pizza
pizza <- c(as.Date(day1), as.Date(day2), as.Date(day3), as.Date(day4), as.Date(day5))

# Create differences between consecutive pizza days: day_diff
day_diff <- diff(pizza)

# Average period between two consecutive pizza days
mean(day_diff)

#########################
## Calculus with Times ##
#########################

now <- Sys.time()
now + 3600        # add an hour
now - 3600*24     # subtract a day

birth <- as.POSIXct("1879-03-14 14:37:23")
death <- as.POSIXct("1955-04-18 03:47:12")
einstein <- death - birth
einstein

# login and logout are already defined in the workspace
# Calculate the difference between login and logout: time_online
time_online <- logout - login

# Inspect the variable time_online
time_online

# Calculate the total time online
sum(time_online)

# Calculate the average time online
mean(time_online)

############################
## Time Is Of The Essence ##
############################

# Convert astro to vector of Date objects: astro_dates
astro_dates <- as.Date(astro, "%d-%b-%Y")

# Convert meteo to vector of Date objects: meteo_dates
meteo_dates <- as.Date(meteo, "%B %d, %y")

# Calculate the maximum absolute difference between astro_dates and meteo_dates
max(abs(astro_dates - meteo_dates))

################################################################################