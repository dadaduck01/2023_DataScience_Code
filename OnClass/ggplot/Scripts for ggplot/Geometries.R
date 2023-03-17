library(ggplot2)
library(tidyr)
iris <- iris[c(5,1:4)]
#aes() inside geom_()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
    geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(aes(col=Species))

#Summary Statistics
iris.summary <- aggregate(iris[2:5], list(iris$Species), mean)
names(iris.summary)[1] <- "Species"
iris.summary

#Add Layers
ggplot(iris,aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
    geom_point() +
    geom_point(data = iris.summary, x= Sepal.Length, y = Sepal.Width, shape = 15, size = 5)

ggplot(iris,aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_point(data = iris.summary, shape = 21, size = 5, fill = "#00000080")

#crosshairs
ggplot(iris,aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_vline(data = iris.summary, aes(xintercept = Sepal.Length)) +
  geom_hline(data = iris.summary, aes(yintercept = Sepal.Width))






#scatter plots and jittering
# Shown in the viewer:
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point()

# Solutions:
# 1 - With geom_jitter()
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_jitter()

# 2 - Set width in geom_jitter()
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_jitter(width = 0.1)

# 3 - Set position = position_jitter() in geom_point() ()
ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point(position = position_jitter(0.1))


#New dataset - Vocab
# Examine the structure of Vocab
library(car)
str(Vocab)

# Basic scatter plot of vocabulary (y) against education (x). Use geom_point()
ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_point()


# Use geom_jitter() instead of geom_point()
ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_jitter()


# Using the above plotting command, set alpha to a very low 0.2
ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_jitter(alpha = 0.2)


# Using the above plotting command, set the shape to 1
ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_jitter(alpha = 0.2, shape = 1)






#histogram
ggplot(iris,aes(x = Sepal.Width)) +
    geom_histogram()

diff(range(iris$Sepal.Width)) / 30

ggplot(iris,aes(x = Sepal.Width)) +
  geom_histogram(binwidth = 0.1)

ggplot(iris,aes(x = Sepal.Width)) +
  geom_histogram(aes(y = ..density..) , binwidth = 0.1)


ggplot(iris,aes(x = Sepal.Width, fill = Species)) +
  geom_histogram(binwidth = 0.1,position = "stack")
ggplot(iris,aes(x = Sepal.Width, fill = Species)) +
  geom_histogram(binwidth = 0.1,position = "dodge")
ggplot(iris,aes(x = Sepal.Width, fill = Species)) +
  geom_histogram(binwidth = 0.1,position = "fill")




# 1 - Make a univariate histogram
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram()

# 2 - Plot 1, plus set binwidth to 1 in the geom layer
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 1)

# 3 - Plot 2, plus MAP ..density.. to the y aesthetic (i.e. in a second aes() function)
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y=..density..),binwidth = 1)

# 4 - plot 3, plus SET the fill attribute to "#377EB8"
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y=..density..),binwidth = 1,fill="#377EB8")


mtcars$am <- as.numeric(mtcars$am)
mtcars$am <- factor(mtcars$am)
# Draw a bar plot of cyl, filled according to am
ggplot(mtcars, aes(x = cyl, fill = as.factor(am))) +
  geom_bar()

# Change the position argument to stack
ggplot(mtcars, aes(x = cyl, fill = factor(am))) +
  geom_bar(position = "stack")


# Change the position argument to fill
ggplot(mtcars, aes(x = cyl, fill = factor(am))) +
  geom_bar(position = "fill")

# Change the position argument to dodge
ggplot(mtcars, aes(x = cyl, fill = factor(am))) +
  geom_bar(position = "dodge")


#Overlapping bar plots

# 1 - The last plot form the previous exercise
ggplot(mtcars, aes(x = cyl, fill = factor(am))) + 
  geom_bar(position = "dodge")

# 2 - Define posn_d with position_dodge()
posn_d <- position_dodge(width = 0.8)

# 3 - Change the position argument to posn_d
ggplot(mtcars, aes(x = cyl, fill = am)) + 
  geom_bar(position = posn_d)

