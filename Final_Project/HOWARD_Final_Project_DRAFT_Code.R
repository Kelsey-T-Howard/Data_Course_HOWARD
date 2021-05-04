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
library(plotly)


# The dataset I will be using is video game data collected from vgchartz.com. This dataset contains a list of video games with sales greater than 100,000 copies. This data includes:
# The objectives of this final project are to a) test hypothesis through analyzing the data and b) portray results through learning of a new R package, plotly
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

str(cvg)
cvg$Year <- as.numeric(as.character(cvg$Year))
vg$Year <- as.numeric(as.character(vg$Year))
# Now that the dataset is cleaned we can start to visualize our data
glimpse(cvg)
summary(cvg)
skim(cvg)
cvg %>%
  summarize(sum(Global_Sales), mean(Global_Sales))
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


# Here's a graph showing the same same data. This graph is also interactive, courtesy of the Plotly package. By hovering over different coordinates, you can see the exact number of sales in each country and exact rank.

ggplotly(ggplot(cvg, aes(x=Rank, y=Sales, color = Country)) +
  geom_smooth())


# The correlation between Rank and Sales is obvious when looking at this graph. But what the graph also sheds light on is the fact there were the most sales in North America. It is clear that North America had the highest game sales. This could be due to the US being more entertainment-based than Japan or Europe. The population of Japan is smaller than Europe or America so that definitely is a factor shown here in this graph.


ggplotly(ggplot(cvg, aes(y=Genre, fill = Genre)) +
  geom_bar(stat="count", width=0.7, fill="steelblue"))

# This graph shows the most popular genre of video game is Action with 13,264 counts. Sports is a not-so close second place with 9,384 counts. The puzzle genre showed up the least amount compared to the others, with only 2328 counts. These results make sense, as the term "Action" can apply to a large variety of different games. The Puzzle genre is quite limited, and this explains its relatively low count. An explanation for the success of the Sports genre could be that it has games with rights to the NFL which had a huge fanbase already, resulting in a sales increase. 

ggplotly(ggplot(cvg, aes(x=Platform, fill = Platform)) +
  geom_bar() +
  theme(axis.text.x=element_text(angle=90,hjust=1)))

#This graph shows which platforms appear in our data the most. It appears the Nintendo DS and PS2 sold the most compared to the other platforms. The PS2 is already widely regarded as the most successful video game console as it has sold more game copies than any other console. Most of this success is due to the console being the first revolutionary first installment in the world of modern gaming. It also functioned as a DVD player, so its flexible usage was a huge hit.

# This next graph combines both graphs together. By looking closely at the graph we can see most a large chunk of PS2 sales came from the Sports genre which, as we saw previously, was a popular genre. 
ggplotly(ggplot(cvg, aes(x=Platform, fill = Genre)) +
  geom_bar() +
  theme(axis.text.x=element_text(angle=90,hjust=1)))

# The following bargraph shows how frequently each year appears on the list. It appears most of the games in the dataset were developed from 2001 to 2011.
ggplotly(ggplot(cvg, aes(x=Year)) +
  geom_bar(fill = "mediumpurple4") +
  theme(axis.text.x=element_text(angle=90,hjust=1)))



ggplotly(ggplot(cvg, aes(x=Year, y=Global_Sales)) +
  geom_smooth(color = "hotpink4") +
  theme(axis.text.x=element_text(angle=90,hjust=1)))

# This graph shows that the actual sales count was the highest with games made around 1987 to 1989.
sal <- cvg %>% 
  filter(cvg$Year == 1988)
sal %>%
  summarize(sum(sal$Global_Sales), mean(sal$Global_Sales))
# Our data shows us that 1988 definitely does have a higher sales average than what we calculated the dataset to have above. I would hypothesize that this is due to high sales of Nintendo's NES console. 


p1 <- ggplotly(ggplot(cvg, aes(x= Year, y= Sales, color= Country)) +
           geom_smooth() +
           theme(axis.text.x=element_text(angle=90,hjust=1)))
  
