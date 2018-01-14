################################################################################
## Source: DataCamp
## Course: Data Analysis in R, the data.table Way
## Date: 2016-01-22
################################################################################

################################################################################
## Ch.1 Data.table Novice
################################################################################

############################################################
## Section 1: Introduction
############################################################

##################################
## Create and subset a data.table
##################################

# The data.table package is pre-loaded

# Create my_first_data_table
my_first_data_table <- data.table(x=c("a","b","c","d","e"), y=c(1,2,3,4,5))

# Create a data.table using recycling
DT <- data.table(a=c(1L,2L), b=c("A","B","C","D"))

# Print the third row to the console
DT[3]

# Print the second and third row to the console, but do not commas
DT[2:3]

################################
## Getting to know a data.table
################################

# DT and the data.table package are pre-loaded

# Print the penultimate row of DT using .N
DT[.N-1]

# Print the column names of DT, and number of rows and number of columns
colnames(DT)
dim(DT)

# Select row 2 twice and row 3, returning a data.table with three rows where row 2 is a duplicate of row 1.
DT[c(2,2,3)]

############################################################
## Section 2: Selecting columns in j
############################################################

#############################
## A data.table of a vector?
#############################

DT[, B]

#########################
## A non-existing column
#########################

D <- 5
DT[, D]
DT[, .(D)]

##########################
## Subsetting data tables
##########################

DT = data.table(A=(1,2,3,4,5), B=c("a","b","c","d","e"), C=c(6,7,8,9,10))

# DT and the data.table package are pre-loaded

# Subset rows 1 and 3, and columns B and C
DT[c(1,3), .(B,C)]

# Assign to ans the correct value
ans <- DT[, .(B, val=A*C)]

# Fill in the blanks such that ans2 equals target
target <- data.table(B = c("a", "b", "c", "d", "e", "a", "b", "c", "d", "e"), 
                     val = as.integer(c(6:10, 1:5)))
ans2 <- DT[, .(B, val = c(C,A))]

############################################################
## Section 3: Doing j by group
############################################################

#################
## The by basics
#################

# iris is already available in your workspace.

# Convert iris to a data.table: DT
DT <- data.table(iris)

# For each Species, print the mean Sepal.Length
DT[, .(mean(Sepal.Length)), .(Species)]

# Print mean Sepal.Length, grouping by first letter of Species
DT[, .(mean(Sepal.Length)), .(substr(Species,1,1))]  

###################
## Using .N and by
###################

# data.table version of iris: DT
DT <- as.data.table(iris)

# Group the specimens by Sepal area (to the nearest 10 cm2) and count how many occur in each group.
DT[, .(.N) , by=10*round(Sepal.Length*Sepal.Width/10)]

# Now name the output columns `Area` and `Count`
DT[, .(Count=(.N)), by=(Area=10*round(Sepal.Length*Sepal.Width/10))]

################################
## Return multiple numbers in j
################################

# Create the data.table DT
set.seed(1L)
DT <- data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8))

# Create the new data.table, DT2
DT2 <- DT[, .(C=cumsum(C)), .(A,B)]

# Select from DT2 the last two values from C while you group by A
DT2[, .(C=tail(C,2)), .(A)]

################################################################################
## Ch.2 Data.table Yeoman
################################################################################

############################################################
## Section 4: Chaining
############################################################

########################
## Chaining, the basics
########################

# The data.table package has already been loaded

# Build DT
set.seed(1L)
DT <- data.table(A = rep(letters[2:1], each = 4L), B = rep(1:4, each = 2L), C = sample(8)) 

# Use chaining:
# Cumsum of C while grouping by A and B, and then select last two values of C while grouping by A
DT[, .(C=cumsum(C)), .(A,B)][, .(C=tail(C,2)), .(A)]

##############################
## Chaining your iris dataset
##############################

# The data.table DT from iris dataset is loaded in your workspace

# Perform chained operations on DT
# Get the median of all four columns Sepal.Length, Sepal.Width, Petal.Length, and Petal.Width
# while grouping by Species.
# Next order Species in descending order.
DT[, .(Sepal.Length=median(Sepal.Length), Sepal.Width=median(Sepal.Width), Petal.Length=median(Petal.Length), Petal.Width=median(Petal.Width)), .(Species)][order(-(Species))]

############################################################
## Section 5: Subset of data
############################################################

###################################
## Programming time vs readability
###################################

# Print out the pre-loaded data.table DT
DT

# Mean of columns
DT[, lapply(.SD, mean), by=x] 

