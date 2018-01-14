################################################################################
## Source: DataCamp
## Course: Data Visualization with ggplot2 (2)
## Date: 2016-01-30
################################################################################

################################################################################
## Chapter 1: Statistics
################################################################################

############################################################
## Stats and geoms
############################################################

##################################################
## Smoothing
##################################################

# ggplot2 is already loaded

# Explore the mtcars data frame with str()
str(mtcars)

# A scatter plot with LOESS smooth:
ggplot(mtcars, aes(x=wt, y=mpg)) +
    geom_point() +
    geom_smooth()

# A scatter plot with an ordinary Least Squares linear model:
ggplot(mtcars, aes(x=wt, y=mpg)) +
    geom_point() +
    geom_smooth(method="lm") # or stat_smooth(method="lm")

# The previous plot, without CI ribbon:
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    geom_smooth(method="lm", se=FALSE)

# The previous plot, without points:
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_smooth(method="lm", se=FALSE)

##################################################
## Grouping variables
##################################################

# ggplot2 is already loaded

# Define cyl as a factor variable
ggplot(mtcars, aes(x=wt, y=mpg, col=factor(cyl))) +
    geom_point() +
    stat_smooth(method="lm", se=F)

# Modify the previous plot by setting the group aesthetic
# Set group inside aes() to summary variable 1
ggplot(mtcars, aes(x=wt, y=mpg, col=factor(cyl), group=1)) +
    geom_point() +
    stat_smooth(method="lm", se=F)

# Modify the second plot by adding a second smooth layer 
# in which the group aesthetic is set.
ggplot(mtcars, aes(x=wt, y=mpg, col=factor(cyl))) +
    geom_point() +
    stat_smooth(method="lm", se=F) +
    stat_smooth(method="lm", se=F, aes(group=1))

##################################################
## Modifying stat_smooth
##################################################

# Case 1: change the LOESS span:
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    geom_smooth(se = F, span = 0.7)

# Case 2: Set the overall model to the default LOESS and use a span of 0.7.
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
    geom_point() +
    stat_smooth(method = "lm", se = F, span = 0.75) +
    stat_smooth(method = "auto", aes(group = 1), col = "black", se = F, span = 0.7)

# Case 3: Set col to "All", inside the aes layer:
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
    geom_point() +
    stat_smooth(method = "lm", se = F, span = 0.75) +
    stat_smooth(method = "auto", aes(group = 1, col = "All"), se = F, span = 0.7)

# Case 4: Add scale_color_manual to change the colors
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
    geom_point() +
    stat_smooth(method = "lm", se = F, span = 0.75) +
    stat_smooth(method = "auto", aes(group = 1, col = "All"), se = F, span = 0.7) +
    scale_color_manual("Cylinders", values=myColors)

##################################################
## Modifying stat_smooth (2)
##################################################

# Plot 1: Jittered scatter plot, add a linear model (lm) smooth:
ggplot(Vocab, aes(x = education, y = vocabulary)) +
    geom_jitter(alpha = 0.2) +
    stat_smooth(method="lm", se=F)

# Plot 2: Only lm, colored by year
# Remove the underlyinng points.
# Color the models according to factor(year).
ggplot(Vocab, aes(x = education, y = vocabulary, col=factor(year))) +
    stat_smooth(method="lm", se=F)

# Plot 3: Set a color brewer palette
ggplot(Vocab, aes(x = education, y = vocabulary, col=factor(year))) +
    stat_smooth(method="lm", se=F) +
    scale_color_brewer()

# Plot 4: Change col and group, specify alpha, size and geom, and add scale_color_gradient
ggplot(Vocab, aes(x = education, y = vocabulary, col=year, group=factor(year))) +
    stat_smooth(method="lm", se=F, alpha=0.6, size=2, geom="path") +
    scale_color_brewer() +
    scale_color_gradientn(colors=brewer.pal(9, "YlOrRd"))

##################################################
## Quantiles
##################################################

# Use stat_quantile instead of stat_smooth:
ggplot(Vocab, aes(x=education, y=vocabulary, col=year, group=factor(year))) +
    stat_quantile(alpha=0.6, size=2) +
    scale_color_gradientn(colors=brewer.pal(9,"YlOrRd"))

