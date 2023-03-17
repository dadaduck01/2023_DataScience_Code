library(ggplot2)
head(iris)
#iris is a type of flower, three species

#Layer 1: Data
iris

#Layer 2: Aesthetics
#study: Sepal.Length Sepal.Width
#Layer 3: Geometries

p <- ggplot(iris,aes( x= Sepal.Length,y = Sepal.Width))

ggplot(iris,aes(x=Sepal.Length, y= Sepal.Width,col = Species)) +
      geom_jitter(alpha = 0.6)
#Layer 4: Facets
ggplot(data = iris,aes(x=Sepal.Length, y= Sepal.Width)) +
  geom_jitter(alpha = 0.6) +
  facet_grid(.~Species)


#Layer 5: Statistics
ggplot(iris,aes(x=Sepal.Length, y= Sepal.Width)) +
  geom_jitter(alpha = 0.6) +
  facet_grid(Species~.) +
  stat_smooth(method = "loess", se = T, col = "red")

#Layer 6: Coordinates
ggplot(iris,aes(x=Sepal.Length, y= Sepal.Width)) +
  geom_jitter(alpha = 0.6) +
  facet_grid(.~Species) +
  stat_smooth(method = "lm", se = F, col = "red") +
  scale_y_continuous("Sepal Width (cm)",
                     limits = c(2,5),
                     expand = c(0,0)) +
  scale_x_continuous("Sepal Length (cm)",
                     limits = c(4,8),
                     expand = c(0,0)) +
  coord_equal()


#Layer 7: theme
ggplot(iris,aes(x=Sepal.Length, y= Sepal.Width)) +
  geom_jitter(alpha = 0.6) +
  facet_grid(.~Species) +
  stat_smooth(method = "lm", se = F, col = "red") +
  scale_y_continuous("Sepal Width (cm)",
                     limits = c(2,5),
                     expand = c(0,0)) +
  scale_x_continuous("Sepal Length (cm)",
                     limits = c(4,8),
                     expand = c(0,0)) +
  coord_equal() +
  theme(panel.background = element_blank(), 
        plot.background = element_blank(), 
        legend.background = element_blank(), 
        legend.key = element_blank(), 
        strip.background = element_blank(), 
        axis.text = element_text(colour = "black"), 
        axis.ticks = element_line(colour = "black"), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"), 
        strip.text = element_blank(), 
        panel.margin = unit(1, "lines") 
  )