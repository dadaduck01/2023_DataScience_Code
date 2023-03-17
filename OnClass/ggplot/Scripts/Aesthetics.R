library(ggplot2)

# group by

ggplot(iris,aes(x = Sepal.Length,y=Sepal.Width)) +
  geom_point()

ggplot(iris,aes(x = Sepal.Length,y=Sepal.Width)) +
  geom_point(col = "red")

ggplot(iris) + 
  geom_point(aes(x = Sepal.Length,y=Sepal.Width,col=Species))


#mtcars
# 1 - Map mpg to x and cyl to y
ggplot(mtcars, aes(x = mpg, y = cyl)) +
  geom_point()

# 2 - Reverse: Map cyl to x and mpg to y
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_point()

# 2 - Reverse: Map cyl to x and mpg to y
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_jitter()
# 3 - Map wt to x, mpg to y and cyl to col
ggplot(mtcars, aes(x = wt, y = mpg, col = as.factor(cyl))) +
  geom_point()

# 4 - Change shape and size of the points in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, col = as.factor(cyl))) +
  geom_point(shape = 21 , size = 10)


#The color aesthetic typically changes the outside outline of an object and the fill aesthetic 
#is typically the inside shading. However, as you saw in the last exercise, geom_point() is an exception. 
#Here you use color, instead of fill for the inside of the point. But it's a bit subtler than that.

# am and cyl are factors, wt is numeric
class(mtcars$am)
class(mtcars$cyl)
class(mtcars$wt)

# From the previous exercise
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)

# 1 - Map cyl to fill
ggplot(mtcars, aes(x = wt, y = mpg, fill = as.factor(cyl))) +
  geom_point(shape = 21, size = 4)

# 2 - Change shape and alpha of the points in the above plot
#A really nice alternative is shape = 21 which allows you to use both fill for the inside and col for the outline! 
#This is a great little trick for when you want to map two aesthetics to a dot.
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, alpha = 0.6, size = 4)

ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, alpha = 0.6, size = 4,fill = "red")

# 3 - Map am to col in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl, col = am)) +
  geom_point(shape = 21, alpha = 0.6, size = 4)


#------------Stop Here -----------------
#different mapping requirements
# Map cyl to size
ggplot(mtcars,aes(x=wt,y=mpg,size=cyl)) +
  geom_point()

# Map cyl to alpha
ggplot(mtcars,aes(x=wt,y=mpg,alpha=cyl)) +
  geom_point()

# Map cyl to shape 
ggplot(mtcars,aes(x=wt,y=mpg,shape=as.factor(cyl))) +
  geom_point()

# Map cyl to label, label needs to work with geom_text()
ggplot(mtcars,aes(x=wt,y=mpg,label=cyl)) +
  geom_point() +
  geom_text(size=4)


#x, y, color, fill, size, alpha, label and shape.
#use these arguments to set attributes of the plot, not aesthetics. 
#these attributes can overwrite the aesthetics of your plot!

# Define a hexadecimal color
my_color <- "#0FE0C0"

# 1 - First scatter plot, with col aesthetic:
ggplot(mtcars,aes(x=wt,y=mpg,col=cyl)) +
  geom_point()


# 2 - Plot 1, but set col attributes in geom layer:
ggplot(mtcars,aes(x=wt,y=mpg,col=cyl)) +
  geom_point(col=my_color)


# 3 - Plot 2, with fill instead of col aesthetic, plut shape and size attributes in geom layer.
my_color <- "#4ABEFF"
ggplot(mtcars,aes(x=wt,y=mpg,fill=cyl)) +
  geom_point(col=my_color,size=10,shape=23)



# Expand to draw points with alpha 0.5
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(alpha = 0.5)

# Expand to draw points with shape 24 and color yellow
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, color = 'yellow')

# Expand to draw text with label rownames(mtcars) and color red
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_text(label = rownames(mtcars), color = 'red')+
  geom_point()







# Variables in a data frame are mapped to aesthetics in aes(). (e.g. aes(col = cyl)) within ggplot(). 
#Visual elements are set by attributes in specific geom layers (geom_point(col = "red")). 
#Don't confuse these two things - here you're focusing on aesthetic mappings.

# Map mpg onto x, qsec onto y and factor(cyl) onto col (3 aesthetics):
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl))) +
  geom_point()

# Add mapping: factor(am) onto shape (now 4 aesthetics):
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am))) +
  geom_point()

# Add mapping: (hp/wt) onto size (now 5 aesthetics):
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am), size = (hp/wt))) +
  geom_point()





#Modifying Aesthetics

#Position
#default position, identity
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
    geom_point()
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position = "identity")


#jitter
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position = "jitter")

posn.j <- position_jitter(width = 0.1) 
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) + 
  geom_point(position = posn.j)

#scale_
#name
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
    geom_point(position="jitter")+
    scale_x_continuous("Length") +
    scale_y_continuous("Width") +
    scale_color_discrete("Classification")
#limits
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position="jitter")+
  scale_x_continuous("Sepal Length", limits = c(6,8)) +
  scale_y_continuous("Sepal Width") +
  scale_color_discrete("Species")
#breaks
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position="jitter")+
  scale_x_continuous("Sepal Length", limits = c(2,8), breaks=seq(1,8,1)) +
  scale_y_continuous("Sepal Width") +
  scale_color_discrete("Species")
#expand
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position="jitter")+
  scale_x_continuous("Sepal Length", limits = c(2,8), breaks=seq(2,8,3), expand=c(0,0)) +
  scale_y_continuous("Sepal Width") +
  scale_color_discrete("Species")
#labels
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position="jitter")+
  scale_x_continuous("Sepal Length", limits = c(2,8), breaks=seq(2,8,3), expand=c(0,0)) +
  scale_y_continuous("Sepal Width") +
  scale_color_discrete("Species Set",
                       labels = c("Versicolour 1","Setosa 2","Virginica 3"))
#labs
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,col=Species)) +
  geom_point(position="jitter")+
  labs(x="Sepal Length",y="Sepal Width",col="Species Name")




#geom_bar practice
cyl.am <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))
cyl.am +
  geom_bar()
# Add geom (position = "stack" by default)
cyl.am + 
  geom_bar(position="stack")

# Fill - show proportion
cyl.am + 
  geom_bar(position = "fill")  

# Dodging - principles of similarity and proximity
cyl.am +
  geom_bar(position = "dodge") 

# Clean up the axes with scale_ functions
val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automatic")
cyl.am +
  geom_bar(position = "dodge") +
  scale_x_discrete("Cylinders") + 
  scale_y_continuous("Number") +
  scale_fill_manual("Transmission", values = val,  labels = lab) 





#Overplotting 1 - Point shape and transparency
# Basic scatter plot of wt on x-axis and mpg on y-axis; map cyl to col
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 4)

# Hollow circles - an improvement
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 4, shape = 1)

# Add transparency - very nice
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 4, alpha = 0.6)


#diamonds
# Scatter plot: carat (x), price (y), clarity (color)
ggplot(diamonds, aes(x = carat, y = price, color = clarity)) +
  geom_point()

# Adjust for overplotting
ggplot(diamonds, aes(x = carat, y = price, color = clarity)) +
  geom_point(alpha = 0.1)

# Scatter plot: clarity (x), carat (y), price (color)
ggplot(diamonds, aes(x = clarity, y = carat, color = price)) +
  geom_point(alpha = 0.5)

# Dot plot with jittering
ggplot(diamonds, aes(x = clarity, y = carat, color = price)) +
  geom_point(alpha = 0.1, position = "jitter")