# Set quantile to 0.5:
ggplot(Vocab, aes(x=education, y=vocabulary, col=year, group=factor(year))) +
    stat_quantile(alpha=0.6, size=2, quantiles=c(0.5)) +
    scale_color_gradientn(colors=brewer.pal(9,"YlOrRd"))

##################################################
## Sum
##################################################

# Plot with linear and loess model
p <- ggplot(Vocab, aes(x = education, y = vocabulary)) +
    stat_smooth(method = "loess", aes(col = "red"), se = F) +
    stat_smooth(method = "lm", aes(col = "blue"), se = F) +
    scale_color_discrete("Model", labels = c("red" = "LOESS", "blue" = "lm"))

# Add stat_sum: (by overall proportion)
p + stat_sum()

# Set size range:
p + stat_sum() +
    scale_size(range=c(1,10))

# proportional within years of education - set group aesthetic:
p + stat_sum(aes(group=education))

# Set the n, not the prop:
p + stat_sum(aes(group=education, size=..n..))

############################################################
## Stats outside geoms
############################################################

##################################################
## Preparations
##################################################

# Display structure of mtcars
str(mtcars)

# Convert cyl and am to factors:
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$am <- as.factor(mtcars$am)

# Define positions:
posn.d <- position_dodge(width=0.1)
posn.jd <- position_jitterdodge(jitter.width=0.1, dodge.width=0.2)
posn.j <- position_jitter(width=0.2)

# base layers:
wt.cyl.am <- ggplot(mtcars, aes(x=cyl, y=wt, col=am, fill=am, group=am))

##################################################
## Plotting variations
##################################################
# posn.d, posn.jd and posn.j are available

# Base layer from previous exercise
wt.cyl.am <- ggplot(mtcars, aes(x=cyl, y=wt, col=am, fill=am, group=am))

# Plot 1: Jittered, dodged scatter plot with transparent points
wt.cyl.am +
    geom_point(position=posn.jd, alpha=0.6)

# Plot 2: Mean and SD - the easy way
wt.cyl.am +
    stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), position=posn.d)

# Plot 3: Mean and 95% CI - the easy way
wt.cyl.am +
    stat_summary(fun.data=mean_cl_normal, position=posn.d)

# Plot 4: Mean and SD - with T-tipped error bars
wt.cyl.am +
    stat_summary(geom="point", fun.y=mean, position=posn.d) +
    stat_summary(geom="errorbar", fun.data=mean_sdl, fun.args=list(mult=1), position=posn.d, width=0.1) 

##################################################
## Custom functions
##################################################

# Play vector xx is available

# Complete the definition for med_IQR.
# We want a data frame that returns three values: the median, the 1st and 3rd quantiles.
med_IQR <- function(x) {
    data.frame(y=median(x), ymin=quantile(x, c(0.25)), ymax=quantile(x, c(0.75)))
}

med_IQR(xx)
# Required output:
#        y  ymin  ymax
# 25% 50.5 25.75 75.25

# Complete the definition for gg_range
# This will return a data frame containing min and max values.
gg_range <- function(x) {
    data.frame(ymin=min(x), ymax=max(x))
}

gg_range(xx)
# Required output:
#   ymin ymax
# 1    1  100

##################################################
## Custom functions (2)
##################################################

# The base ggplot command, you don't have to change this
wt.cyl.am <- ggplot(mtcars, aes(x=cyl,y=wt, col=am, fill=am, group=am))

# Add three stat_summary calls to wt.cyl.am
wt.cyl.am +
    stat_summary(fun.data=med_IQR, geom="linerange", size=3, position=posn.d) +
    stat_summary(fun.data=gg_range, geom="linerange", size=3, alpha=0.4, position=posn.d) +
    stat_summary(fun.y=median, geom="point", size=3, col="black", shape="X", position=posn.d)

################################################################################
## Chapter 2: Coordinates and Facets
################################################################################

############################################################
## Coordinates layer
############################################################

##################################################
## Zooming in
##################################################

# Basic ggplot() command, coded for you
p <- ggplot(mtcars, aes(x=wt, y=hp, col=am)) + geom_point() + geom_smooth()

# Add scale_x_continuous
p +
    scale_x_continuous(limits=c(3,6), expand=c(0,0))

