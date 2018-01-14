################################################################################
## Source: DataCamp
## Course: Data Manipulation in R with dplyr
## Date: 2016-01-24
################################################################################

################################################################################
## Chapter 1: Introduction to dplyr and tbls
################################################################################

############################################################
## Section 1: Introduction to dplyr
############################################################

#######################################
## Load the dplyr and hflights package
#######################################

# Load the dplyr package
library(dplyr)

# Load the hflights package
library(hflights)

# Call both head() and summary() on hflights
head(hflights)
summary(hflights)

########################
## Explore the data set
########################

dim(hflights)

################################################################
## Section 2: Introduction to tbl, a special type of data.frame
################################################################

################################
## Convert dtata.frame to table
################################

# Both the dplyr and hflights packages are loaded

# Convert the hflights data.frame into a hflights tbl
hflights <- tbl_df(hflights)

# Display the hflights tbl
hflights

# Create the object carriers, containing only the UniqueCarrier variable of hflights
carriers <- hflights$UniqueCarrier

############################################
## Changing lables of hflights, part 1 of 2 
############################################

# Both the dplyr and hflights packages are loaded into workspace
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Use lut to translate the UniqueCarrier column of hflights
carriers <- hflights$UniqueCarrier
hflights$UniqueCarrier <- lut[carriers]

# Inspect the resulting raw values of your variables
glimpse(hflights)

############################################
## Changing lables of hflights, part 2 of 2 
############################################

# The hflights tbl you built in the previous exercise is available in the workspace.

# Build the lookup table: lut
lut <- c("A" = "carrier", "B" = "weather", "C" = "FFA", "D" = "security", "E" = "not cancelled")

# Use the lookup table to create a vector of code labels. Assign the vector to the CancellationCode column of hflights
labels <- lut[hflights$CancellationCode]
hflights$CancellationCode <- labels

# Inspect the resulting raw values of your variables
glimpse(hflights)

################################################################################
## Chapter 2: select and Mutate
################################################################################

############################################################
## Section 3: The five verbs and select in more detail
############################################################

###########################################
## Choosing is not losing! The select verb
###########################################

# hflights is pre-loaded as a tbl, together with the necessary libraries.

# Print out a tbl with the four columns of hflights related to delay
print(select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay))

# Print out hflights, nothing has changed!
print(hflights)

# Print out the columns Origin up to Cancelled of hflights
print(select(hflights, Origin:Cancelled))

# Answer to last question: be concise!
select(hflights, -(DepTime:AirTime))

###########################################
## Helper functions for variable selection
###########################################

# As usual, hflights is pre-loaded as a tbl, together with the necessary libraries.

# Print out a tbl containing just ArrDelay and DepDelay
print(select(hflights, ends_with("Delay")))

# Print out a tbl as described in the second instruction, using both helper functions and variable names
print(select(hflights, starts_with("Unique"), ends_with("Num"), starts_with("Cancel")))

# Print out a tbl as described in the third instruction, using only helper functions.
select(hflights, matches(".*Time|Delay$"))

#########################
## Comparison to basic R
#########################

# both hflights and dplyr are available

ex1r <- hflights[c("TaxiIn","TaxiOut","Distance")]
ex1d <- select(hflights, TaxiIn, TaxiOut, Distance)

ex2r <- hflights[c("Year","Month","DayOfWeek","DepTime","ArrTime")]
ex2d <- select(hflights, Year, Month, DayOfWeek, DepTime, ArrTime)

ex3r <- hflights[c("TailNum","TaxiIn","TaxiOut")]
ex3d <- select(hflights, matches("TailNum"), starts_with("Taxi"))

############################################################
## Section 4: The second of five verbs: mutate
############################################################

########################
## Mutating is creating
########################

# hflights and dplyr are loaded and ready to serve you.

# Add the new variable ActualGroundTime to a copy of hflights and save the result as g1.
g1 <- mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime)

# Add the new variable GroundTime to a g1. Save the result as g2.
g2 <- mutate(g1, GroundTime = TaxiIn + TaxiOut)

# Add the new variable AverageSpeed to g2. Save the result as g3.
g3 <- mutate(g2, AverageSpeed = Distance / AirTime * 60)

# Print out g3
print(g3)

#######################################
## Add multiple variables using mutate 
#######################################

# hflights and dplyr are ready, are you?

# Add a second variable loss_percent to the dataset: m1
m1 <- mutate(hflights, loss = ArrDelay - DepDelay, loss_percent = ((ArrDelay-DepDelay) / DepDelay) * 100)

# Copy and adapt the previous command to reduce redendancy: m2
m2 <- mutate(hflights, loss = ArrDelay - DepDelay, loss_percent = (loss / DepDelay) * 100)

