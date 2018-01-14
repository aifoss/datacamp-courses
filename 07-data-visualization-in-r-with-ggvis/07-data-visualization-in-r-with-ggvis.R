################################################################################
## Source: DataCamp
## Course: Data Visualization in R with ggvis
## Date: 2016-01-23
################################################################################

################################################################################
## Chapter 1: The Grammar of Graphics
################################################################################

############################################################
## Section 1: Introduction to ggvis
############################################################

install.packages("ggvis")

###################################
## Load ggvis and start to explore
###################################

# ggvis is already installed for you; now load it and start playing around
library(ggvis)

# change the code below to plot the disp variable of mtcars on the x axis
#mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()
mtcars %>% ggvis(~disp, ~mpg) %>% layer_points()

##############################
## ggvis and its capabilities
##############################

# The ggvis packages is loaded into the workspace already

# Change the code below to make a graph with red points
mtcars %>% ggvis(~wt, ~mpg, fill := "red") %>% layer_points()

# Change the code below draw smooths instead of points
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

# Change the code below to make a graph containing both points and a smoothed 
# summary line
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

############################################################
## Section 2: The grammar of ggvis
############################################################

####################################
## ggvis grammar ~ graphics grammar
####################################

#<data>  %>% 
#    ggvis(~<x property>,~<y property>, 
#          fill = ~<fill property>, ...) %>% 
#    layer_<marks>()

# Make a scatterplot of the pressure dataset
pressure %>% ggvis(~temperature, ~pressure) %>% layer_points()

# Adapt the code you wrote for the first challenge: show bars instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()

# Adapt the code you wrote for the first challenge: show lines instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Adapt the code you wrote for the first challenge: map the fill property 
# to the temperature variable
pressure %>% 
    ggvis(~temperature, ~pressure, fill=~temperature) %>% 
    layer_points()

# Extend the code you wrote for the previous challenge: map the size property 
# to the pressure variable
pressure %>% 
    ggvis(~temperature, ~pressure, fill=~temperature, size=~pressure) %>% 
    layer_points()

#####################################
## 4 essential components of a graph
#####################################

# Every ggvis graph contains 4 essential components: 
# data, a coordinate system, marks and corresponding properties.

faithful %>% 
    ggvis(~waiting, ~eruptions, fill := "red") %>% 
    layer_points() %>% 
    add_axis("y", title = "Duration of eruption (m)", 
             values = c(2, 3, 4, 5), subdivide = 9) %>% 
    add_axis("x", title = "Time since previous eruption (m)")

################################################################################
## Chapter 2: Lines and Syntax
################################################################################

############################################################
## Section 3: Three new types of syntax
############################################################

###################################
## Three operators: %>%, =, and :=
###################################

# Rewrite the code with the pipe operator     
#layer_points(ggvis(faithful, ~waiting, ~eruptions))
ggvis(faithful, ~waiting, ~eruptions) %>% layer_points()

# Modify this graph to map the size property to the pressure variable
#pressure %>% ggvis(~temperature, ~pressure) %>% layer_points()
pressure %>% ggvis(~temperature, ~pressure, size=~pressure) %>% layer_points()

# Modify this graph by setting the size property to 100 pixels
#pressure %>% ggvis(~temperature, ~pressure) %>% layer_points()
pressure %>% ggvis(~temperature, ~pressure, size:=100) %>% layer_points()

# Fix this code to set the fill property to red
#pressure %>% ggvis(~temperature, ~pressure, fill = "red") %>% layer_points()
pressure %>% ggvis(~temperature, ~pressure, fill:="red") %>% layer_points()

##################################
## Referring to different objects
##################################

#You can refer to three different types of objects in your ggvis code: 
#objects, variables, and raw values.

#If you type a string of letters, ggvis will treat the string as an object name. 
#   It will look for an object with that name in your current environment.
#If you place a tilde, ~, at the start of the string, ggvis will treat 
#   the string as a variable name. It will look for the column with that name 
#   in the data set that the graph visualizes.
#If you surround a string of letters with quotation marks, ggvis will treat 
#   the string as a raw value, e.g., a piece of text.

