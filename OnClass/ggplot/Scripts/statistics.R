library(ggplot2)
p <- ggplot(iris, aes(x = Sepal.Width))
p + geom_histogram()
p + geom_bar()
p + stat_bin()


ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) +
  geom_bar()
ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) +
  stat_bin()

ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(fill = "skyblue") +
  geom_freqpoly(col = "red")

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth()
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(se = F)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(method = "lm")
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(method = "lm", fullrange = T)


#smoothing
# Explore the mtcars data frame with str()
str(mtcars)

# A scatter plot with LOESS smooth:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth()

# A scatter plot with an ordinary Least Squares linear model:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

# The previous plot, without CI ribbon:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

# The previous plot, without points:
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = "lm", se = F)



#grouping
# ggplot2 is already loaded

# Define cyl as a factor variable
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F)

# Complete the following ggplot command as instructed
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(method = "lm", se = F, aes(group = 1))



#Modifying stat_smooth
# Plot 1: change the LOESS span
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add span below 
  geom_smooth(se = F, span = 0.7)

# Plot 2: Set the overall model to LOESS and use a span of 0.7
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  # Change method and add span below
  stat_smooth(method = "loess", aes(group = 1), span = 0.7, 
              se = F, col = "black")

# Plot 3: Set col to "All", inside the aes layer of stat_smooth()
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(method = "loess",
              # Add col inside aes()
              aes(group = 1, col = "All"), 
              # Remove the col argument below
              se = F, span = 0.7)

# Plot 4: Add scale_color_manual to change the colors
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F, span = 0.75) +
  stat_smooth(method = "loess", 
              aes(group = 1, col="All"), 
              se = F, span = 0.7) +
  # Add correct arguments to scale_color_manual
  scale_color_manual("Cylinders", values = myColors)





#stat outside geom
#calculation statistics
set.seed(123)
xx <- rnorm(100)
mean(xx)

mean(xx) + (sd(xx)*c(-1,1))
library(Hmisc)
smean.sdl(xx,mult = 1)

#ggplot2
mean_sdl(xx, mult = 1)

#stat_summary()
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult =1))

ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.y = mean, geom = "point") + 
  stat_summary(fun.data = mean_sdl, fun.args = list(mult =1),
               geom = "errorbar", width = 0.1)
ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.y = mean, geom = "bar", fill ="skyblue") + 
  stat_summary(fun.data = mean_sdl, fun.args = list(mult =1),
               geom = "errorbar", width = 0.1)


ERR <- qt(0.975, length(xx)-1) * (sd(xx)/sqrt(length(xx)))
mean(xx) + (ERR * c(-1,1))
#Hmisc
smean.cl.normal(xx)
#ggplot
mean_cl_normal(xx)
ggplot(iris,aes(x = Species, y = Sepal.Length)) +
  stat_summary(fun.data = mean_cl_normal)


#data preparation
# Convert cyl and am to factors:
mtcars$cyl <-as.factor(mtcars$cyl) 
mtcars$am <- as.factor(mtcars$am)

# Define positions:
posn.d <- position_dodge(width = 0.1)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width = 0.2)
posn.j <- position_jitter(width = 0.2)

# base layers:
wt.cyl.am <-ggplot(mtcars, aes(x = cyl, y = wt, col = am, fill = am, group = am))
# wt.cyl.am, posn.d, posn.jd and posn.j are available

# Plot 1: Jittered, dodged scatter plot with transparent points
wt.cyl.am +
  geom_point(position = posn.jd, alpha = 0.6)

# Plot 2: Mean and SD - the easy way
wt.cyl.am +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), position = posn.d)

# Plot 3: Mean and 95% CI - the easy way
wt.cyl.am +
  stat_summary(fun.data = mean_cl_normal, position = posn.d)

# Plot 4: Mean and SD - with T-tipped error bars - fill in ___
wt.cyl.am +
  stat_summary(geom = "point", fun.y = mean, 
               position = posn.d) +
  stat_summary(geom = "errorbar", fun.data = mean_sdl, 
               position = posn.d, fun.args = list(mult = 1), width = 0.1)