# The proper way to zoom in:
p +
    coord_cartesian(xlim=c(3,6))

##################################################
## Aspect ratio
##################################################

# We can set the aspect ratio of a plot with coord_fixed() or coord_equal(). 
# Both use aspect = 1 as a default.

# Complete basic scatter plot function
base.plot <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, col=Species)) +
    geom_jitter() +
    geom_smooth(method="lm", se=F)

# Plot base.plot: default aspect ratio
base.plot

# Fix aspect ratio (1:1) of base.plot
base.plot +
    coord_equal()

##################################################
## Pie charts
##################################################

# The coord_polar() function converts a planar x-y cartesian plot 
# to polar coordinates. This can be useful if you are producing pie charts.

# Create stacked bar plot: thin.bar
thin.bar <- ggplot(mtcars, aes(x=1, fill=cyl)) +
    geom_bar()

# Convert thin.bar to pie chart
thin.bar +
    coord_polar(theta="y")

# Create stacked bar plot: wide.bar
wide.bar <- ggplot(mtcars, aes(x=1, fill=cyl)) +
    geom_bar(width=1)

# Convert wide.bar to pie chart
wide.bar +
    coord_polar(theta="y")

############################################################
## Facets layer
############################################################

##################################################
## Facets: the basics
##################################################

# The most straightforward way of using facets is facet_grid(). 
# Here we just need to specify the categorical variable to use 
# on rows and columns using formula notation.

# Basic scatter plot:
p <- ggplot(mtcars, aes(x=wt, y=mpg)) +
    geom_point()

# Separate rows according to transmission type, am
p +
    facet_grid(am ~ .)

# Separate columns according to cylinders, cyl
p +
    facet_grid(. ~ cyl)

# Separate by both columns and rows 
p +
    facet_grid(am ~ cyl)

##################################################
## Many variables
##################################################

# Code to create the cyl_am col and myCol vector
mtcars$cyl_am <- paste(mtcars$cyl, mtcars$am, sep = "_")
myCol <- rbind(brewer.pal(9, "Blues")[c(3,6,8)],
               brewer.pal(9, "Reds")[c(3,6,8)])

# Basic scatter plot, add color scale:
ggplot(mtcars, aes(x=wt, y=mpg, col=cyl_am)) +
    geom_point() +
    scale_color_manual(values=myCol)

# Facet according on rows and columns.
ggplot(mtcars, aes(x=wt, y=mpg, col=cyl_am)) +
    geom_point() +
    scale_color_manual(values=myCol) +
    facet_grid(gear ~ vs)

# Add more variables
ggplot(mtcars, aes(x=wt, y=mpg, col=cyl_am, size=disp)) +
    geom_point() +
    scale_color_manual(values=myCol) +
    facet_grid(gear ~ vs)

##################################################
## Dropping levels
##################################################

# When you have a categorical variable with many levels which are not 
# all present in sub-groups of another variable, it may be desirable 
# to drop the unused levels.

# Basic scatter plot
ggplot(mamsleep, aes(x=time, y=name, col=sleep)) +
    geom_point()

# Facet rows accoding to vore
ggplot(mamsleep, aes(x=time, y=name, col=sleep)) +
    geom_point() +
    facet_grid(vore ~ .)

# Specify scale and space arguments to free up rows
ggplot(mamsleep, aes(x=time, y=name, col=sleep)) +
    geom_point() +
    facet_grid(vore ~ ., scale="free_y", space="free_y")

################################################################################
## Chapter 3: Themes
################################################################################

############################################################
## Themes from scratch
############################################################

##################################################
## Rectangles
##################################################

# Change the plot background color to myPink:
z +
    theme(plot.background=element_rect(fill=myPink))

# Adjust the border to be a black line of size 3
z +
    theme(plot.background=element_rect(fill=myPink, color="black", size=3))

# Set panel.background, legend.key, legend.background and strip.background 
# to element_blank()
z +
    theme(plot.background=element_rect(fill=myPink, color="black", size=3), 
          panel.background=element_blank(), 
          legend.key=element_blank(), 
          legend.background=element_blank(), 
          strip.background=element_blank())

##################################################
## Lines
##################################################