# Add the three variables as described in the third instruction: m3
m3 <- mutate(hflights, TotalTaxi = TaxiIn + TaxiOut, ActualGroundTime = ActualElapsedTime - AirTime, Diff = TotalTaxi - ActualGroundTime)

################################################################################
## Chapter 3: Filter and Arrange
################################################################################

############################################################
## Section 5: The third of five verbs: filter
############################################################

#####################
## Logical operators
#####################

# hflights is at your disposal as a tbl, with clean carrier names

# All flights that traveled 3000 miles or more
print(filter(hflights, Distance >= 3000))

# All flights flown by one of JetBlue, Southwest, or Delta
print(filter(hflights, UniqueCarrier %in% c("JetBlue","Southwest","Delta")))

# All flights where taxiing took longer than flying
print(filter(hflights, ActualElapsedTime-AirTime > AirTime))

###########################################
## Combining tests using boolean operators
###########################################

# hflights is at your service as a tbl!

# All flights that departed before 5am or arrived after 10pm
print(filter(hflights, DepTime < 500 | ArrTime > 2200))

# All flights that departed late but arrived ahead of schedule
print(filter(hflights, DepDelay > 0 & ArrDelay < 0))

# All cancelled weekend flights
print(filter(hflights, Cancelled == 1 & (DayOfWeek == 6 | DayOfWeek == 7)))

# All flights that were cancelled after being delayed
print(filter(hflights, Cancelled == 1 & DepDelay > 0))

#######################################
## Blend together what you've learned!
#######################################

# hflights is already available in the workspace

# Select the flights that had JFK as their destination: c1
c1 <- filter(hflights, Dest == "JFK")

# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2 <- mutate(c1, Date = paste(Year, Month, DayofMonth, sep="-"))

# Print out a selection of columns of c2
print(select(c2, Date, DepTime, ArrTime, TailNum))

#######################################
## Recap on select, mutate, and filter
#######################################

# How many weekend flights flew a distance of more than 1000 miles 
# but had a total taxing time less than 15 minutes?
subset <- filter(hflights, 
                 (DayOfWeek == 6 | DayOfWeek == 7) 
                 & Distance > 1000 
                 & (ActualElapsedTime-AirTime) < 15)

print(nrow(subset))

############################################################
## Section 6: Almost there: the arrange verb
############################################################

#######################
## Arranging your data
#######################

# dplyr and the hflights tbl are available

# Definition of dtc
dtc <- filter(hflights, Cancelled == 1, !is.na(DepDelay))

# Arrange dtc by departure delays
arrange(dtc, DepDelay)

# Arrange dtc so that cancellation reasons are grouped
arrange(dtc, CancellationCode)

# Arrange dtc according to carrier and departure delays
arrange(dtc, UniqueCarrier, DepDelay)

##################################
## Reverse the order of arranging
##################################

# dplyr and the hflights tbl are available

# Arrange according to carrier and decreasing departure delays
arrange(hflights, UniqueCarrier, desc(DepDelay))

# Arrange flights by total delay (normal order).
arrange(hflights, DepDelay+ArrDelay)

# Keep flights leaving to DFW before 8am and arrange according to decreasing AirTime 
arrange(filter(hflights, Dest == "DFW" & DepTime < 800), desc(AirTime))

################################################
## Recap on select, mutate, filter, and arrange
################################################

# TailNum of flights that departed too late, sorted by total taxiing time
fi <- filter(hflights, DepDelay > 0)
mu <- mutate(fi, TotalTaxiTime = TotalElapsedTime - AirTime)
ar <- arrange(mu, desc(TotalTaxiTime))
se <- select(ar, TailNum)

################################################################################
## Chapter 4: Summarise and the Pipe Operator
################################################################################

############################################################
## Section 7: Last but not least: summarise
############################################################

###########################
## The syntax of summarise
###########################

# hflights and dplyr are loaded in the workspace

# Print out a summary with variables min_dist and max_dist
summarise(hflights, min_dist = min(Distance), max_dist = max(Distance))

# Print out a summary with variable max_div
summarise(filter(hflights, Diverted==1), max_div = max(Distance))

#######################
## Aggregate functions
#######################

# hflights is available

# Remove rows that have NA ArrDelay: temp1
temp1 <- filter(hflights, !is.na(ArrDelay))

# Generate summary about ArrDelay column of temp1
summarise(temp1, 
          earliest = min(ArrDelay), 
          average = mean(ArrDelay),
          latest = max(ArrDelay),
          sd = sd(ArrDelay))

# Keep rows that have no NA TaxiIn and no NA TaxiOut: temp2
temp2 <- filter(hflights, !is.na(TaxiIn), !is.na(TaxiOut))