# Which of the commands below will create a graph that has green points? 

red <- "green"
pressure$red <- pressure$temperature

# GRAPH A
pressure %>% 
    ggvis(~temperature, ~pressure, 
          fill = ~red) %>% 
    layer_points()   

# GRAPH B  
pressure %>% 
    ggvis(~temperature, ~pressure, 
          fill = "red") %>% 
    layer_points() 

# GRAPH C -> answer
pressure %>% 
    ggvis(~temperature, ~pressure, 
          fill := red) %>% 
    layer_points() 

######################################
## Referring to different objects (2)
######################################

#Which of the commands below will create a graph that uses color to reveal 
# the values of the temperature variable in the pressure data set? 

red <- "green"
pressure$red <- pressure$temperature

# GRAPH A --> answer
pressure %>% 
    ggvis(~temperature, ~pressure, 
          fill = ~red) %>% 
    layer_points()   

# GRAPH B  
pressure %>% 
    ggvis(~temperature, ~pressure, 
          fill = "red") %>% 
    layer_points() 

# GRAPH C
pressure %>% 
    ggvis(~temperature, ~pressure, 
          fill := red) %>% 
    layer_points() 

#########################
## Properties for points
#########################

# You can manipulate many different properties when using the points mark, 
# including x, y, fill, fillOpacity, opacity, shape, size, stroke, 
# strokeOpacity, and strokeWidth.

# The shape property in turn recognizes several different values: 
# circle (default), square, cross, diamond, triangle-up, and triangle-down.

# Change the code to set the fills using pressure$black. 
# pressure$black is loaded into workspace.

#pressure %>% 
#  ggvis(~temperature, 
#        ~pressure, 
#        fill = ~black) %>% 
#  layer_points()

pressure %>%
    ggvis(~temperature,
          ~pressure,
          fill := pressure$black[1]) %>%
    layer_points()      

# Plot the faithful data as described in the second instruction
# Plot the faithful data with the points mark.
# Put the waiting variable on the x axis and the eruption variable on the y axis.
# Map size to the eruptions variale.
# Set the opacity to 0.5 (50%), the fill to blue, and the stroke to black.
faithful %>%
    ggvis(~waiting,
          ~eruptions,
          size = ~eruptions,
          opacity := 0.5,
          fill := "blue",
          stroke := "black") %>%
    layer_points()        

# Plot the faithful data as described in the third instruction
# Plot the faithful data with the points mark.
# Put the waiting variable on the x axis and the eruptions variable 
# on the y axis.
# Map fill opacity to the eruptions variable.
# Set size to 100, the fill to red, the stroke to red, and the shape to cross.

faithful %>%
    ggvis(~waiting,
          ~eruptions,
          fillOpacity = ~eruptions,
          size := 100,
          fill := "red",
          stroke := "red",
          shape := "cross") %>% layer_points()

############################################################
## Section 4: the line, a special type of mark
############################################################

########################
## Properties for lines
########################

# Similar to points, lines have specific properties; 
# they respond to: x, y, fill, fillOpacity, opacity, stroke, strokeDash, 
# strokeOpacity, and strokeWidth.

%>% layer_points()
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Set the properties described in the second instruction in the graph below
# Use the lines mark, set the line color to red, the line width to 2 pixels,
# and the line type to use dashes that are 6 pixels long
pressure %>% 
    ggvis(~temperature, 
          ~pressure,
          stroke := "red",
          strokeWidth := 2,
          strokeDash := 6) %>%
    layer_lines()

###########################
## Path marks and polygons
###########################

# The paths mark is similar to the lines mark except that it connects points 
# in the order that they appear in the data set.

# change the third line of code to plot a map of Texas
library("maps")
texas <- ggplot2::map_data("state", region = "texas")
#texas %>% ggvis(~long, ~lat) %>% layer_lines()
texas %>% ggvis(~long, ~lat) %>% layer_paths()