# Extend z with theme() function and three arguments
# Remove the grid lines
# Add black axis
# Change tick marks to black
z +
    theme(panel.grid=element_blank(),
          axis.line=element_line(color="black"),
          axis.ticks=element_line(color="black"))

##################################################
## Text
##################################################

# Extend z with theme() function and four arguments
# Change the appearance of strip text
# Change the axis titles
# Make axis text black
z +
    theme(strip.text=element_text(size=16, color=myRed),
          axis.title.y=element_text(color=myRed, hjust=0, face="italic"),
          axis.title.x=element_text(color=myRed, hjust=0, face="italic"),
          axis.text=element_text(color="black"))

##################################################
## Legends
##################################################

# Move legend by position
z +
    theme(legend.position=c(0.85,0.85))

# Change direction
z +
    theme(legend.direction="horizontal")

# Change location by name
z +
    theme(legend.position="bottom")

# Remove legend entirely
z +
    theme(legend.position="none")

##################################################
## Positions
##################################################

# Increase spacing between facets
library(grid)
z +
    theme(panel.margin.x=unit(2,"cm"))

# Add code to remove any excess plot margin space
z +
    theme(panel.margin.x=unit(2,"cm"),
          plot.margin=unit(c(0,0,0,0),"cm"))

############################################################
## Recycling themes
############################################################

##################################################
## Update Themestheme update
##################################################

# Theme layer saved as an object, theme_pink
theme_pink <- theme(panel.background = element_blank(),
                    legend.key = element_blank(),
                    legend.background = element_blank(),
                    strip.background = element_blank(),
                    plot.background = element_rect(fill = myPink, color = "black", size = 3),
                    panel.grid = element_blank(),
                    axis.line = element_line(color = "black"),
                    axis.ticks = element_line(color = "black"),
                    strip.text = element_text(size = 16, color = myRed),
                    axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.text = element_text(color = "black"),
                    legend.position = "none")

# Apply theme_pink to z2
z2 <- z2 + theme_pink

# Change code so that old theme is saved as old
old <- theme_update(panel.background = element_blank(),
                    legend.key = element_blank(),
                    legend.background = element_blank(),
                    strip.background = element_blank(),
                    plot.background = element_rect(fill = myPink, color = "black", size = 3),
                    panel.grid = element_blank(),
                    axis.line = element_line(color = "black"),
                    axis.ticks = element_line(color = "black"),
                    strip.text = element_text(size = 16, color = myRed),
                    axis.title.y = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.title.x = element_text(color = myRed, hjust = 0, face = "italic"),
                    axis.text = element_text(color = "black"),
                    legend.position = "none")

# Display the plot z2
z2

# Restore the old plot
theme_set(old)

##################################################
## Exploring ggthemes
##################################################

# Load ggthemes package
library(ggthemes)

# Apply theme_tufte
z2 <- z2 + theme_tufte()

# Apply theme_tufte, modified:
z2 <- z2 + theme_tufte() +
    theme(legend.position=c(0.9,0.9),
          axis.title=element_text(size=12, face="italic"),
          legend.title=element_text(size=12, face="italic"))

# Apply theme_igray
z2 <- z2 + theme_igray()

# Apply theme_igray, modified:
z2 <- z2 + 
    theme_igray() +
    theme(legend.position=c(0.9,0.9),
          legend.key=element_blank(),
          legend.background=element_rect(fill="grey90"))

################################################################################
## Chapter 4: Best Practices
################################################################################

############################################################
## Best practices: bar plots
############################################################

##################################################
## Bar plots (1)
##################################################

# Base layers
m <- ggplot(mtcars, aes(x=cyl, y=wt))

# Draw dynamite plot
m +
    stat_summary(fun.y=mean, geom="bar", fill="skyblue") +
    stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), 
                 geom="errorbar", width=0.1)

##################################################
## Bar plots (2)
##################################################

# Base layers
m <- ggplot(mtcars, aes(x=cyl,y=wt, col=am, fill=am))

# Plot 1: Draw dynamite plot
m +
    stat_summary(fun.y = mean, geom = "bar") +
    stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
                 geom = "errorbar", width = 0.1)