# Print the maximum taxiing difference of temp2 with summarise()
summarise(temp2, max_taxi_diff = max(abs(TaxiIn-TaxiOut)))

#############################
## dplyr aggregate functions
#############################

# hflights is available with full names for the carriers

# Generate summarizing statistics for hflights
summarise(hflights,
          n_obs = n(),
          n_carrier = n_distinct(UniqueCarrier),
          n_dest = n_distinct(Dest),
          dest100 = nth(Dest, 100))

# Filter hflights to keep all American Airline flights: aa
aa <- filter(hflights, UniqueCarrier == "American")

# Generate summarizing statistics for aa 
summarise(aa,
          n_flights = n(),
          n_canc = sum(Cancelled),
          p_canc = n_canc / n_flights * 100,
          avg_delay = mean(ArrDelay, na.rm=TRUE))

#########################################################
## Section 8: Chaining your functions: the pipe operator
#########################################################

######################
## Overview of syntax
######################

# hflights and dplyr are both loaded and ready to serve you

# Write the 'piped' version of the English sentences.
hflights 
    %>% mutate(diff = TaxiOut-TaxiIn) 
    %>% filter(!is.na(diff)) 
    %>% summarise(avg=mean(diff))

#############################
## Drive or fly? Part 1 of 2
#############################

# hflights is pre-loaded

# Build data frame with 4 columns of hflights and 2 self-defined columns: d
hflights %>%
    select(Dest, UniqueCarrier, Distance, ActualElapsedTime) %>%
    mutate(RealTime = ActualElapsedTime+100) %>% 
    mutate(mph = Distance/RealTime*60) -> d

# Filter and summarise d according to the instructions
filter(d, !is.na(mph) & mph < 70) %>% 
    summarise(n_less = n(), 
              n_dest = n_distinct(Dest), 
              min_dist = min(Distance), 
              max_dist = max(Distance))

#############################
## Drive or fly? Part 2 of 2
#############################

# hflights and dplyr are loaded and ready to roll

# Let's define preferable flights as flights that are 150% faster than driving,
# i.e., that travel 105 mph or greater in real time.
# Also assume that cancelled or diverted flights are less preferable 
# than driving.

# Solve the exercise using a combination of dplyr verbs and %>%
# Use one single piped call to print a summary with the following variables:
# n_non - the number of non-preferable flights in hflights,
# p_non - the percentage of non-preferable flights in hflights,
# n_dest - the number of destinations that non-preferable flights traveled to,
# min_dist - the minimum distance that non-preferable flights traveled,
# max_dist - the maximum distance that non-preferable flights traveled.
hflights %>%
    mutate(RealTime = ActualElapsedTime+100) %>%
    mutate(mph = Distance/RealTime*60) %>%
    filter(mph < 105 | Cancelled == 1 | Diverted == 1) %>%
    summarise(n_non = n(),
              p_non = (n_non/nrow(hflights) * 100),
              n_dest = n_distinct(Dest),
              min_dist = min(Distance),
              max_dist = max(Distance))

############################
## Advanced piping exercise
############################

# hflights and dplyr are loaded

# Count the number of overnight flights
hflights %>%
    filter(!is.na(DepTime) & !is.na(ArrTime)) %>%
    filter(ArrTime < DepTime) %>%
    summarise(n = n())

################################################################################
## Chapter 5: Group_by and Working with Databases
################################################################################

############################################################
## Section 9: Get group-wise insights: group_by
############################################################

####################################
## Unite and conquer using group_by
####################################

# hflights is in the workspace as a tbl, with translated carrier names

# Make an ordered per-carrier summary of hflights
# Generate a per-carrier summary of hflights with the following variables: 
# n_flights, the number of flights flown by the carrier; 
# n_canc, the number of cancelled flights; 
# p_canc, the percentage of cancelled flights; 
# avg_delay, the average arrival delay of flights whose delay does not equal NA. 
# Next, order the carriers in the summary from low to high 
# by their average arrival delay. 
# Use percentage of flights cancelled to break any ties. 
# Which airline scores best based on these statistics?

hflights %>%
    group_by(UniqueCarrier) %>%
    summarise(n_flights = n(),
              n_canc = sum(Cancelled==1),
              p_canc = n_canc/n_flights * 100,
              avg_delay = mean(ArrDelay, na.rm=TRUE)) %>%
    arrange(avg_delay, p_canc)            

# Make an ordered per-day summary of hflights
# Generate a per-day-of-week summary of hflights with the variable avg_taxi, 
# the average total taxiing time. Pipe this summary into an arrange() call 
# such that the day with the highest avg_taxi comes first.