# 4 - Use posn_d as position and adjust alpha to 0.6
ggplot(mtcars, aes(x = cyl, fill = am)) + 
  geom_bar(position = posn_d, alpha = 0.6)



mtcars$cyl <- factor(mtcars$cyl)
# A basic histogram, add coloring defined by cyl 
ggplot(mtcars, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 1)

# Change position to identity 
ggplot(mtcars, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 1, position = "identity")

# Change geom to freqpoly (position is identity by default) 
ggplot(mtcars, aes(mpg, col = cyl)) +
  geom_freqpoly(binwidth = 1)



#As a last example of bar plots, you'll return to histograms 
#(which you now see are just a special type of bar plot). 
#You saw a nice trick in a previous exercise of how to slightly overlap bars, 
#but now you'll see how to overlap them completely. 
#This would be nice for multiple histograms, as long as there are not too many different overlaps!
# 1 - Basic histogram plot command
ggplot(mtcars, aes(mpg)) + 
  geom_histogram(binwidth = 1)

mtcars$am <- factor(mtcars$am)
# 2 - Plot 1, Expand aesthetics: am onto fill
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1)

ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram()

# 3 - Plot 2, change position = "dodge"
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, position = "dodge")

# 4 - Plot 3, change position = "fill"
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, position = "fill")

# 5 - Plot 4, plus change position = "identity" and alpha = 0.4
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, position = "identity", alpha = 0.4)

mtcars$cyl <- factor(mtcars$cyl)
# 6 - Plot 5, plus change mapping: cyl onto fill
ggplot(mtcars, aes(mpg, fill = cyl)) + 
  geom_histogram(binwidth = 1, position = "identity", alpha = 0.4)










#Bar plots with color ramp, part 1
# Example of how to use a brewed color palette
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")


library(car)
str(Vocab)
Vocab$education <- factor(Vocab$education)
Vocab$vocabulary <- factor(Vocab$vocabulary)
# Use str() on Vocab to check out the structure
str(Vocab)

# Plot education on x and vocabulary on fill
# Use the default brewed color palette
ggplot(Vocab,aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_brewer(palette = "Set1")
#incomplete, 

new_col <- colorRampPalette(c("#FFFFFF", "#0000FF"))
new_col(4) # the newly extrapolated colours

#install.packages("RColorBrewer")
library(RColorBrewer)
# Definition of a set of blue colors
blues <- brewer.pal(9, "Blues") # from the RColorBrewer package

# 1 - Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)

# 2 - Use blue_range to adjust the color of the bars, use scale_fill_manual()

ggplot(Vocab,aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = blue_range(11)) +
  coord_flip()














#Line Plots - Time Series
# Print out head of economics
head(economics)

# Plot unemploy as a function of date using a line plot
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()

# Adjust plot to represent the fraction of total population that is unemployed
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line()

recess <- data.frame(rbind(c("1969-12-01","1970-11-01"),
                           c("1973-11-01","1975-03-01"),
                           c("1980-01-01","1980-07-01"),
                           c("1981-07-01","1982-11-01"),
                           c("1990-07-01","1991-03-01"),
                           c("2001-03-01","2001-11-01")))
colnames(recess) <- c("begin","end")
recess$begin <- as.Date(recess$begin)
recess$end <- as.Date(recess$end)

# Expand the following command with geom_rect() to draw the recess periods
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_rect(data = recess,
            aes(xmin = begin, xmax = end, ymin = -Inf, ymax = +Inf),
            inherit.aes = FALSE, fill = "yellow", alpha = 0.4) +
  geom_line()


#Multiple time series
fish.species <- read.csv("fishspecies.csv")
colnames(fish.species) <- c("Year","Pink","Chum","Sockeye","Coho","Rainbow","Chinook","Atlantic")
str(fish.species)

fish.tidy <- gather(fish.species, Species, Capture, -Year)
head(fish.tidy)

# Recreate the plot shown on the right
ggplot(fish.tidy, aes(x = Year, y = Capture, color = Species )) +
  geom_line()

