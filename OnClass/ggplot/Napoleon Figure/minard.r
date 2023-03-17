library(ggplot2)

troops <- read.table("minard-troops.txt", header=T)
cities <- read.table("minard-cities.txt", header=T)

plot_troops <- ggplot(troops, aes(long, lat)) +
  geom_path(aes(linewidth = survivors, colour = direction, group = group))
plot_troops
  
plot_both <- plot_troops + 
  geom_text(aes(label = city), size = 4, data = cities)
plot_both
  
plot_polished <- plot_both + 
  scale_colour_manual(values = c("grey50","red")) +
  xlab(NULL) + 
  ylab(NULL)
plot_polished

ggsave(plot_troops, file = "minard-troops.pdf", width=12, height=3)
ggsave(plot_both, file = "minard-both.pdf", width=12, height=3)
ggsave(plot_polished, file = "minard-polished.pdf", width=12, height=3)