# Same plot, but set the fill property of the texas map to dark orange
texas %>% ggvis(~long, ~lat, fill:="darkorange") %>% layer_paths()

######################
## Display model fits
######################

# compute_model_prediction() is a useful function to use with line graphs. 
# It takes a data frame as input and returns a new data frame as output. 
# The new data frame will contain the x and y values of a line fitted 
# to the data in the original data frame.

# For example, the code below computes a line that shows the relationship 
# between the eruptions and waiting variables of the faithful data set.

faithful %>%
    compute_model_prediction(eruptions ~ waiting, model = "lm")

# Notice that compute_model_prediction() takes a couple of arguments. 
# First we use the pipe operator to pass it the data set faithful. 
# Then we provide an R formula, eruptions ~ waiting. 
# An R formula contains two variables connected by a tilde, ~. 
# compute_model_prediction() will use the variable on the left 
# as the y variable for the line, and it will use the variable on the right 
# as the x variable for the line.

# Finally, compute_model_prediction() takes a model argument. 
# This is the name of the R modelling function that compute_model_prediction() 
# should use to calculate the line. lm() is R's function for building 
# linear models. 
# compute_smooth() is a special case of compute_model_prediction() 
# where the model argument is set to loess by default. 
# In this case the function will create a smoothed set of points.

# Compute the x and y coordinates for a loess smooth line that predicts mpg 
# with the wt
mtcars %>% compute_smooth(mpg ~ wt)

############################################
## compute_smooths() to simplify model fits
############################################

# compute_smooth() always returns a data set with two columns, 
# one named pred_ and one named resp_. As a result, it is very easy to use 
# compute_smooth() to plot a smoothed line of your data. 
# For example, you can extend your code from the last exercise 
# to plot the results of compute_smooth() as a line graph.

# Calling compute_smooth() can be a bit of a hassle, so ggvis includes a layer 
# that automatically calls compute_smooth() in the background 
# and plots the results as a smoothed line. That layer is layer_smooths().

# Use 'ggvis()' and 'layer_lines()' to plot the results of compute smooth
mtcars %>% compute_smooth(mpg ~ wt) %>% ggvis(~pred_, ~resp_) %>% layer_lines()

# Recreate the graph you coded above with 'ggvis()' and 'layer_smooths()' 
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

# Extend the code for the second plot and add 'layer_points()' to the graph
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

################################################################################
## Chapter 3: Transformations
################################################################################

############################################################
## Section 5: Compute functions
############################################################

##################
## Histograms (1)
##################

# A histogram - plotted using layer_histograms() - shows the distribution 
# of a single continuous variable. To do this, a histogram divides the x axis 
# into evenly spaced intervals, known as bins. 

# To change the binwidth of a histogram, map the width argument 
# of layer_histograms() to a number.

# width is an argument of layer_histograms(). For best results, you should 
# write the width argument in the parentheses that follow layer_histograms(). 
# Always map width to its value; This will ensure that it uses the same units 
# as the variable on the x axis.

# Build a histogram of the waiting variable of the faithful data set.
faithful %>% ggvis(~waiting) %>% layer_histograms()

# Build the same histogram, but with a binwidth (width argument) of 5 units
faithful %>% ggvis(~waiting) %>% layer_histograms(width = 5)

##################
## Histograms (2)
##################

# Behind the scenes, layer_histograms() calls compute_bin() to calculate 
# these counts. 
# You can calculate the same values by calling compute_bin() manually. 
# compute_bin() requires at least two arguments: 
# a data set (which you will provide with the %>% syntax), 
# and a variable name to bin on. 
# You can also pass compute_bin() a binwidth argument, 
# just as you pass layer_histograms() a binwidth argument.

# Transform the code below: just compute the bins instead of plotting 
# a histogram
#faithful %>% ggvis(~waiting) %>% layer_histograms(width = 5)
faithful %>% compute_bin(~waiting, width=5)