# Plot 2: Set position dodge in each stat function
m +
    stat_summary(fun.y = mean, geom = "bar", position = "dodge") +
    stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
                 geom = "errorbar", width = 0.1, position = "dodge")

# Set your dodge posn manually
posn.d <- position_dodge(0.9)

# Plot 3:  Redraw dynamite plot
m +
    stat_summary(fun.y = mean, geom = "bar", position = posn.d) +
    stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), 
                 geom = "errorbar", width = 0.1, position = posn.d)

##################################################
## Bar plots (3)
##################################################

# mtcars.cyl contains average weight (wt.avg), 
# standard deviations (sd) and count (n) car weights, according to cylinders, cyl.
# It also contains the proportion (prop) of each cylinder 
# represented in the entire dataset.
# Base layers
m <- ggplot(mtcars.cyl, aes(x = cyl, y = wt.avg))

# Plot 1: Draw bar plot
m +
    geom_bar(stat="identity", fill="skyblue")

# Plot 2: Add width aesthetic
m +
    geom_bar(aes(width=prop), stat="identity", fill="skyblue")

# Plot 3: Add error bars
m +
    geom_bar(aes(width=prop), stat="identity", fill="skyblue") +
    geom_errorbar(aes(ymin = wt.avg-sd, ymax = wt.avg + sd), width=0.1)

############################################################
## Best practices: pie charts
############################################################

##################################################
## Pie charts (1)
##################################################

# Convert bar chart to pie chart
ggplot(mtcars, aes(x = factor(1), fill = am)) +
    geom_bar(position = "fill", width = 1) +
    facet_grid(. ~ cyl) +
    coord_polar(theta="y")

##################################################
## Pie charts (2)
##################################################

# Parallel coordinates plot using GGally
library(GGally)

# All columns except am
group_by_am <- 9
my_names_am <- (1:11)[-group_by_am]

# basic parallel plot - each variable plotted as a z-score transformation
ggparcoord(mtcars, my_names_am, groupColumn=group_by_am, alpha=0.8)

# Scaled between 0-1 and Most discriminating variable first
ggparcoord(mtcars, my_names_am, groupColumn=group_by_am, 
           alpha=0.8, scale="uniminmax", order="anyClass")

##################################################
## Plot matrix (1)
##################################################

GGally::ggpairs(mtcars2)

##################################################
## Plot matrix (2)
##################################################

############################################################
## Best practices: heat maps
############################################################

##################################################
## Heat maps
##################################################

# Create color palette
myColors <- brewer.pal(9, "Reds")

# Build the heat map from scratch
ggplot(barley, aes(x=year, y=variety,
                   fill=yield)) +
    geom_tile() +
    facet_wrap(~ site, ncol=1) +
    scale_fill_gradientn(colors=myColors)

##################################################
## Heat maps alternatives (1)
##################################################

# Line plots
ggplot(barley, aes(x=year, y=yield, col=variety, group=variety)) +
    geom_line() +
    facet_wrap(~ site, nrow=1)

##################################################
## Heat maps alternatives (2)
##################################################

# Create overlapping ribbon plot from scratch
ggplot(barley, aes(x=year, y=yield, col=site, group=site, fill=site)) +
    stat_summary(fun.y=mean, geom="line") +
    stat_summary(fun.data=mean_sdl, fun.args=list(mult=1), 
                 geom="ribbon", col=NA, alpha=0.1)

################################################################################
## Chapter 5: Case Study
################################################################################

############################################################
## CHIS - descriptive statistics
############################################################

# http://healthpolicy.ucla.edu/

##################################################
## Exploring data
##################################################

# Explore the dataset with summary and str
summary(adult)
str(adult)

# Age histogram
ggplot(adult, aes(x=SRAGE_P)) +
    geom_histogram()

# BMI histogram
ggplot(adult, aes(x=BMI_P)) +
    geom_histogram()

# Age colored by BMI, default binwidth
ggplot(adult, aes(x=SRAGE_P, fill=factor(RBMI))) +
    geom_histogram(binwidth=1)

##################################################
## Unusual values
##################################################

##################################################
## Default binwidths
##################################################

##################################################
## Data cleaning
##################################################

# Remove individual aboves 84
adult <- adult[adult$SRAGE_P <= 84, ] 

