################################################################################
## Source: DataCamp
## Course: Reporting with R Markdown
## Date: 2016-01-28
################################################################################

################################################################################
## Chapter 1: Authoring R Markdown Reports
################################################################################

############################################################
## Section 1: Introduction
############################################################

#################################################
## The R mardkwon exercise interface
#################################################

#################################################
## Explore R markdown
#################################################

############################################################
## Section 2: R code for your report
############################################################

#################################################
## Prepare the workspace for preliminary analysis
#################################################

library(nasaweather)
library(dplyr)
library(ggvis)

#################################################
## Prepare your data
#################################################

# The 'nasaweather' and 'dplyr' packages are available in the workspace

# Set the 'year' variable to 1995
year <- 1995

means <- atmos %>% 
    filter(year == year) %>%
    group_by(long, lat) %>%
    summarize(temp = mean(temp, na.rm = TRUE), 
              pressure = mean(pressure, na.rm = TRUE),
              ozone = mean(ozone, na.rm = TRUE),
              cloudlow = mean(cloudlow, na.rm = TRUE),
              cloudmid = mean(cloudmid, na.rm = TRUE),
              cloudhigh = mean(cloudhigh, na.rm = TRUE)) %>%
    ungroup()

# Inspect the means variable
means

#################################################
## Experiment with plot generation
#################################################

# The 'nasaweather', dplyr' and 'ggvis' packages are loaded in the workspace.

# Code for the previous exercise - do not change this
means <- atmos %>% 
    filter(year == 1995) %>%
    group_by(long, lat) %>%
    summarize(temp = mean(temp, na.rm = TRUE), 
              pressure = mean(pressure, na.rm = TRUE),
              ozone = mean(ozone, na.rm = TRUE),
              cloudlow = mean(cloudlow, na.rm = TRUE),
              cloudmid = mean(cloudmid, na.rm = TRUE),
              cloudhigh = mean(cloudhigh, na.rm = TRUE)) %>%
    ungroup()

# Change the code to plot the 'temp' variable vs the 'ozone' variable
means %>% 
    ggvis(x = ~temp, y = ~ozone) %>%
    layer_points()

#################################################
## Prepare a model component
#################################################

# The 'nasaweather' and dplyr' packages are already at your disposal
means <- atmos %>% 
    filter(year == 1995) %>%
    group_by(long, lat) %>%
    summarize(temp = mean(temp, na.rm = TRUE), 
              pressure = mean(pressure, na.rm = TRUE),
              ozone = mean(ozone, na.rm = TRUE),
              cloudlow = mean(cloudlow, na.rm = TRUE),
              cloudmid = mean(cloudmid, na.rm = TRUE),
              cloudhigh = mean(cloudhigh, na.rm = TRUE)) %>%
    ungroup()

# Change the model: base prediction only on 'temp'
mod <- lm(ozone ~ temp, data = means)

# Generate a model summary and interpret the results
summary(mod)

############################################################
## Section 3: Markdown
############################################################

#################################################
## Stying narrative sections
#################################################

# *italics*
# **bold**
# `code`

# [RStudio](www.rstudio.com)

# # First level header
# ## Second level header
# ### Third level header

#################################################
## Lists in R markdown
#################################################

# * item 1
# * item 2
# * item 3

# 1. item 1
# 2. item 2
# 3. item 3

#################################################
## LaTeX equations
#################################################

# centered equation block
# $$1 + 1 = 2$$

# inline equation
# $1 + 1 = 2$

################################################################################
## Chapter 2: Embedding Code
################################################################################

############################################################
## Section 4: Knitr
############################################################

#################################################
## R code chunks
#################################################

# ```{r}
# some code
# ```

#################################################
## Customize R code chunks
#################################################

# ```{r warning = FALSE, error = FALSE}
# "four" + "five"
# ```

#################################################
## Popular chunk options
#################################################

# Three of the most popular chunk options are echo, eval and results.

# If echo = FALSE, R Markdown will not display the code in the final document 
# (but it will still run the code and display its results unless told otherwise).

# If eval = FALSE, R Markdown will not run the code or include its results, 
# (but it will still display the code unless told otherwise).

# If results = 'hide', R Markdown will not display the results of the code 
# (but it will still run the code and display the code itself unless told otherwise).

#################################################
## Inline R code
#################################################

# The factorial of four is `r factorial(4)`.

#################################################
## Labeling and reusing code chunks
#################################################

# The code chunk below would be assigned the label simple_sum:
    
# ```{r simple_sum, results = 'hide'}
# 2 + 2
# ```

# However, because the results option is equal to hide, no output is shown. 
# This is what appears in the output document:
    
# 2 + 2

# knitr provides the option ref.label to refer to previously defined 
# and labeled code chunks. If used correctly, knitr will copy the code 
# of the chunk you referred to and repeat it in the current code chunk. 
# This feature enables you to separate R code and R output
# in the output document, without code duplication.

# ```{r ref.label='simple_sum', echo = FALSE}
# ```

# produces the output you would expect:

## [1] 4

# ```{r message=FALSE}
# library(dplyr)
# library(ggvis)
# ```

# ```{r chained, results='hide'}    
# mtcars %>%
#     group_by(factor(cyl)) %>%
#     ggvis(~mpg, ~wt, fill = ~cyl) %>% 
#     layer_points()
# ```

# The `ggvis` plot gives us a nice visualization of the `mtcars` data set:
    
# ```{r ref.label='chained', echo=FALSE}
# ```

################################################################################
## Chapter 3: Compiling Reports
################################################################################

############################################################
## Section 5: Pandoc
############################################################

#################################################
## Alternative output formats
#################################################

# ---
# output: html_document
# ---

# ---
# output: pdf_document
# ---

# ---
# output: word_document
# ---

# ---
# output: md_document
# ---

# from command line
# rmarkdown::render(<file path>)

# To visualize data in a pdf document, need to use ggplot2 instead of ggvis.

#################################################
## Create slideshows
#################################################

# ---
# output: beamer_presentation
# ---

# ---
# output: ioslides_presentation
# ---

# ---
# output: slidy_presentation
# ---

# R Markdown will start a new slide at each first or second level header.
# You can insert additional slide breaks with Markdown's horizontal rule syntax:
# ***

#################################################
## Specify knitr and pandoc operations
#################################################

# ---
# title: "Demo"
# output:
#   pdf_document:
#     highlight: zenburn
# ---

# ---
# title: "Demo"
# output:
#   html_document:
#     theme: spacelabe
# ---

#################################################
## Brand your reports with style sheets
#################################################

# You can set the theme option of html_document to one of 
# default, cerulean, journal, flatly, readable, spacelab, united, or cosmo.

############################################################
## Section 6: Shiny
############################################################

#################################################
## Shiny to make your reports interactive
#################################################

# You add runtime: shiny to the file's YAML header
# You use an HTML output format (like html_document, ioslides_presentation, 
# or slidy_presentation).

#################################################
## Interactive ggvis graphics
#################################################

# You add runtime: shiny to the file's YAML header
# You use an HTML output format (like html_document, ioslides_presentation, 
# or slidy_presentation).
# You do not need to wrap your interactive ggvis plots in a render function.

################################################################################
## Chapter 4: Configuring R Markdown
################################################################################

############################################################
## Section 7: Set-up
############################################################

#################################################
## Software for R markdown
#################################################

#################################################
## Prepare your system to use R markdown
#################################################

################################################################################