HOWARD_Assignment_9_Script



df <- read.csv("../../Data/GradSchool_Admissions.csv")
df$rank <- as.factor(df$rank)
df$admit <- as.logical(df$admit)

head(df)
str(df)
df$rank <- as.numeric(df$rank)
df$gre <- as.numeric(df$gre)
str(df)

add_predictions(df, mod3, type = "response") %>% 
  ggplot(aes(x=gpa, y=pred)) +
  geom_smooth()