# Median of columns
DT[, lapply(.SD, median), by=x]

#######################
## Introducing .SDcols
#######################

# Print out the new data.table DT
DT

# Calculate the sum of the Q columns
DT[, lapply(.SD,sum), .SDcols=2:4]

# Calculate the sum of columns H1 and H2 
DT[, lapply(.SD,sum), .SDcols=paste0("H",1:2)]

# Select all but the first row of groups 1 and 2, returning only the grp column and the Q columns. 
DT[, .SD[-1], .SDcols=paste0("Q",1:3), by=grp]

##################################################
## Mixing it together: lapply, .SD, SDcols and .N
##################################################

# DT is pre-loaded
#    x  y  z
# 1: 2  1  2
# 2: 1  3  4
# 3: 2  5  6
# 4: 1  7  8
# 5: 2  9 10
# 6: 2 11 12
# 7: 1 13 14

# Sum of all columns and the number of rows
# Get the sum of all columns x, y, and z and the number of rows in each group
# while grouping by x.
#    x x  y  z N
# 1: 2 8 26 30 4
# 2: 1 3 23 26 3

DT[, c(lapply(.SD, sum), .N), .SDcols=c("x","y","z"), .(x)]

# Cumulative sum of column x and y while grouping by x and z > 8
# Get the cumulative sum of column x and y while grouping by x and z > 8
# such that the answer looks like this:
#    by1   by2 x  y
# 1:   2 FALSE 2  1
# 2:   2 FALSE 4  6
# 3:   1 FALSE 1  3
# 4:   1 FALSE 2 10
# 5:   2  TRUE 2  9
# 6:   2  TRUE 4 20
# 7:   1  TRUE 1 13

DT[, lapply(.SD, cumsum), .SDcols=c("x","y"), by=.(by1=x, by2=z>8)]

# Chaining
# Use chaining to get the maximum of both x and y by combining the result
# that was obtained in the previous instruction and group the result by by1.

DT[, lapply(.SD, cumsum), .SDcols=c("x","y"), by=.(by1=x, by2=z>8)][, lapply(.SD, max), .SDcols=c("x","y"), .(by1)]

############################################################
## Section 6: Using := in j
############################################################

#########################################
## Adding, updating and removing columns
#########################################

# The data.table DT
DT <- data.table(A = letters[c(1, 1, 1, 2, 2)], B = 1:5)

# Add column by reference: Total
DT[, Total:=sum(B), by=A]

# Add 1 to column B
DT[c(2,4), B:=B+1L]

# Add a new column Total2
DT[2:4, Total2:= sum(B), by=A]

# Remove the Total column
DT[, Total:= NULL]

# Select the third column using `[[`
DT[[3]]

##########################################
## Deleting a column for a subset of rows
##########################################

# Error
# DT[2, B:NULL]

#####################
## The function form
#####################

# A data.table DT has been created for you
DT <- data.table(A = c(1, 1, 1, 2, 2), B = 1:5)

# Update B, add C and D
DT[, `:=` (B=B+1, C=A+B, D=2)]

# Delete my_cols
my_cols <- c("B", "C")
DT[, (my_cols):=NULL]

# Delete column 2 by number
DT[[2]]=NULL

############################################################
## Section 7: Using set()
############################################################

#####################
## Ready, set(), go!
#####################

# Set the seed
set.seed(1)

#     A B C D
#  1: 2 2 5 3
#  2: 2 1 2 3
#  3: 3 4 4 3
#  4: 5 2 1 1
#  5: 2 4 2 5
#  6: 5 3 2 4
#  7: 5 4 1 4
#  8: 4 5 2 1
#  9: 4 2 5 4
# 10: 1 4 2 3

DT = data.table(A=c(2,2,3,5,2,5,5,4,4,1),
                B=c(2,1,4,2,4,3,4,5,2,4),
                C=c(5,2,4,1,2,2,1,2,5,2),
                D=c(3,3,3,1,5,4,4,1,4,3))

# Check the DT that is made available to you
DT

# For loop with set
cols <- 2:4

for (i in seq_along(cols)) {
    rand_rows = sample(1:nrow(DT), 3, replace=FALSE)
    
    for (k in seq_along(rand_rows)) {
        set(DT,
            i = rand_rows[k],
            j = cols[i],
            value = NA)
    }
}

# Change the column names to lowercase
setnames(DT, c("a","b","c","d"))

# Print the resulting DT to the console
DT

####################
## The set() family
####################