# Combine the solution to the first challenge with layer_rects() to build 
# a histogram
# Combine the output of the solution to the first instruction with ggvis() 
# and layer_rects().
# You need to pass ggvis() four properties: x, x2, y, and y2.
# These should correspond to the min/max x and y values for each rectangle.
# Make sure to keep the width equal to 5.
faithful %>% 
    compute_bin(~waiting, width=5) %>%
    ggvis(x=~xmin_, x2=~xmax_, y=0, y2=~count_) %>%
    layer_rects()

#################
## Density plots
#################

# compute_density() takes two arguments, a data set and a variable name. 
# It returns a data frame with two columns: pred_, the x values of 
# the variable's density line, and resp_, the y values of the variable's 
# density line.

# You can use layer_densities() to create density plots. 
# Like layer_histograms() it calls the compute function that it needs 
# in the background, so you do not need to worry about calling 
# compute_density().

# Combine compute_density() with layer_lines() to make a density plot 
# of the waiting variable.
faithful %>% compute_density(~waiting) %>% ggvis(~pred_, ~resp_) %>% layer_lines()

# Build a density plot directly using layer_densities. 
# Use the correct variables and properties.
faithful %>% ggvis(~waiting, fill:="green") %>% layer_densities()

#############
## Shortcuts
#############

# Complete the code to plot a bar graph of the cyl factor.
mtcars %>% ggvis(~factor(cyl)) %>% layer_bars()

# Adapt the solution to the first challenge to just calculate 
# the count values. No plotting!
mtcars %>% compute_count(~factor(cyl))

############################################################
## Section 6: ggvis and dplyr
############################################################

######################
## ggvis and group_by
######################

# Both ggvis and dplyr are loaded into the workspace

# Change the code to plot a unique smooth line for each value 
# of the cyl variable.
#mtcars %>% 
#    group_by(am) %>% 
#    ggvis(~mpg, ~wt, stroke = ~factor(am)) %>% 
#    layer_smooths()
mtcars %>% 
    group_by(cyl) %>% 
    ggvis(~mpg, ~wt, stroke=~factor(cyl)) %>% 
    layer_smooths()

# Adapt the graph to contain a separate density for each value of cyl.
#mtcars %>% ggvis(~mpg) %>% layer_densities()
mtcars %>% group_by(cyl) %>% ggvis(~mpg) %>% layer_densities()

# Copy and alter the solution to the second challenge to map the fill property to a categorical version of cyl.
mtcars %>% 
    group_by(cyl) %>% 
    ggvis(~mpg, fill=~factor(cyl)) %>% 
    layer_densities()

###################################
## group_by() versus interaction()
###################################

# group_by() can also group data based on the interaction of two or more 
# variables. To group based on the interaction of multiple variables, 
# give group_by() multiple variable names, like this:
    
#    <data> %>% group_by(<var1>, <var2>, <var3>, ...)

# group_by will create a separate group for each distinct combination 
# of values within the grouping variables. group_by() does not change 
# the raw values of the data set. The grouping information is saved 
# as an attribute (e.g., metadata). You can remove the grouping information 
# from a data set with ungroup() (e.g., mtcars %>% ungroup()).

# You can also map properties to unique combinations of variables. 
# To do this, use the interaction() function. For example,

#    stroke = ~interaction(<var1>, <var2>, <var3>)

# will map stroke to the unique combinations of <var1>, <var2>, and <var3>.

# Alter the graph below: separate density for each unique combination 
# of 'cyl' and 'am'.
# mtcars %>% 
#    group_by(cyl) %>% 
#    ggvis(~mpg, fill = ~factor(cyl)) %>% 
#    layer_densities()
mtcars %>% 
    group_by(cyl, am) %>% 
    ggvis(~mpg, fill=~factor(cyl)) %>%
    layer_densities()

# Update the graph below to map `fill` to the unique combinations 
# of the grouping variables.
# mtcars %>% 
#    group_by(cyl, am) %>% 
#    ggvis(~mpg, fill = ~factor(cyl)) %>% 
#    layer_densities()
mtcars %>% 
    group_by(cyl, am) %>%
    ggvis(~mpg, fill=~interaction(cyl,am)) %>%
    layer_densities()

