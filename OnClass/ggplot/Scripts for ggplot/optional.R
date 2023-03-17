library(plyr)
library(ggplot2)

#One Variable: Continuous and Discrete
set.seed(1234)
wdata = data.frame(
  sex = factor(rep(c("F", "M"), each=200)),
  weight = c(rnorm(200, 55), rnorm(200, 58)))
head(wdata)

mu <- ddply(wdata,"sex",summarise, grp.mean = mean(weight))
head(mu)

a <- ggplot(wdata,aes(x=weight))


# Basic plot
a + geom_area(stat = "bin")
# change fill colors by sex
a + geom_area(aes(fill = sex), stat ="bin", alpha=0.6) +
  theme_classic()
a + geom_area(aes(fill = sex, y = ..density..), stat ="bin", alpha=0.6) +
  theme_classic()


pdf("density.pdf")
# Basic plot
a + geom_density()
# change line colors by sex
a + geom_density(aes(color = sex)) 
# Change fill color by sex
# Use semi-transparent fill: alpha = 0.4
a + geom_density(aes(fill = sex), alpha=0.4)
# Add mean line and Change color manually
a + geom_density(aes(color = sex)) +
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed") +
  scale_color_manual(values=c("#999999", "#E69F00"))
dev.off()


pdf("dotplot.pdf")
# Basic plot
a + geom_dotplot()
# change fill and color by sex
a + geom_dotplot(aes(fill = sex)) 
# Change fill color manually 
a + geom_dotplot(aes(fill = sex)) +
  scale_fill_manual(values=c("#999999", "#E69F00"))
dev.off()



pdf("freqpoly.pdf")
# Basic plot
a + geom_freqpoly() 
# change y axis to density value
# and change theme
a + geom_freqpoly(aes(y = ..density..)) +
  theme_minimal()
# change color and linetype by sex
a + geom_freqpoly(aes(color = sex, linetype = sex)) +
  theme_minimal()
dev.off()


pdf("hist.pdf")
# Basic plot
a + geom_histogram()
# change line colors by sex
a + geom_histogram(aes(color = sex), fill = "white",
                   position = "dodge") 
a + geom_histogram(aes(y = ..density..))
a + stat_ecdf()
dev.off()

pdf("bar.pdf")
data(mpg)
b <- ggplot(mpg, aes(fl))
# Basic plot
b + geom_bar()
b + geom_bar(aes(x=fl,fill=fl))
# Change fill color
b + geom_bar(fill = "steelblue", color ="steelblue") +
  theme_minimal()
dev.off()



#Two Variables: Continuous X, Continous Y
data(mtcars)
mtcars$cyl <- as.factor(mtcars$cyl)
head(mtcars[, c("wt", "mpg", "cyl")])
b <- ggplot(mtcars, aes(x = wt, y = mpg))


pdf("point.pdf")
# Basic plot
b + geom_point()
# change the color and the point 
# by the levels of cyl variable
b + geom_point(aes(color = cyl, shape = cyl)) 
# Change color manually
b + geom_point(aes(color = cyl, shape = cyl)) +
  scale_color_manual(values = c("#999999", "#E69F00", "#56B4E9"))+
  theme_minimal()
dev.off()



pdf("smooth.pdf")
# Regression line only
b + geom_smooth(method = lm)
# Point + regression line
# Remove the confidence interval 
b + geom_point() + 
  geom_smooth(method = lm, se = FALSE)
# loess method: local regression fitting
b + geom_point() + geom_smooth()
# Change color and shape by groups (cyl)
b + geom_point(aes(color=cyl, shape=cyl)) + 
  geom_smooth(aes(color=cyl, shape=cyl), 
              method=lm, se=FALSE, fullrange=TRUE)
dev.off()



pdf("quatileandrug.pdf")
ggplot(mpg, aes(cty, hwy)) +
  geom_point() + geom_quantile() +
  theme_minimal()
# Add marginal rugs using faithful data
ggplot(faithful, aes(x=eruptions, y=waiting)) +
  geom_point() + geom_rug()
dev.off()




