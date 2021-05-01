# HOWARD_Final_Project

library(ggplot2)
library(tidyverse)
library(dplyr)
library(janitor)
library(broom)
library(modelr)
library(skimr)
library(gganimate)
library(gifski)
library(png)
library(transformr)
library(plotly)
library(DataExplorer)
install.packages("DataExplorer")
install.packages("transformr")

# The dataset I will be using is video game data collected from vgchartz.com. This dataset contains a list of video games with sales greater than 100,000 copies. This data includes:
# The objectives of this final project are to a) test hypothesis by analyzing data and b) portray results through learning of a new R package
# First let's load our dataset and take a look

vg <- read.csv("./vgsales.csv")
names(vg)
glimpse(vg)
# This set isn't usable and needs to be cleaned first. The sale columns are separated by country but we want the variables sales and country to be separate variables. First I'll change the names of the columns so we can use a pivot longer with ease. 

nvg <- vg %>% 
  rename(`North America` = NA_Sales) %>% 
  rename(Europe = EU_Sales) %>% 
  rename(Japan = JP_Sales) %>% 
  rename(Other = Other_Sales)

cvg <- pivot_longer(nvg,
                    c("North America", "Europe", "Japan", "Other"),
                    names_to = "Country",
                    values_to = "Sales")

# Now that the dataset is cleaned we can start to visualize our data
glimpse(cvg)
summary(cvg)
skim(cvg)
unique(cvg$Platform)
unique(cvg$Year)
unique(cvg$Genre)
unique(cvg$Publisher)
unique(cvg$Country)

# By looking at this dataset, it is clear that the rank of the game is based off how well the game did in terms of sales. Sales and Rank are our dependent variables, while Platform, Year, Genre, and Publisher are our independent variables. We want to know which of our independent variables contributes the most to the Global Sales/Rank. My hypothesis is that Publisher and Platform are the strongest predictors. We will make several graphs examining each variable and its relationship with our dependent variables in order to test this hypothesis.

ggplot(cvg, aes(x=Rank, y=Sales)) +
  geom_smooth() +
  transition_states(Country,
                    transition_length = 2,
                    state_length = 1) +
  ggtitle('Now showing {closest_state}',
          subtitle = 'Frame {frame} of {nframes}')