iris.smooth <- ggplot(iris, aes(x= Sepal.Length, y = Sepal.Width,
                                col = Species)) +
                geom_point(alpha = 0.7) + geom_smooth()

iris.smooth
iris.smooth + scale_x_continuous(limits = c(4.5,5.5))
iris.smooth + xlim(c(4.5,5.5))
iris.smooth + coord_cartesian(xlim = c(4.5,5.5))

#zooming In
p <- ggplot(mtcars, aes(x = wt, y = hp, col = factor(am))) +
         geom_point() +
         geom_smooth()
p

p + scale_x_continuous(limits = c(3,6), expand = c(0,0))
p + coord_cartesian(xlim = c(3,6))


#Aspect Ratio
# Complete basic scatter plot function
base.plot <- ggplot(iris, aes(x = Sepal.Length, y =Sepal.Width, col = Species)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = F)

# Plot base.plot: default aspect ratio
base.plot

# Fix aspect ratio (1:1) of base.plot
base.plot + coord_equal()






#Facets
iris$Flower <- 1:nrow(iris)
iris.wide <- iris %>%
  gather(key, value, -Species, -Flower) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)


p <- ggplot(iris.wide, aes(x = Length, y = Width, col = Part)) +
      geom_point(position = position_jitter(), alpha = 0.7) +
      scale_color_brewer(palette = "Set1") +
      coord_fixed()
p
p + facet_grid(.~Species)


#Facets example
# Basic scatter plot:
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Separate rows according to transmission type, am
p + facet_grid(am ~. )
# Separate columns according to cylinders, cyl
p + facet_grid(.~cyl)
# Separate by both columns and rows 
p + facet_grid(am~cyl)