########################
## Chaining is a virtue
########################
    
mtcars %>% 
    group_by(am) %>% 
    ggvis(~mpg, ~hp) %>% 
    layer_smooths(stroke = ~factor(am)) %>% 
    layer_points(fill = ~factor(am))

################################################################################
## Chapter 4: Interactivity and Layers
################################################################################

############################################################
## Section 7: Interactive plots
############################################################

###################################
## The basics of interactive plots
###################################

# You can make your plots interactive by setting a property to the output 
# of an input widget. ggvis comes with seven input widgets: 
# input_checkbox(), input_checkboxgroup(), input_numeric(), 
# input_radiobuttons(), input_select(), input_slider(), and input_text(). 
# By default, each returns their current value as a number or character string.

# Run this code and inspect the output. Follow the link in the instructions 
# for the interactive version
faithful %>% 
    ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
          shape := input_select(label = "Choose shape:", 
                                choices = c("circle", "square", "cross", "diamond", 
                                            "triangle-up", "triangle-down"))) %>% 
    layer_points()

# Copy the first code chunk and alter the code to make the fill property 
# interactive using a select box
# Add a fill property; set it equal to a select box that has the label "Choose color:"
# and provides the choices black, red, blue, and green.
faithful %>% 
    ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
          shape := input_select(label = "Choose shape:", 
                                choices = c("circle", "square", "cross", "diamond", 
                                            "triangle-up", "triangle-down")),
          fill := input_select(label = "Choose color:",
                               choices = c("black", "red", "blue", "green"))) %>% 
    layer_points()

# Add radio buttons to control the fill of the plot
mtcars %>% 
    ggvis(~mpg, ~wt,
          fill := input_radiobuttons(label="Choose color:",
                                     choices = c("black","red","blue","green"))) %>% 
    layer_points()

################################
## Input widgets in more detail
################################

# input_text() provides a text field for users to type input into. 
# Instead of assigning input_text() a choices argument, you assign it 
# a value argument: a character string to display when the plot first loads.

# By default, input widgets return their values as character strings 
# and numbers. To have a widget return its value as a variable name, 
# you need to add the extra argument map = as.name.

# For example, the text widget in the first challenge will pass the character 
# string "black" to the fill argument, which is useful for setting. 
# If we add map = as.name to the arguments of input_text(), the widget would r
# eturn ~black which is useful for mapping (or would be if black were 
# a real variable in mtcars)

# Change the radiobuttons widget to a text widget 
mtcars %>% 
    ggvis(~mpg, ~wt, 
          fill := input_text(label = "Choose color:",
                             value = "black")) %>% 
    layer_points()

# Map the fill property to a select box that returns variable names
# Map fill to a select box that returns variables names
mtcars %>% 
    ggvis(~mpg, ~wt,
          fill = input_select(label = "Choose fill variable:",
                               choices = names(mtcars),
                               map = as.name)) %>% 
    layer_points()

################################
## Control paramters and values
################################

# ggvis often needs additional parameters to build the correct graphs. 
# You can also use widgets to control these parameters. Typically, you want 
# to use the input_numeric() and input_slider() widgets to set numerical 
# parameters.

# Map the bindwidth to a numeric field ("Choose a binwidth:")
# mtcars %>% 
#   ggvis(~mpg) %>% 
#   layer_histograms(width = 2)
mtcars %>%
    ggvis(~mpg,
          width = input_numeric(label="Choose a binwidth:",
                                value=1)) %>%
    layer_histograms()

# Map the binwidth to a slider bar ("Choose a binwidth:") with the correct 
# specifications
# Map binwidth to a slider bar that uses the label "Choose a binwidth:"
# and has a min value of 1 and a max value of 20
# input_slider will place the initival value at (min+max)/2
# mtcars %>% 
#   ggvis(~mpg) %>% 
#   layer_histograms(width = 2)
mtcars %>%
    ggvis(~mpg,
          width = input_slider(label="Choose a binwidth:",
                               min=1,
                               max=20)) %>%
    layer_histograms()                             

