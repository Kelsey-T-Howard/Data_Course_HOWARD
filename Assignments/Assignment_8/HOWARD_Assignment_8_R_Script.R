#Load libraries
library(modelr)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(modelr)
install.packages("kernlab")
library(skimr)
library(GGally)

#Load mushroom data
df <- read.csv("../../Data/mushroom_growth.csv")

#Exploring data
skim(df)
summary(df)

#Make some graphs exploring predictors
#Dependent variable: Growth Rate
#Independent variable: everything else

#First graph
ggplot(df, aes(x=Temperature,y=GrowthRate, color = Humidity)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()

g1 <- glm(data=df, formula=GrowthRate ~ Temperature * Humidity)
summary(g1)

sqrt(mean(g1$residuals^2))

#Second graph
ggplot(df, aes(x=Light,y=GrowthRate, color = Humidity)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal() +
  facet_wrap(~Nitrogen)

g2 <- glm(data=df, formula=GrowthRate ~ Light * Humidity * Nitrogen)
summary(g2)
sqrt(mean(g2$residuals^2))

g2 <- aov(data=df, formula=GrowthRate ~ Light * Humidity * Nitrogen)
summary(g2)
sqrt(mean(g2$residuals^2))

#Third graph
ggplot(df, aes(x=Light,y=GrowthRate, color = Temperature)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal() +
  facet_wrap(~Species)

g3 <- glm(data=df, formula=GrowthRate ~ Light * Temperature * Species)
summary(g2)
sqrt(mean(g3$residuals^2))

g3 <- aov(data=df, formula=GrowthRate ~ Light * Temperature * Species)
summary(g3)
sqrt(mean(g3$residuals^2))

#Fourth graph
ggplot(df, aes(x=Light,y=GrowthRate, color = Humidity)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal() +
  facet_wrap(~Species)

g4 <- aov(data=df, formula=GrowthRate ~ Light * Humidity * Species)
summary(g4)
sqrt(mean(g4$residuals^2))

g5 <- aov(data=df, formula=GrowthRate ~ Light * Humidity * Species)
summary(g5)
sqrt(mean(g5$residuals^2))

#Best model so far is model #4 (though it's not very good)
#Make some predictions
pred <- df %>% 
  add_predictions(df,g5) %>% 
  ggplot(pred, mapping = aes(x=Light)) +
geom_point(mapping = aes(y=GrowthRate))
  geom_point(mapping = aes(y=pred), color = "Blue") +
    geom_smooth(method = "lm") +
    theme_minimal()

nl <- df <- read.csv("../../Data/non_linear_relationship.csv")
library(caret)
library(MASS)

# Build the model
model <- glm(predictor ~ log(response), data = nl) %>% 
ggplot(nl, mapping = aes(x=predictor, y=response) ) +
  geom_point() +
  stat_smooth(method = lm, formula = y ~ log(x))

ggplot(nl, aes(x=predictor, y=response)) +
  geom_point()
