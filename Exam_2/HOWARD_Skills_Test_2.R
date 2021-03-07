# Howard Exam 2 Script

library(ggplot2)
library(tidyverse)
library(dplyr)
library(janitor)

# I. Load data and recreate graph
land <- read.csv("./landdata-states.csv")

land <- land %>% rename(Region = region)

# Actual plot code
options(scipen = 999)
ggplot(land, (aes(x = Year, y = Land.Value, color = Region))) + 
  geom_smooth() + 
  labs(y="Land Value (USD)", 
       x="Year") +
  theme_minimal()
  
# Save the plot
jpeg("./HOWARD_Fig_1.jpg")
options(scipen = 999)
ggplot(land, (aes(x = Year, y = Land.Value, color = Region))) + 
  geom_smooth() + 
  labs(y="Land Value (USD)", 
       x="Year") +
  theme_minimal()
dev.off()


# II. Write code to show which state(s) are found in the "NA" region
land$State[is.na(land$Region)]


# III. Load another data set and tidy it
#Load data
child <- read.csv("./unicef-u5mr.csv")
names(child)

# Tidy code
clean_child <- child %>% 
  rename(Country_Name = CountryName) %>% 
  pivot_longer(cols = c(starts_with("U5MR.")),
               names_to = "Year", 
               values_to = "Mortality_Rate") %>% 
mutate(Year = str_remove_all(Year, "[U5MR]*[.]"))


# IV. Recreate Fig 2 graph
ggplot(clean_child, aes(x=Year, y=Mortality_Rate, color = Continent)) +
  geom_point(size = 2) +
  scale_x_discrete(breaks = seq(0, 3000, by = 20)) +
  labs(y="MortalityRate", 
       x="Year") +
  theme_minimal ()

# Save the plot
jpeg("./HOWARD_Fig_2.jpg")
ggplot(clean_child, aes(x=Year, y=Mortality_Rate, color = Continent)) +
  scale_x_discrete(breaks = seq(0, 3000, by = 20)) +
  geom_point(size = 2) +
  labs(y="MortalityRate", 
       x="Year") +
  theme_minimal ()
dev.off()

# IV.II Recreate Fig 3 graph
# Subset the average mortality rate
mean_child <- clean_child %>%
  filter(!is.na(Mortality_Rate)) %>% 
  group_by(Continent, Year) %>%
  summarize(Avg_Mortality=mean(Mortality_Rate))

# Actual plot code
ggplot(mean_child, aes(x=Year, y=Avg_Mortality, group = Continent, color = Continent)) +
  geom_path(size = 2) +
  scale_x_discrete(breaks = seq(0, 3000, by = 20)) +
   labs(y="Mean Mortality Rate (deaths per 1000 live births)", 
       x="Year") +
  theme_minimal ()
str(mean_child)

# Save the plot
jpeg("./HOWARD_Fig_3.jpg")
ggplot(mean_child, aes(x=Year, y=Avg_Mortality, group = Continent, color = Continent)) +
  geom_path(size = 2) +
  scale_x_discrete(breaks = seq(0, 3000, by = 20)) +
  labs(y="Mean Mortality Rate (deaths per 1000 live births)", 
       x="Year") +
  theme_minimal ()
str(mean_child)
dev.off()


# V. Recreate Fig 4 Graph
ggplot(clean_child, aes(x=Year, y=Mortality_Rate/1000)) +
  geom_point(size = .1, color = "Blue") +
  scale_x_discrete(breaks = seq(0, 3000, by = 20)) +
  labs(y="Mortality Rate", 
       x="Year") +
  theme_minimal () +
  facet_wrap(~ Region)

#(Note graph order differs from example)

# Save the plot
jpeg("./HOWARD_Fig_4.jpg")
ggplot(clean_child, aes(x=Year, y=Mortality_Rate/1000)) +
  geom_point(size = .1, color = "Blue") +
  scale_x_discrete(breaks = seq(0, 3000, by = 20)) +
  labs(y="Mortality Rate", 
       x="Year") +
  theme_minimal () +
  facet_wrap(~ Region)
dev.off()

# End of Skills Test 2