# Remove individuals with a BMI below 16 and above or equal to 52
adult <- adult[adult$BMI_P >= 16 & adult$BMI_P < 52, ]

# Relabel the race variable:
adult$RACEHPR2 <- factor(adult$RACEHPR2, 
                         labels = c("Latino", "Asian", "African American", 
                                    "White"))

# Relabel the BMI categories variable:
adult$RBMI <- factor(adult$RBMI, 
                     labels = c("Under-weight", "Normal-weight", "Over-weight", 
                                "Obese"))

##################################################
## Multiple histograms
##################################################

# Both adult (clean) and fix_strips are available

# Make a color palette: BMI_fill
BMI_fill <- scale_fill_brewer("BMI Category", palette = "Reds")

# Histogram, add BMI_fill and customizations
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1)  +
    BMI_fill +
    facet_grid(RBMI ~ .) +
    theme_classic() +
    fix_strips

##################################################
## Alternatives
##################################################

# Plot 1 - Count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1) +
    BMI_fill

# Plot 2 - Density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1, aes(y = ..density..)) +
    BMI_fill

# Plot 3 - Faceted count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1) +
    BMI_fill +
    facet_grid(RBMI ~ .)

# Plot 4 - Faceted density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1, aes(y = ..density..)) +
    BMI_fill +
    facet_grid(RBMI ~ .)

# Plot 5 - Density histogram with position = "fill"
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1, aes(y = ..density..), position = "fill") +
    BMI_fill

# Plot 6 - The accurate histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(binwidth = 1, aes(y = ..count../sum(..count..)), position = "fill") +
    BMI_fill

##################################################
## Do things manually
##################################################

# An attempt to facet the accurate frequency histogram from before (failed)
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
    geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
    BMI_fill +
    facet_grid(RBMI ~ .)

# Create DF with table()
DF <- table(adult$RBMI, adult$SRAGE_P)

# Use apply on DF to get frequency of each group
DF_freq <- apply(DF, 2, function(x) x/sum(x))

# Load reshape2 and use melt on DF to create DF_melted
library(reshape2)
DF_melted <- melt(DF_freq)

# Change names of DF_melted
names(DF_melted) <- c("FILL", "X", "value")

# Add code to make this a faceted plot
ggplot(DF_melted, aes(x = X, y = value, fill = FILL)) +
    geom_bar(stat = "identity", position = "stack") +
    BMI_fill + 
    facet_grid(FILL ~ .)

############################################################
## CHIS - mosaic plots
############################################################

##################################################
## Merimeko/mosaic plot
##################################################

# The initial contingency table
DF <- as.data.frame.matrix(table(adult$SRAGE_P, adult$RBMI))

# Add the columns groupsSum, xmax and xmin. Remove groupSum again.
DF$groupSum <- rowSums(DF)
DF$xmax <- cumsum(DF$groupSum)
DF$xmin <- DF$xmax - DF$groupSum
DF$groupSum <- NULL

# Copy row names to variable X
DF$X <- row.names(DF)

# Melt the dataset
library(reshape)
DF_melted <- melt(DF, id = c("X", "xmin", "xmax"), variable_name = "FILL")

# dplyr call to calculate ymin and ymax - don't change
library(dplyr)
DF_melted <- DF_melted %>% 
    group_by(X) %>% 
    mutate(ymax = cumsum(value/sum(value)),
           ymin = ymax - value/sum(value))

# Plot rectangles - don't change.
library(ggthemes)
ggplot(DF_melted, aes(ymin = ymin, 
                      ymax = ymax,
                      xmin = xmin, 
                      xmax = xmax, 
                      fill = FILL)) + 
    geom_rect(colour = "white") +
    scale_x_continuous(expand = c(0,0)) +
    scale_y_continuous(expand = c(0,0)) +
    BMI_fill +
    theme_tufte()

##################################################
## Adding statistics 
##################################################

# Perform chi.sq test (RBMI and SRAGE_P)
results <- chisq.test(table(adult$RBMI, adult$SRAGE_P))

# Melt results$residuals and store as resid
resid <- melt(results$residuals)

# Change names of resid
names(resid) <- c("FILL", "X", "residual")

# merge the two datasets:
DF_all <- merge(DF_melted, resid)