hflights %>%
    group_by(DayOfWeek) %>%
    summarise(avg_taxi = mean(TaxiIn+TaxiOut, na.rm=TRUE)) %>%
    arrange(desc(avg_taxi))

################################
## Combine group_by with mutate
################################

# You can also combine group_by() with mutate(). 
# When you mutate grouped data, mutate() will calculate the new variables 
# independently for each group. This is particularly useful when mutate() 
# uses the rank() function, that calculates within group rankings. 
# rank() takes a group of values and calculates the rank of each value 
# within the group.

# dplyr is loaded, hflights is loaded with translated carrier names

# First, discard flights whose arrival delay equals NA. 
# Next, create a by-carrier summary with a single variable: 
# p_delay, the proportion of flights which are delayed at arrival. 
# Next, create a new variable rank in the summary 
# which is a rank according to p_delay. 
# Finally, arrange the observations by this new rank.

hflights %>%
    filter(!is.na(ArrDelay)) %>%
    group_by(UniqueCarrier) %>%
    summarise(p_delay = sum(ArrDelay>0)/n()) %>%
    mutate(rank = rank(p_delay)) %>%
    arrange(rank)

# In a similar fashion, keep flights that are delayed (ArrDelay > 0 and not NA). 
# Next, create a by-carrier summary with a single variable: 
# avg, the average delay time of the delayed flights. 
# Again, add a new variable rank to the summary according to avg. 
# Finally, arrange by this rank variable.

hflights %>%
    filter(!is.na(ArrDelay) & ArrDelay > 0) %>%
    group_by(UniqueCarrier) %>%
    summarise(avg = mean(ArrDelay)) %>%
    mutate(rank = rank(avg)) %>%
    arrange(rank)

###############################
## Advanced group_by exercises
###############################

# Which plane (by tail number) flew out of Houston the most times? 
# How many times? Name the column with this frequency n. 
# Assign the result to adv1. 
# To answer this question precisely, you will have to filter() 
# as a final step to end up with only a single observation in adv1.

hflights %>%
    group_by(TailNum) %>%
    summarise(n = n()) %>%
    filter(n == max(n)) -> adv1

# How many airplanes only flew to one destination from Houston? 
# Save the resulting dataset in adv2, that contains only a single column, 
# named nplanes and a single row.

hflights %>%
    group_by(TailNum) %>%
    summarise(n_dest = n_distinct(Dest)) %>%
    filter(n_dest == 1) %>%
    summarise(nplanes = n()) -> adv2

# Find the most visited destination for each carrier and save your solution 
# to adv3. Your solution should contain four columns:
#    UniqueCarrier and Dest,
#    n, how often a carrier visited a particular destination,
#    rank, how each destination ranks per carrier. 
#    rank should be 1 for every row, as you want to find the most visited 
#    destination for each carrier.

hflights %>%
    group_by(UniqueCarrier, Dest) %>%
    summarise(n = n()) %>%
    mutate(rank = rank(desc(n))) %>%
    filter(rank == 1) -> adv3

# For each destination, find the carrier that travels to that destination 
# the most. Store the result in adv4. 
# Again, your solution should contain 4 columns: 
# Dest, UniqueCarrier, n and rank.

hflights %>%
    group_by(Dest, UniqueCarrier) %>%
    summarise(n = n()) %>%
    mutate(rank = rank(desc(n))) %>%
    filter(rank == 1) -> adv4

############################################################
## Section 10: dplyr and databases
############################################################

####################################
## dplyr deals with different types
####################################

library(data.table)
hflights2 <- as.data.table(hflights)

# hflights2 is pre-loaded as a data.table

# Use summarise to calculate n_carrier
s2 <- hflights2 %>% summarise(n_carrier = n_distinct(UniqueCarrier))

#############################
## dplyr and mySQL databases
#############################

# Set up a src that connects to the mysql database (src_mysql is provided 
# by dplyr)
my_db <- src_mysql(dbname = "dplyr", 
                   host = "dplyr.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "dplyr",
                   password = "dplyr")

# And reference a table within that src: nycflights is now available 
# as an R object that references to the remote nycflights table
nycflights <- tbl(my_db, "dplyr")

# Glimpse at nycflights
glimpse(nycflights)

# Group the nycflights data by carrier, 
# then create a grouped summary of the data that shows the number of flights 
# (n_flights) flown by each carrier and the average arrival delay (avg_delay) 
# of flights flown by each carrier. Finally, arrange the carriers 
# by average delay from low to high.

nycflights %>%
    group_by(carrier) %>%
    summarise(n_flights = n(),
              avg_delay = mean(arr_delay)) %>%
    arrange(avg_delay)            

################################################################################