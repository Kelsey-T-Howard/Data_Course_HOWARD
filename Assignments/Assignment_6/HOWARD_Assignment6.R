#Assignment 6 Work
library(ggplot2)
library(patchwork)
data("mtcars")
?mtcars

#subsetting data into automatic transmission only and saving it
auto <- mtcars[mtcars$am == 0, ]
write.csv(auto,"./automatic_mtcars.csv")

#Plotting and saving the plot
ggplot(auto,aes(x=hp,y=mpg)) +
  geom_point() +
  geom_smooth() + 
  labs(title="Effect of horsepower on mpg", 
       subtitle="From mtcars dataset", 
       y="Miles per gallon", 
       x="Horsepower")
ggsave("./mpg_vs_hp_auto.png")
?mtcars

#Weight subset plot
ggplot(auto,aes(x=wt,y=mpg)) +
  geom_point() +
  geom_smooth() + 
  labs(title="Effect of weight on mpg", 
       subtitle="From mtcars dataset", 
       y="Miles per gallon", 
       x="Weight")

#saving as tiff
tiff("./mpg_vs_wt_auto.tiff")
ggplot(auto,aes(x=wt,y=mpg)) +
  geom_point() +
  geom_smooth() + 
  labs(title="Effect of weight on mpg", 
       subtitle="From mtcars dataset", 
       y="Miles per gallon", 
       x="Weight")
dev.off()

# subset mtcars to include less than or equal (<=)to 200 cu disp
under <- mtcars[mtcars$disp<=200,]

# Saving as a csv
write.csv(under, "./mtcars_max200_displ.csv")

# Max of original
a <- max(mtcars$hp)

# Max of auto
b <- max(auto$hp)

# Max of 200
c <- max(under$hp)

install.packages('patchwork')
library(patchwork)

d <- as.list(c(a,b,c))
#Saving as txt
write.table(d, file = "./hp_maximums.txt", sep = "\t",
            row.names = FALSE)

#Scatterplot + trendline of the effect of weight on mpg (points and linear trendlines colored by the number of cylinders)
#Violin chart of the distributions of mpg for cars, separated and colored by the number of cylinders
#Scatterplot + trendline of the effect of horsepower on mpg (points and linear trendlines colored by the number of cylinders)

ggplot(mtcars, aes(x=wt,y=mpg)) +
  geom_point(mtcars, aes(x=wt,y=mpg, color = cyl)) +
  geom_smooth(mtcars, method="lm")

# First plot
 
p1 <- ggplot(data = mtcars) +
  geom_point(mapping = aes(x=wt, y = mpg, color = cyl)) + 
  stat_smooth(mapping = aes(x=wt, y = mpg, color = cyl), method = "lm", formula = y ~ x, size = 1) +
  theme_minimal() 

# Second plot (colors didn't work, not sure why)
p2 <- ggplot(data = mtcars) + 
  geom_violin(mapping = aes(x=wt, y=mpg,color=cyl))

# Third plot
p3 <- ggplot(data = mtcars) +
  geom_point(mapping = aes(x=hp, y = mpg, color = cyl)) + 
  stat_smooth(mapping = aes(x=hp, y = mpg, color = cyl), method = "lm", formula = y ~ x, size = 1) +
  theme_minimal() 
              
#This combination looks pretty rough, ngl
comb <- p1 + p2 + p3

#Saving
png("./combined_mtcars_plot.png")
p1 + p2 + p3
dev.off()