############################################################
## Section 8: Multi-layered plots
############################################################

##############################################
## There is no limit on the number of layers!
##############################################

# Add a layer of points to the graph below.
pressure %>% 
    ggvis(~temperature, ~pressure, stroke := "skyblue") %>% 
    layer_lines() %>%
    layer_points()

# Copy and adapt the solution to the first instruction below so that 
# only the lines layer uses a skyblue stroke.
pressure %>% 
    ggvis(~temperature, ~pressure) %>% 
    layer_lines(stroke := "skyblue") %>%
    layer_points()

# Rewrite the code below so that only the points layer uses the shape property.
pressure %>% 
    ggvis(~temperature, ~pressure) %>% 
    layer_lines(stroke := "skyblue") %>% 
    layer_points(shape := "triangle-up")

# Refactor the code for the graph below to make it as concise as possible
# pressure %>% 
#   ggvis() %>% 
#   layer_lines(~temperature, ~pressure, stroke := "skyblue", 
#               strokeOpacity := 0.5, strokeWidth := 5) %>% 
#   layer_points(~temperature, ~pressure, fill = ~temperature, 
#               strokeOpacity := 0.5, shape := "triangle-up", 
#               stroke := "skyblue", size := 300, strokeWidth := 5)
pressure %>%
    ggvis(~temperature, 
          ~pressure, 
          stroke:="skyblue",
          strokeOpacity:=0.5, 
          strokeWidth:=5) %>%
    layer_lines() %>%
    layer_points(fill=~temperature,
                 shape:="triangle-up",
                 size:=300)

#############################################
## Taking local and global to the next level
#############################################

# layer_model_predictions() plots the prediction line of a model 
# fitted to the data. It is similar to layer_smooths(), but you can extend it 
# to more models than just the "loess" or "gam" model.

# layer_model_predictions() takes a parameter named model; it should be set 
# to a character string that contains the name of an R model function. 

# Create a graph containing a scatterplot, a linear model and a smooth line.
# Create a scatterplot of the pressure data set that has the temperature 
# variable on the x axis and the pressure variable on the y axis. 
# Connect the points with a black line that has 50% opacity. Then add 
# a linear model line to the data that is navy in color. Then add a smooth line 
# that is skyblue in color.

pressure %>%
    ggvis(~temperature,
          ~pressure) %>%
    layer_points() %>%
    layer_lines(fill:="black",
                opacity:=0.5) %>%
    layer_model_predictions(model="lm",
                            stroke:="navy") %>%
    layer_smooths(stroke:="skyblue")

pressure %>% 
    ggvis(~temperature, ~pressure, stroke := "darkred") %>% 
    layer_lines(stroke := "orange", 
                strokeDash := 5, 
                strokeWidth := 5) %>% 
    layer_points(size := 100, 
                 fill := "lightgreen", 
                 shape := "circle") %>%
    layer_smooths()

################################################################################
## Chapter 5: Cutomzizing Axes, Legends, and Scales
################################################################################

############################################################
## Section 9: Axes and legends
############################################################

########
## Axes
########

# add_axis() allows you to change the titles, tick schemes and positions 
# of your axes. The example code below clarifies:

add_axis("x", 
         title = "x axis title", 
         values = c(1,2,3), 
         subdivide = 5,
         orient = "top")

# The title argument is rather straightforward, as it simply sets the title 
# of the axis you specified in the first argument.

# You can use the values argument of add_axis to determine where labelled tick 
# marks will appear on each axis. You can use the subdivide argument 
# to insert unlabelled tick marks between the labelled tick marks on an axis.

# To control where an axis appears, use the orient argument. For example, 
# the above code makes the x axis appear on the "top" (and not on the "bottom") 
# side of the graph. Similarly, you can have the y axis appear on the "left" 
# or "right" side of the graph.

# Add the title of the x axis: "Time since previous eruption (m)"
faithful %>% 
    ggvis(~waiting, ~eruptions) %>% 
    layer_points() %>% 
    add_axis("y", title = "Duration of eruption (m)") %>%
    add_axis("x", title = "Time since previous eruption (m)")