# Define DT
DT <- data.table(a = letters[c(1, 1, 1, 2, 2)], b = 1)

# Add a postfix "_2" to all column names
setnames(DT, paste0(c("a","b"), "_2"))

# Change column name "a_2" to "A2"
setnames(DT, "a_2", "A2")

# Reverse the order of the columns
setcolorder(DT, c("b_2","A2"))

################################################################################
## Ch. 3 Data.table Expert
################################################################################

############################################################
## Section 8: Indexing
############################################################

#####################################
## Selecting rows the data.table way
#####################################

# The data.table package is pre-loaded

# Convert iris to a data.table
iris <- data.table(iris)

# Species is "virginica"
iris[Species == "virginica"]

# Species is either "virginica" or "versicolor"
iris[Species %in% c("virginica","versicolor")]

###################################################
## Removing columns and adapting your column names
###################################################

# iris as a data.table
iris <- as.data.table(iris)

# Remove the "Sepal." prefix
sepal_names <- c("Sepal.Length","Sepal.Width")
setnames(iris, sepal_names, gsub("Sepal.","",sepal_names))

# Remove the two columns starting with "Petal"
iris[, grep("Petal", names(iris)):=NULL]

####################################
## Understanding automatic indexing
####################################

# Cleaned up iris data.table
iris

# Rows for which area is greater than 20 sq cm
iris[Width*Length > 20]

# Add new boolean column is_large (area greater than 25 sq cm)
iris[, is_large := (Width*Length > 25)]

# Now select rows again where the area is greater than 25 square centimeters
iris[is_large==TRUE]

############################################################
## Section 9: Keys
############################################################

####################################################
## Check to see if you understood the KEY takeaways
####################################################

#    A B  C
# 1: b 2  6
# 2: a 4  7
# 3: b 1  8
# 4: c 7  9
# 5: a 5 10
# 6: b 3 11
# 7: c 6 12

DT[A=="b"]

#    A B  C
# 1: b 2  6
# 2: b 1  8
# 3: b 3 11

setkey(DT, A, B)

DT[A=="b"]

#    A B  C
# 1: b 1  8
# 2: b 2  6
# 3: b 3 11

#######################################
## Selecting groups or parts of groups
#######################################

# The 'keyed' data.table DT
DT <- data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)], 
                 B = c(5, 4, 1, 9,8 ,8, 6), 
                 C = 6:12)
setkey(DT,A,B)

# Select the "b" group, without using ==
DT["b"]

# "b" and "c" groups, without using ==
DT[c("b","c")]

# The first row of the "b" and "c" groups, using mult
DT[c("b","c"), mult="first"]

# First and last row of the "b" and "c" groups, using by=.EACHI and .SD
DT[c("b","c"), .SD[c(1,.N)], by=.EACHI]

# Copy and extend code for instruction 4: add printout
DT[c("b","c"), {print(.SD);.SD[c(1,.N)]}, by=.EACHI]

############################################################
## Section 10: Rolling joins
############################################################

############################
## Rolling joins - part one
############################

# Keyed data.table DT
DT <- data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)], 
                 B = c(5, 4, 1, 9, 8, 8, 6), 
                 C = 6:12, 
                 key= "A,B")

DT
#    A B  C
# 1: a 4  7
# 2: a 8 10
# 3: b 1  8
# 4: b 5  6
# 5: b 8 11
# 6: c 6 12
# 7: c 9  9

# Get the key of DT
key(DT)

# Row where A == "b" & B == 6, without using ==
DT[.("b",6)]

# Return the prevailing row
DT[.("b",6), roll=TRUE]

# Return the nearest row
DT[.("b",6), roll="nearest"]

############################
## Rolling joins - part two
############################

# Keyed data.table DT
DT <- data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)], 
                 B = c(5, 4, 1, 9, 8, 8, 6), 
                 C = 6:12, 
                 key= "A,B")

DT
#    A B  C
# 1: a 4  7
# 2: a 8 10
# 3: b 1  8
# 4: b 5  6
# 5: b 8 11
# 6: c 6 12
# 7: c 9  9

# Print out the sequence (-2):10 for the "b" group
DT[.("b",-2:10)]

# Add code: carry the prevailing values forwards
DT[.("b",-2:10), roll=+Inf]

# Add code: carry the first observation backwards
DT[.("b",-2:10), roll=TRUE, rollends=c(TRUE,TRUE)]

##############################
## Rolling joins - final part
##############################

## Look up value B==20 in group A=="b" without limiting the roll
DT[.("b",20), roll=TRUE]

################################################################################