# Update plot command
library(ggthemes)
ggplot(DF_all, aes(ymin = ymin, 
                   ymax = ymax,
                   xmin = xmin, 
                   xmax = xmax, 
                   fill = residual)) + 
    geom_rect() +
    scale_fill_gradient2() +
    scale_x_continuous(expand = c(0,0)) +
    scale_y_continuous(expand = c(0,0)) +
    theme_tufte()

##################################################
## Adding text
##################################################

# Position for labels on x axis
DF_all$xtext <- DF_all$xmin + (DF_all$xmax - DF_all$xmin)/2

# Position for labels on y axis (don't change)
index <- DF_all$xmax == max(DF_all$xmax)
DF_all$ytext <- DF_all$ymin[index] + (DF_all$ymax[index] - DF_all$ymin[index])/2

# Plot
ggplot(DF_all, aes(ymin = ymin, ymax = ymax, xmin = xmin, 
                   xmax = xmax, fill = residual)) + 
    geom_rect(col = "white") +
    # geom_text for ages (i.e. the x axis)
    geom_text(aes(x = xtext, 
                  label = X),
              y = 1,
              size = 3,
              angle = 90,
              hjust = 1,
              show.legend = FALSE) +
    # geom_text for BMI (i.e. the fill axis)
    geom_text(aes(x = max(xmax), 
                  y = ytext,
                  label = FILL),
              size = 3,
              hjust = 1,
              show.legend  = FALSE) +
    scale_fill_gradient2() +
    theme_tufte() +
    theme(legend.position = "bottom")

##################################################
## Generalizations
##################################################

# Load all packages
library(ggplot2)
library(reshape2)
library(dplyr)
library(ggthemes)

# Script generalized into a function
mosaicGG <- function(data, X, FILL) {
    
    # Proportions in raw data
    DF <- as.data.frame.matrix(table(data[[X]], data[[FILL]]))
    DF$groupSum <- rowSums(DF)
    DF$xmax <- cumsum(DF$groupSum)
    DF$xmin <- DF$xmax - DF$groupSum
    DF$X <- row.names(DF)
    DF$groupSum <- NULL
    DF_melted <- melt(DF, id = c("X", "xmin", "xmax"), variable.name = "FILL")
    library(dplyr)
    DF_melted <- DF_melted %>% 
        group_by(X) %>% 
        mutate(ymax = cumsum(value/sum(value)),
               ymin = ymax - value/sum(value))
    
    # Chi-sq test
    results <- chisq.test(table(data[[FILL]], data[[X]])) # fill and then x
    resid <- melt(results$residuals)
    names(resid) <- c("FILL", "X", "residual")
    
    # Merge data
    DF_all <- merge(DF_melted, resid)
    
    # Positions for labels
    DF_all$xtext <- DF_all$xmin + (DF_all$xmax - DF_all$xmin)/2
    index <- DF_all$xmax == max(DF_all$xmax)
    DF_all$ytext <- DF_all$ymin[index] + (DF_all$ymax[index] - DF_all$ymin[index])/2
    
    # plot:
    g <- ggplot(DF_all, aes(ymin = ymin,  ymax = ymax, xmin = xmin, 
                            xmax = xmax, fill = residual)) + 
        geom_rect(col = "white") +
        geom_text(aes(x = xtext, label = X),
                  y = 1, size = 3, angle = 90, hjust = 1, show.legend = FALSE) +
        geom_text(aes(x = max(xmax),  y = ytext, label = FILL),
                  size = 3, hjust = 1, show.legend = FALSE) +
        scale_fill_gradient2("Residuals") +
        scale_x_continuous("Individuals", expand = c(0,0)) +
        scale_y_continuous("Proportion", expand = c(0,0)) +
        theme_tufte() +
        theme(legend.position = "bottom")
    print(g)
}

# BMI described by age
mosaicGG(adult, "SRAGE_P", "RBMI")

# Poverty described by age
mosaicGG(adult, "SRAGE_P", "POVLL")

# mtcars: am described by cyl
mosaicGG(mtcars, "cyl", "am")

# Vocab: vocabulary described by education
library(car)
mosaicGG(Vocab, "education", "vocabulary")

################################################################################