pdf("jittertext.pdf")
p <- ggplot(mpg, aes(displ, hwy))
# Default scatter plot
p + geom_point()
# Use jitter to reduce overplotting
p + geom_jitter(
  position = position_jitter(width = 0.5, height = 0.5))
b + geom_text(aes(label = rownames(mtcars)))
dev.off()

#Two variables: Continuous bivariate distribution
c <- ggplot(diamonds, aes(carat, price))
pdf("bin2dandothers.pdf")
# Default plot 
c + geom_bin2d()
# Change the number of bins
c + geom_bin2d(bins = 15)

require(hexbin)
# Default plot 
c + geom_hex()
# Change the number of bins
c + geom_hex(bins = 10)

# Scatter plot 
sp <- ggplot(faithful, aes(x=eruptions, y=waiting)) 
# Default plot
sp + geom_density_2d()
# Add points
sp + geom_point() + geom_density_2d()
# Use stat_density_2d with geom = "polygon"
sp + geom_point() + 
  stat_density_2d(aes(fill = ..level..), geom="polygon")

dev.off()


#Two variables: Continuous function
d <- ggplot(economics, aes(x = date, y = unemploy))
pdf("arealinestep.pdf")
# Area plot
d + geom_area()
# Line plot: connecting observations, ordered by x
d + geom_line()
# Connecting observations by stairs
# a subset of economics data set is used
set.seed(1234)
ss <- economics[sample(1:nrow(economics), 20), ]
ggplot(ss, aes(x = date, y = unemploy)) + 
  geom_step()
dev.off()


#Two variables: Discrete X, Continuous Y

data("ToothGrowth")
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
head(ToothGrowth)
e <- ggplot(ToothGrowth, aes(x = dose, y = len))
pdf("boxplotviolinandothers.pdf")
# Default plot
e + geom_boxplot()
# Notched box plot
e + geom_boxplot(notch = TRUE)
# Color by group (dose)
e + geom_boxplot(aes(color = dose))
# Change fill color by group (dose)
e + geom_boxplot(aes(fill = dose))

ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_boxplot()

e + stat_boxplot(coeff = 1.5)


# Default plot
e + geom_violin(trim = FALSE)
# violin plot with mean points (+/- SD)
e + geom_violin(trim = FALSE) + 
  stat_summary(fun.data="mean_sdl",  fun.args = list(mult=1), 
               geom="pointrange", color = "red")
# Combine with box plot
e + geom_violin(trim = FALSE) + 
  geom_boxplot(width = 0.2)
# Color by group (dose) 
e + geom_violin(aes(color = dose), trim = FALSE)


# Default plot
e + geom_dotplot(binaxis = "y", stackdir = "center")
# Dot plot with mean points (+/- SD)
e + geom_dotplot(binaxis = "y", stackdir = "center") + 
  stat_summary(fun.data="mean_sdl",  fun.args = list(mult=1), 
               geom="pointrange", color = "red")

# Combine with box plot
e + geom_boxplot() + 
  geom_dotplot(binaxis = "y", stackdir = "center") 
# Add violin plot
e + geom_violin(trim = FALSE) +
  geom_dotplot(binaxis='y', stackdir='center')

# Color and fill by group (dose) 
e + geom_dotplot(aes(color = dose, fill = dose), 
                 binaxis = "y", stackdir = "center")


# Default plot
e + geom_jitter(position=position_jitter(0.2))
# Strip charts with mean points (+/- SD)
e + geom_jitter(position=position_jitter(0.2)) + 
  stat_summary(fun.data="mean_sdl",  fun.args = list(mult=1), 
               geom="pointrange", color = "red")

# Combine with box plot
e + geom_jitter(position=position_jitter(0.2)) + 
  geom_dotplot(binaxis = "y", stackdir = "center") 
# Add violin plot
e + geom_violin(trim = FALSE) +
  geom_jitter(position=position_jitter(0.2))

# Change color and shape by group (dose) 
e +  geom_jitter(aes(color = dose, shape = dose),
                 position=position_jitter(0.2))

dev.off()

