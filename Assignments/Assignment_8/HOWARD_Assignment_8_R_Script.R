#Load libraries
library(modelr)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(modelr)
install.packages("GGally")
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




















