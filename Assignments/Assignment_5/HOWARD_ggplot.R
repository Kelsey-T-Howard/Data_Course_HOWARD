#First plot code:
iris
ggplot(data = iris) +
  geom_point(mapping = aes(x=Sepal.Length, y = Petal.Length, color = Species)) +
  geom_smooth((mapping = aes(x=Sepal.Length, y = Petal.Length, color = Species)))

?geom_smooth

p1 <- ggplot(data = iris) +
  geom_point(mapping = aes(x=Sepal.Length, y = Petal.Length, color = Species)) + 
  stat_smooth(mapping = aes(x=Sepal.Length, y = Petal.Length, color = Species), method = "lm", formula = y ~ x, size = 1) +
  theme_minimal() 
p1 + labs(title="Sepal length vs petal length", 
       subtitle="for three iris species", 
       y="Petal.Length", 
       x="Sepal.Length")

png(filename = "./iris_fig1.png")
p1 <- ggplot(data = iris) +
  geom_point(mapping = aes(x=Sepal.Length, y = Petal.Length, color = Species)) + 
  stat_smooth(mapping = aes(x=Sepal.Length, y = Petal.Length, color = Species), method = "lm", formula = y ~ x, size = 1) +
  theme_minimal() 
p1 + labs(title="Sepal length vs petal length", 
          subtitle="for three iris species", 
          y="Petal.Length", 
          x="Sepal.Length")
dev.off()

#Second plot code (geom_density):
p2 <- ggplot(iris, aes(x=Petal.Width)) +
  geom_density(mapping = aes(fill=Species), alpha = .6) +
  theme_minimal()
p2 + labs(title="Distribution of Petal Widths", 
          subtitle="for three iris species")

png(filename = "./iris_fig2.png")
p2 <- ggplot(iris, aes(x=Petal.Width)) +
  geom_density(mapping = aes(fill=Species), alpha = .6) +
  theme_minimal()
p2 + labs(title="Distribution of Petal Widths", 
          subtitle="for three iris species")
dev.off()


#Third plot (geom_boxplot):
ggplot(iris,aes(x=Species, y=Sepal.Width:Petal.Width))
?mutate

Sepal <- c(iris$Sepal.Width)
Petal <- c(iris$Petal.Width)
Ratio <- Sepal / Petal
Ratio2 <- Petal/Sepal
c[iris$Sepal.Width/iris$Petal.Width]


p3 <- ggplot(iris, aes(x=Species, y=Ratio2)) +
  geom_boxplot(mapping = aes(fill=Species)) +
  theme_minimal()
p3 + labs(title="Sepal- to Petal-Width Ratio", 
          subtitle="for three iris species",
     y="Ratio of Sepal Width to Petal Width", 
     x="Species")

png(filename = "./iris_fig3.png")
p3 <- ggplot(iris, aes(x=Species, y=Ratio2)) +
  geom_boxplot(mapping = aes(fill=Species)) +
  theme_minimal()
p3 + labs(title="Sepal- to Petal-Width Ratio", 
          subtitle="for three iris species",
          y="Ratio of Sepal Width to Petal Width", 
          x="Species")
dev.off()


#Fourth plot (unfinished)
stat=identity

iris$"Sepal.Length" <- rownames
iris$Sepal.Length_z <- round((iris$Sepal.Length - mean(iris$Sepal.Length))/sd(iris$Sepal.Length), 2)
iris$Sepal.Length_type <- ifelse(iris$Sepal.Length_z < 0, "below", "above")  # above / below avg flag
iris <- iris[order(iris$Sepal.Length_z), ]  # sort
iris$"Sepal.Length" <- factor(iris$"Sepal.Length", levels = iris$"Sepal Length")  # convert to factor to retain sorted order in plot.

ggplot(iris, aes(x=Sepal.Length_z, label=Sepal.Length_z)) + 
  geom_bar(stat='identity', aes(fill=Species), width=.5)  +
  scale_fill_manual(Species)
  labs(title="Sepal length deviance from the mean of all observations", 
     y=NA, 
     x="Deviance from the Mean")

#I'll continue to practice this. It's definitely a work in progress lol






























