ggplotly(p1) %>% 
  animation_slider(
    currentvalue = list(prefix = "YEAR ", font = list(color="red"))
  ) 
  

ggplotly(ggplot(cvg, aes(x= Year, y= Sales, color= Country)) +
  geom_smooth() +
  facet_wrap(~Country) +
  theme(axis.text.x=element_text(angle=90,hjust=1)))

# Where Knit ends





# Now let's experiment with some new graphs
top <- slice(vg, 1:100)
top$Year <- as.numeric(as.character(top$Year))
ggplotly(ggplot(top, aes(x= Year, y= Global_Sales)) +
           geom_point(color = "magenta4") +
           theme(axis.text.x=element_text(angle=90,hjust=1)))







ggplotly(ggplot(top,aes(x= Year, y= Genre, color = Platform)) +
  geom_point() +
  theme(axis.text.x=element_text(angle=90,hjust=1)) +
  labs(title="Top 100 Video Games"))

# I've made the subset smaller to include the top 100 games. The top tier selling games (summarize). We can use this subset to make predictions for the rest of the data.

ggplotly(ggplot(top,aes(x= Year, y= Genre, color = Platform)) +
           geom_point() +
           theme(axis.text.x=element_text(angle=90,hjust=1)) +
           labs(title="Top 100 Video Games"))
 


ggplotly(ggplot(top,aes(x= Publisher, y= Genre, color = Platform)) +
           geom_point() +
           theme(axis.text.x=element_text(angle=90,hjust=1)) +
           labs(title="Top 100 Video Games")) %>% 
  rangeslider(borderwidth = 1)








# Platform, Year, Publisher, Genre
# Now that we have taken a look at our data, we need to make a model that tells us which predictors are significant or not. We can do this with an ANOVA table (Note: I wanted to include a variety of other models but most came up with an error that said I needed more storage, which I don't have unfortunately)
mod1 <- aov(data = top,
            formula = Global_Sales ~ Platform + Year + Publisher + Genre)

mod2 <- aov(data = top,
            formula = Global_Sales ~ Year + Platform + Genre)

mod3 <- aov(data = vg,
            formula = Global_Sales ~ Platform + Year + Publisher + Genre)
summary(mod3)
pred3 <- add_predictions(vg, mod3 %>% levels(droplevels(vg$Platform)))
summary(mod1)
table(mod1)

# The ANOVA table shows that all of our predictors are significant. Well, that's not very helpful. Luckily we can use our model to generate sales predictions 
pred <- add_predictions(vg, mod1) %>% 
  pred$pred$Platform
sub <- filter(pred, Global_Sales >1)


ggplot(pred, aes(x=Year, y=Global_Sales)) +
  geom_line(aes(y=Global_Sales), color = "Red") +
  geom_line(aes(y=pred), color = "Green") +
  labs(caption="Green = Predictions")





ggplot(pred3, aes(x=Year, y=Global_Sales)) +
  geom_point(aes(y=Global_Sales),alpha = .6, color = "Purple") +
  geom_point(aes(y=pred), alpha = .8, color = "Yellow") +
  facet_wrap(~Genre) +
  labs(caption="Yellow = Predictions")


ggplot(pred, aes(x=Platform, y=Global_Sales)) +
  geom_point(aes(y=Global_Sales) ,alpha = .6, color = "Blue") +
  geom_point(aes(y=pred),alpha = .4, color = "Orange") +
  theme(axis.text.x=element_text(angle=90,hjust=1)) +
  facet_wrap(~Genre) +
  labs(caption="Orange = Predictions")

ggplot(cvg, aes(x=Platform, y= Global_Sales)) +
  geom_point()

subs <- cvg %>% 
  filter(cvg$Year == "2015", "2016", "2017") 
ggplot(subs, aes(x=Publisher, y=Genre, color = Year)) +
  geom_point() +
  theme(axis.text.x=element_text(angle=90,hjust=1))


str(vg)
str(top)
