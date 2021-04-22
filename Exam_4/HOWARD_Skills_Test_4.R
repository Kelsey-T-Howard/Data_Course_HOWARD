# Howard Exam 4 Script
# I am redoing Exam 1

library(ggplot2)

# I. Load the data and make separate histograms
conc <- read.csv("./DNA_Conc_by_Extraction_Date.csv")


# Playing with the Data
summary(conc)
dim(conc)
str(conc)
head(conc)
class(conc)


# Histogram of Katy's DNA Concentration
Katy_conc <- ggplot(data = conc) +
  geom_histogram(aes(DNA_Concentration_Katy), color = "blue") +
  theme_minimal() +
  labs(title="Katy's DNA Concentration", 
       y="Count", 
       x="DNA Concentration")


# Not required, but saving image for reference
png(filename = "./Katy_DNA_Concentration.png")
ggplot(data = conc) +
  geom_histogram(aes(DNA_Concentration_Katy), color = "blue") +
  theme_minimal() +
  labs(title="Katy's DNA Concentration", 
       y="Count", 
       x="DNA Concentration")
dev.off()


# Histogram of Ben's DNA Concentration
Ben_conc <- ggplot(data = conc) +
  geom_histogram(aes(DNA_Concentration_Ben), color = "red") +
  theme_minimal() +
  labs(title="Ben's DNA Concentration", 
       y="Count", 
       x="DNA Concentration")


# Not required but saving image for reference
png(filename = "./Ben_DNA_Concentration.png")
ggplot(data = conc) +
  geom_histogram(aes(DNA_Concentration_Ben), color = "red") +
  theme_minimal() +
  labs(title="Ben's DNA Concentration", 
       y="Count", 
       x="DNA Concentration")
dev.off()


# II. Recreate both plots shown
class(conc$DNA_Concentration_Katy)
class(conc$Year_Collected)


# Katy's Extraction Plot
# Note: R Version 4.0.0 changed the boxplot default color from white to gray
boxplot(DNA_Concentration_Katy~Year_Collected,data=conc, main="Katy's Extractions",
        xlab="YEAR", ylab="DNA Concentration")


# Ben's Extraction Plot
boxplot(DNA_Concentration_Ben~Year_Collected,data=conc, main="Ben's Extractions",
        xlab="YEAR", ylab="DNA Concentration")


# III. Saving both figures as jpegs
# Saving Katy's Plot
jpeg("./HOWARD_Plot1.jpeg")
boxplot(DNA_Concentration_Katy~Year_Collected,data=conc, main="Katy's Extractions",
        xlab="YEAR", ylab="DNA Concentration")
dev.off()


# Saving Ben's Plot
jpeg("./HOWARD_Plot2.jpeg")
boxplot(DNA_Concentration_Ben~Year_Collected,data=conc, main="Ben's Extractions",
        xlab="YEAR", ylab="DNA Concentration")
dev.off()


# IV. Writing comparison code
# First I'm looking at the data
Ben <- conc$DNA_Concentration_Ben
Katy <- conc$DNA_Concentration_Katy
Ben - Katy

sort(conc$DNA_Concentration_Ben - conc$DNA_Concentration_Katy)
conc$DNA_Concentration_Ben - conc$DNA_Concentration_Katy


# Final code for IV
conc$Year_Collected[which.min(conc$DNA_Concentration_Ben - conc$DNA_Concentration_Katy) ]


# V. Make a scatterplot of the downstairs lab
# Subset rows collected downstairs
conc$Lab == "Downstairs"
dow <- conc$Lab %in% c("Downstairs")
conc[dow,]
class(dow)
class(dow)
conc$Date_Collected <- as.POSIXct(conc$Date_Collected)
class(conc$Date_Collected)

d <- conc[c(104:200), c("Year_Collected", "Extract.Code", "Date_Collected", "DNA_Concentration_Katy", "DNA_Concentration_Ben", "Lab")]


#Recreate the plot
plot(x=d$Date_Collected,y=d$DNA_Concentration_Ben,
     xlab="Date_Collected", ylab="DNA_Concentration_Ben")


#Save the plot as a jpeg
jpeg("./Ben_DNA_over_time.jpg")
plot(x=d$Date_Collected,y=d$DNA_Concentration_Ben,
     xlab="Date_Collected", ylab="DNA_Concentration_Ben")
dev.off()

#End of Skills Test 4