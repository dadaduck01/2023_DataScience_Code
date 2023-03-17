library(tidyr)
library(ggplot2)
iris <- iris[c(5,1:4)]
str(iris)

#base plot
plot(iris$Sepal.Length,iris$Sepal.Width)
points(iris$Sepal.Length,iris$Sepal.Width,col="red")

#ggplot2
ggplot(iris,aes(x = Sepal.Length,
                y = Sepal.Width)) +
  geom_point()


#ggplot object
p <- ggplot(iris,aes(x = Sepal.Length,
                y = Sepal.Width))
p + geom_point()
p + geom_jitter()

p <- ggplot(iris,aes(x = Sepal.Length,
                y = Sepal.Width)) +
  geom_point()
p




#Study base plot
# Plot the correct variables of mtcars
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)

# Change cyl inside mtcars to a factor
mtcars$fcyl <- as.factor(mtcars$cyl)

# Make the same plot as in the first instruction
plot(mtcars$wt, mtcars$mpg, col = mtcars$fcyl)



#The lm() function to calculate a linear model of mpg described by wt and save it as an object called carModel.
carModel <- lm(mpg ~ wt, data = mtcars)
# Basic plot
mtcars$cyl <- as.factor(mtcars$cyl)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)

#calls abline() with carModel as the first argument. Set the line type by passing the argument lty = 2.
abline(carModel, lty = 2)

# Plot each subset efficiently with lapply
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, mtcars, subset = (cyl == x)), col = x)
})

# This code will draw the legend of the plot
legend(x = 5, y = 33, legend = levels(mtcars$cyl),
       col = 1:3, pch = 1, bty = "n")



#ggplot2, mtcars

# Plot 1: add geom_point() to this command to create a scatter plot
mtcars$cyl <- as.factor(mtcars$cyl)

ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point()


# Plot 2: include the lines of the linear models, per cyl
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() +
  geom_smooth(method = "lm", se = T)

# Plot 3: include a lm for the entire dataset in its whole
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_smooth(aes(group = 1), method = "lm", se = FALSE, linetype = 2)






#proper data format
#Not correct
library(ggplot2)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point() + 
  geom_point(aes(x = Petal.Length, y = Petal.Width), col = "red")

library(tidyr)
#Make iris.tidy
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.") #tidyr package

#Make iris.wide
# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)
iris.wide <- iris %>%
  gather(key, value, -Species, -Flower) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

#
str(iris)
str(iris.wide)
str(iris.tidy)

# Plot with iris.tidy
ggplot(iris.tidy, aes(x = Species, y = Value, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Measure)


#Plot with iris.wide
ggplot(iris.wide, aes(x = Length, y = Width, color = Part)) +
  geom_jitter() +
  facet_grid(. ~ Species)