# Add to the code to place a labelled tick mark at 50, 60, 70, 80, 90 
# on the x axis.
faithful %>% 
    ggvis(~waiting, ~eruptions) %>% 
    layer_points() %>% 
    add_axis("y", 
             title = "Duration of eruption (m)", 
             values = c(2, 3, 4, 5), 
             subdivide = 9) %>% 
    add_axis("x", 
             title = "Time since previous eruption (m)",
             values = c(50, 60, 70, 80, 90), 
             subdivide = 9)

# Change the code below to change the axes' locations
# Move the y axis to the right side of the plot
# and move the x axis to the top of the plot
faithful %>% 
    ggvis(~waiting, ~eruptions) %>% 
    layer_points() %>%
    add_axis("x", orient = "top") %>%
    add_axis("y", orient = "right")

###########
## Legends
###########

# Add a legend to the plot below: use the correct title and orientation
faithful %>% 
    ggvis(~waiting, 
          ~eruptions, 
          opacity := 0.6, 
          fill = ~factor(round(eruptions))) %>% 
    layer_points() %>%
    add_legend("fill",
               title="~ duration (m)",
               orient="left")

# Use add_legend() to combine the legends in the plot below. 
# Set the legend title to "~duration (m)" 
# and specify that only the values 2,3,4,5 should receive a labelled symbol.
faithful %>% 
    ggvis(~waiting, 
          ~eruptions, 
          opacity := 0.6, 
          fill = ~factor(round(eruptions)), 
          shape = ~factor(round(eruptions)), 
          size = ~round(eruptions))  %>%
    layer_points() %>%
    add_legend(c("fill","shape","size"),
               title="~ duration (m)",
               values=c(2,3,4,5))


############################################################
## Section 10: Customize property mappings
############################################################

###############
## Scale types
###############

# ggvis provides several different functions for creating scales: 
# scale_datetime(), scale_logical(), scale_nominal(), scale_numeric(), 
# scale_singular().

# Add a scale_numeric() function to the code below to make the stroke color 
# range from "darkred" to "orange".
mtcars %>% 
    ggvis(~wt, ~mpg, fill = ~disp, stroke = ~disp, strokeWidth := 2) %>%
    layer_points() %>%
    scale_numeric("fill", range = c("red", "yellow")) %>%
    scale_numeric("stroke", range = c("darkred", "orange"))

# Change the graph below to make the fill colors range from green to beige.
mtcars %>% ggvis(~wt, ~mpg, fill = ~hp) %>%
    layer_points() %>%
    scale_numeric("fill", range = c("green", "beige"))

# Create a scale that will map factor(cyl) to a new range of colors: 
# purple, blue, and green. 
mtcars %>% ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>%
    layer_points() %>%
    scale_nominal("fill", range = c("purple", "blue", "green"))

##############################
## Adjust any visual property
##############################

# Add a scale that limits the range of opacity from 0.2 to 1. 
mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~factor(cyl), opacity = ~hp) %>%
    layer_points() %>%
    scale_numeric("opacity", range=c(0.2, 1))

# Add a second scale that will expand the x axis to cover data values 
# from 0 to 6.
mtcars %>% ggvis(~wt, ~mpg, fill = ~disp) %>%
    layer_points() %>%
    scale_numeric("y", domain = c(0, NA)) %>%
    scale_numeric("x", domain = c(0, 6))

###################
## "=" versus ":="
###################

# Whenever you use = to map a variable to a property, ggvis will use 
# a scale to transform the variable values into visual values. 
# Whenever you set a value (or variable) to a property with :=, 
# ggvis will pass the value on as is, without transforming it.

# Set the fill value to the color variable instead of mapping it, and see what happens
mtcars$color <- c("red", "teal", "#cccccc", "tan")
mtcars %>% ggvis(x = ~wt, y = ~mpg, fill := ~color) %>% layer_points()

################################################################################